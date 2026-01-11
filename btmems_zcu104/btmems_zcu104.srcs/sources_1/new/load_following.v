`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Syed Fahad Akhtar 
// 
// Create Date: 11/23/2022 11:05:00 PM
// Design Name: 
// Module Name: load_following
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description:  Load Following Module
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created

//Logic Description:
//This code is for load following where the BESS tries to maintain a defined net load (+ve or -ve) at POI 

// Additional Comments: 
// 1- For correct operation, reference values, feedback value, max and min limit must all be same unit (watts or kw or MW etc). Type of unit to be determined from 
// external device modbus mapping
// 2- PID IP I have generated is 32bit fixed point with 7bit for fraction part and 25bit (incl. sign bit) for integer part. Fraction bits are only to enable decimal 
// kp/ki/kd gains. All other values crossing CPU domain must be integers else CPU will intrepret them as floating point. 
// 3- kp/ki/kd values are entered by the user (via HMI or webpage etc) in the decimal (up to 2 decimal places). In software, multiply user entered kp/ki/kd values by 128 
// (which is the value closest to 100 in terms of power of 2) and change from float to int data type. This will truncate the decimal portion of the modified kp/ki/kd 
// values (loss of accuracy is minimal I have checked). Then shift left by 7 bits (so multiply again by 128) to convert to fixed point format used here. Note that inside
// the PID IP, I divide these gains by 128 to get original user entered value
// 4- For utility, import reading from the meter should be +ve
// 5- For BESS and PV, generator sign convention is used, so discharge is +ve
// 6- 
// 7- Integer to fixed point and vice versa conversion for CPU is handled here
// 8- One of the assumptions is that once input data form an asset becomes valid, it will stay latched until next valid. Also two consecutive valids (input or output) 
// will be separated by many cycles due to readback delay of external comm interface such as MODBUS
// 9 - the scaling of usr_bess_maxsoc, usr_bess_minsoc input and bess_soc_r must match be the same coming from CPU. Also this can be SoC or SoE, logic will be same
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

`include "defines.vh"

module load_following (
    input                   clkin,
    input                   arst_n,
    
    //POI Meter Interface
    input  signed   [31:0]  meter_poi_3p,       //sign convention: -ve for export to utility
    input                   meter_rdata_vld,

    //BESS INTERFACE
    input                       [31:0]  bess_soc_r,         //Note 9
    input       signed          [31:0]  bess_maxdschgpwr_r, //sign convention: +ve
    input       signed          [31:0]  bess_maxchgpwr_r,   //sign convention: +ve
    input                               bess_rdata_vld,
    output  reg signed          [31:0]  bess_p_w,           //sign convention: -ve for charge command
    output  reg                         bess_pvld_w,                             
    

    //User Parameter Interface
    input  signed   [31:0]  usr_net_load,       //sign convention: +ve for net import, -ve for net export. Must be integer only (if not integer, these values coming from cpu will be in floating point format)
    input  signed   [31:0]  usr_besschrg_lmt,   //sign convention: +ve values. (e.g value 5000Watts). Must be integer only 
    input  signed   [31:0]  usr_bessdsch_lmt,   //sign convention: +ve values. (e.g value 5000Watts). Must be integer only
    input  signed   [31:0]  usr_bess_kp,        //sign convention: +ve values. 
    input  signed   [31:0]  usr_bess_ki,        //sign convention: +ve values.
    input  signed   [31:0]  usr_bess_kd,        //sign convention: +ve values.
    input  signed   [31:0]  usr_bess_maxsoc,    //sign convention: +ve values. (e.g value 100). Must be integer only. Note 9
    input  signed   [31:0]  usr_bess_minsoc,    //sign convention: +ve values. (e.g value 2). Must be integer only. Note 9
    input           [7:0]  usr_ctrl_mode,
    input                   usr_bess_en,
    input                   usr_pv_en,
    input                   usr_param_vld      
    
    );

wire ap_ready;
wire bess_ap_done;
wire signed [31:0] dout_0_V;
wire signed [31:0] dout_err_BESS;
wire signed [31:0] dout_0_Vtmp;
wire signed [31:0] lf_chrg_lmt_fxp;
wire signed [31:0] lf_dschrg_lmt_fxp; 
wire signed [31:0] lf_chrg_lmtfxp_err;
wire signed [31:0] lf_dschrg_lmtfxp_err; 
wire signed [31:0] usr_netload_fxp; 
wire signed [31:0] meter_poi3p_fxp;

reg pid_en;
reg meter_rdatavld_reg;
reg bess_ap_done_reg;
reg pid_rst;

reg signed [31:0]  lf_chrg_lmt;
reg signed [31:0]  dout_0_V1;
reg signed [31:0]  lf_dschrg_lmt;
reg signed [31:0]  lf_dschrg_lmt2;
reg signed [31:0]  dout_0_bess;
reg signed [31:0]  dout_0_bess_prv;
reg signed [31:0]  usr_bess_ki_reg;
reg                usr_bess_ki_reg_init;
reg signed [31:0]  dout_err_BESS_reg;

assign lf_chrg_lmt_fxp = {lf_chrg_lmt[24:0],7'd0};

assign lf_dschrg_lmt_fxp = {lf_dschrg_lmt2[24:0],7'd0};

assign usr_netload_fxp = {usr_net_load[24:0],7'd0};

assign meter_poi3p_fxp = {meter_poi_3p[24:0],7'd0};


always @ (posedge clkin or negedge arst_n)
begin
    if (~arst_n)
        meter_rdatavld_reg   <= #`adly 1'b0;
    else
        meter_rdatavld_reg   <= #`adly meter_rdata_vld;
end

always @ (posedge clkin or negedge arst_n)
begin
    if (~arst_n)
    begin
        pid_en   <= #`adly 1'b0;
    end
    else if (ap_ready || (usr_ctrl_mode!=8'd2) || ~usr_bess_en)
    begin
        pid_en   <= #`adly 1'b0;    //deasserting to pause PID until next feedback data valid arrives OR user control mode is not load following
                                    //pid_en can also be made a 1shot signal, sysgen simulation confirms correct operation with 1shot. Test it in an actual setup to be sure
    end
    else if (meter_rdata_vld)
    begin
        pid_en   <= #`adly meter_rdata_vld; 
    end   
end  

always @ (posedge clkin or negedge arst_n)
begin
    if (~arst_n)
    begin
        pid_rst   <= #`adly 1'b0;
    end
    else 
    begin
        pid_rst   <= #`adly ~((usr_ctrl_mode!=8'd2) || ~usr_bess_en); 
    end 
end 

//Charge limit for Load Follow PID Output 
always @(posedge clkin or negedge arst_n) begin
    if (~arst_n)
        lf_chrg_lmt <= #`adly 32'd0;
    else if (bess_soc_r >= usr_bess_maxsoc) 
        lf_chrg_lmt <= #`adly 32'd0;
    else if (usr_besschrg_lmt < bess_maxchgpwr_r)
        lf_chrg_lmt <= #`adly usr_besschrg_lmt;
    else
        lf_chrg_lmt <= #`adly bess_maxchgpwr_r;

end

//Discharge limit for Load Follow PID Output
always @(posedge clkin or negedge arst_n) begin
    if (~arst_n)
        lf_dschrg_lmt <= #`adly 32'd0;
    else if (bess_soc_r <= usr_bess_minsoc)
        lf_dschrg_lmt <= #`adly 32'd0;
    else if (usr_bessdsch_lmt < bess_maxdschgpwr_r)
        lf_dschrg_lmt <= #`adly usr_bessdsch_lmt; 
    else 
        lf_dschrg_lmt <= #`adly bess_maxdschgpwr_r;
end

//Changing to 2's complement (discahrge limit to PID needs to be -ve)
always @(posedge clkin or negedge arst_n) begin
    if (~arst_n)
        lf_dschrg_lmt2 <= #`adly 32'sd0;
    else 
        lf_dschrg_lmt2 <= #`adly (~lf_dschrg_lmt) + 32'sd1; //lf_dschrg_lmt * (-32'sd1);
end

//*********************************
//- flipping PID output sign per bess generator sign convention (i.e. +ve cmd is discharge)
//- Truncating decimal part (accuracy loss is neglibigble since command is in Watts (not kw))
//- Changing from fixed point represenation back to normal integer represenation (for CPU)

//truncating fixed point to integer
assign dout_0_Vtmp[24:0] = dout_0_V[31:7]; 
genvar j;
generate
    for (j = 25; j < 32; j = j + 1) begin: genj
        assign dout_0_Vtmp[j] = dout_0_V[31]; //padding remaining bits with sign bit
    end
endgenerate

//inverting bits as part of 2's complement process
genvar i;
generate
    for (i = 0; i < 32; i = i + 1) begin: geni
        always @(*) begin
             dout_0_V1[i]   <= ~dout_0_Vtmp[i]; 
        end
    end
endgenerate

//adding 1 as part of 2's complement
always @(posedge clkin or negedge arst_n) begin
    if (~arst_n)
        dout_0_bess <= #`adly 32'sd0;
    else if (dout_0_V[31:7]==25'sd0) //if integer part is zero from PID, keep it zero  (if integer part is all 1, such as for -0.3, all 1s will be inverted to zero anyway)
        dout_0_bess <= #`adly 32'sd0;        
    else if ((dout_0_V[6:0]==7'sd0) || (dout_0_V[31]==1'sb0))
        dout_0_bess <= #`adly dout_0_V1 + 32'sd1;  //adding 1 to flip PID output sign (in  2's complement representation) 
    else
        dout_0_bess <= #`adly dout_0_V1;  //if decimal part is non-zero and interger part is -ve, integer part from PID is in 1's complement 
                                       //(not sure why but I confirmed from Sysgen). So a -ve number will be sign flipped to +ve just by inverting the bits
end

always @(posedge clkin or negedge arst_n) begin
    if (~arst_n)
        bess_p_w <= #`adly 32'sd0;
    else
        bess_p_w <= #`adly dout_0_bess;
end

always @(posedge clkin or negedge arst_n) begin
    if (~arst_n)
        dout_0_bess_prv <= #`adly 32'sd0;//usr_bessdsch_lmt + 1'sd1/*32'sd0*/; //resetting to a value that can never occur. A valid value should only be transfered when bess_pvld_w is asserted
                                                                      //If its reset to zero instead, shifting from peak shaving to load following (and vice versa) sometimes cause issues
    else if (usr_ctrl_mode!=8'd2)
        dout_0_bess_prv <= #`adly usr_bessdsch_lmt + 1'sd1;
    else if(bess_pvld_w)
        dout_0_bess_prv <= #`adly bess_p_w;
end

always @(posedge clkin or negedge arst_n) begin
    if (~arst_n)
        bess_ap_done_reg <= #`adly 1'b0;
    else
        bess_ap_done_reg <= #`adly bess_ap_done;
end

always @(posedge clkin or negedge arst_n) begin
    if (~arst_n)
        dout_err_BESS_reg <= #`adly 32'sd0;
    else
        dout_err_BESS_reg <= #`adly dout_err_BESS; 
end

always @(posedge clkin or negedge arst_n) begin
    if (~arst_n)
        bess_pvld_w <= #`adly 1'b0;
    else 
        bess_pvld_w <= #`adly (dout_err_BESS_reg!=32'sd0) & bess_ap_done_reg; //assert valid only when error is non-zero
end

always @(posedge clkin or negedge arst_n) begin
    if (~arst_n)
    begin
        usr_bess_ki_reg       <= #`adly 32'sd0;
        usr_bess_ki_reg_init  <= #`adly 1'b0;
    end
    else if (~usr_bess_ki_reg_init)
    begin
        usr_bess_ki_reg       <= #`adly usr_bess_ki;
        usr_bess_ki_reg_init  <= #`adly 1'b1;
    end    
    else if (bess_ap_done)
        usr_bess_ki_reg <= #`adly ((dout_0_V==lf_chrg_lmt_fxp) || (dout_0_V==lf_dschrg_lmt_fxp)) ? 32'sd0 : usr_bess_ki; //disabling Integral whenn output saturates (an alternative way to implement anti-windup)
end

//***********************************
    PID_Fxd7bFr PID_Fxd7bFr_instBESS (
        .ap_start   (pid_en),                         
        .ap_done    (bess_ap_done),
        .ap_idle    (),
        .ap_ready   (ap_ready),
        .ap_clk     (clkin),
        .ap_rst     (~pid_rst),
        .ap_ce      (1'b1),
        .InitN      (pid_rst),
        .coeff_0_V  (usr_bess_ki_reg),           //Ki
        .coeff_1_V  (usr_bess_kd),               //Kd
        .coeff_2_V  (32'd0),                    //Constant (initial value)
        .coeff_3_V  (usr_bess_kp),               //Kp
        .coeff_4_V  (lf_chrg_lmt_fxp),          //max limit (charge signal)
        .coeff_5_V  (lf_dschrg_lmt_fxp),        //min limit (discharge signal) 
        .coeff_6_V  (lf_chrg_lmt_fxp),          //max limit for error and integrator
        .coeff_7_V  (lf_dschrg_lmt_fxp),        //min limit for error and integrator  
        .din_0_V    (usr_netload_fxp),           //reference  
        .din_1_V    (meter_poi3p_fxp),          //feedback
        .dout_0_V   (dout_0_V),                 //control signal output
        .dout_1_V   (dout_err_BESS)             //error signal output 

    ); 

endmodule
