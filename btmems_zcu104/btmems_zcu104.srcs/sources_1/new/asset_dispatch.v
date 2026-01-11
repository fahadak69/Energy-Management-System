`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Syed Fahad Akhtar 
// 
// Create Date: 11/25/2022 03:28:00 PM
// Design Name: 
// Module Name: asset_dispatch
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description:  Asset Dispatch Module
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created

//Logic Description:
//This module acts as asset dispatcher, getting commands from various control modes and deciding how to dispatch an asset

// Additional Comments: 
//1 - Mapping of Control Modes in usr_param_mode input:
//bit0: Peak Shaving
//bit1: Load Following
//2 - You will have to add the logic here for startup sequence in which you will need to set all the assets in correct mode when the EMS first starts. This includes (among other things):
//Setting Vref and Fref (equal to nominal) in GFM assets (BESS, Genset)
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

`include "defines.vh"

module asset_dispatch (
    input                               clkin,
    input                               arst_n,

    //BESS Interface
    input                       [31:0]  bess_p_pkshv,
    input                               bess_pvld_pkshv,
    input                       [31:0]  bess_p_ldflw,
    input                               bess_pvld_ldflw,
    output  reg signed          [31:0]  bess_p_w,           //to bess msi
    output  reg                         bess_pvld_w,        //to bess msi

    //PV Interface    
    input                       [31:0]  pv_p_expctl,        //from export control/peak shaving      
    input                               pv_pvld_expctl,     //from export control/peak shaving 
    input                       [31:0]  pv_p_isl,
    input                               pv_pisl_vld,
    output  reg signed          [31:0]  pv_p_w,           //to pv msi
    output  reg                         pv_pvld_w,        //to pv msi       

    //Misc
    input                               island_state_sig,      

    //Genset Interface
    input                               gen_gfmcmd,             //Genset Grid Forming Command
    input                               gen_gfmshut,            //Genset sutdown Command
    output reg                  [7:0]   gen_opmod_w,            //to genset msi
    output reg                          gen_opmodvld_w,         //to genset msi    
    output reg                          gen_run_w,              //to genset msi
    output reg                          gen_runvld_w,           //to genset msi
    

    //User Parameter Interface
    input                       [7:0]   usr_ctrl_mode,          //see Note 1 for mapping
    input                               usr_shut_down,          //system shut down command, +ve edge trig
    input                               usr_param_vld,      

    output                               usr_shutdown_1shot,
    output  reg                 [15:0]   sec_cntr   
    );

wire pps;

reg [26:0]  accum;
reg         usr_shutdown_reg;

assign pps = (accum == 27'd`PL_CLOCK_FREQ);
assign usr_shutdown_1shot = usr_shut_down && ~usr_shutdown_reg;

//usr_shutdown_reg
always @ (posedge clkin, negedge arst_n)
begin
    if (~arst_n)
        usr_shutdown_reg         <= #`adly 1'b0;
    else
        usr_shutdown_reg         <= #`adly usr_shut_down;
end


//Second Counter 
always @ (posedge clkin, negedge arst_n)
begin
    if (~arst_n)
    begin
        sec_cntr              <= #`adly 16'd0;
        accum                 <= #`adly 27'd0;
    end   
    else 
    begin
        accum                 <= #`adly  (pps ? 27'd0 : accum) + 27'd1; //reset clock cycle counter every second
        sec_cntr              <= #`adly  sec_cntr + (pps ? 16'd1 : 16'd0);//increment seconds count every second  
    end  
end 

always @ (posedge clkin or negedge arst_n)
begin
    if (~arst_n)
        bess_pvld_w   <= #`adly 1'b0;
     else
     begin
        case (usr_ctrl_mode)
        8'd1:
        begin
            bess_p_w        <= #`adly bess_p_pkshv;
            bess_pvld_w     <= #`adly bess_pvld_pkshv;
        end
        8'd2:
        begin
            bess_p_w        <= #`adly bess_p_ldflw;
            bess_pvld_w     <= #`adly bess_pvld_ldflw;
        end
        default:
        begin
            bess_p_w        <= #`adly bess_p_pkshv;
            bess_pvld_w     <= #`adly bess_pvld_pkshv;
        end
        endcase
     end
end


always @ (posedge clkin or negedge arst_n)
begin
    if (~arst_n)
        pv_pvld_w   <= #`adly 1'b0;
    else if (island_state_sig)
    begin
        pv_p_w        <= #`adly pv_p_isl;
        pv_pvld_w     <= #`adly pv_pisl_vld;
    end
    else
    begin
        pv_p_w        <= #`adly pv_p_expctl;
        pv_pvld_w     <= #`adly pv_pvld_expctl;
    end

end



//genset operaitng mode (base load, gfm) as well as run/shutdown command
always @ (posedge clkin, negedge arst_n)
begin
    if (~arst_n)
    begin
        gen_opmodvld_w      <= #`adly 1'b0;
        gen_runvld_w        <= #`adly 1'b0;
    end
    else if (gen_gfmshut && island_state_sig)
    begin
        gen_run_w         <= #`adly 1'b0;
        gen_runvld_w      <= #`adly 1'b1;
    end    
    else if (gen_gfmcmd && island_state_sig)
    begin  
        gen_opmod_w         <= #`adly {7'd0,1'b1};
        gen_opmodvld_w      <= #`adly 1'b1;

        gen_run_w         <= #`adly 1'b1; 
        gen_runvld_w      <= #`adly 1'b1;        
    end
    //Here you can add another condition for genset in baseload mode (as opposed to GFM) as required by LF or PS logic
    else
    begin
        gen_runvld_w      <= #`adly 1'b0;
        gen_opmodvld_w    <= #`adly 1'b0;
    end
end


endmodule
