`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: SFA
// 
// Create Date: 11/15/2020 09:46:12 AM
// Design Name: 
// Module Name: bess_msi
// Project Name: MG EMS
// Target Devices: 
// Tool Versions: 
// Description: Manufacturer Specific Interface for BESS. This module maps OEM singals from BESS to singals used in core logic
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

`include "defines.vh"

module bess_msi(
    input                   clkin,
    input                   arst_n,

    //Interface with pspl_bramctrl
    input                [6:0]   bess_status_r_psplbram,
    input                        bess_islandmode_r_psplbram,                
    input                [7:0]   bess_fault_r_psplbram,
    input                [31:0]  bess_soc_r_psplbram,
    input                [31:0]  bess_wh_r_psplbram,
    input                [31:0]  bess_maxdschgpwr_r_psplbram,
    input                [31:0]  bess_maxchgpwr_r_psplbram,
    input                [15:0]  bess_islandmodevolt_r_psplbram,
    input                [15:0]  bess_islandmodefrq_r_psplbram,
    input                        bess_rdata_vld_psplbram,

    output                       bess_run_w_psplbram,
    output                       bess_runvld_w_psplbram,
    output               [31:0]  bess_p_w_psplbram,
    output                       bess_pvld_w_psplbram,
    output               [31:0]  bess_q_w_psplbram,
    output               [15:0]  bess_pf_w_psplbram,
    output               [7:0]   bess_qtyp_w_psplbram,
    output     reg               bess_islandmode_w_psplbram,
    output     reg               bess_islandmodevld_w_psplbram,
    
    output               [15:0]  bess_islandmodefrq_w_psplbram,
    output                       bess_islandmodefrqvld_w_psplbram,    
    output               [15:0]  bess_islandmodevolt_w_psplbram,
    output                       bess_islandmodevolt_vld_w_psplbram,

    //Interface with core logic
    input                       bess_run_w_crlgc,
    input                       bess_runvld_w_crlgc,
    input               [31:0]  bess_p_w_crlgc,
    input                       bess_pvld_w_crlgc,
    input               [31:0]  bess_q_w_crlgc,
    input               [15:0]  bess_pf_w_crlgc,
    input               [7:0]   bess_qtyp_w_crlgc,
    input                       bess_gfmcmd_crlgc,
    input               [15:0]  bess_islandmodefrq_w_crlgc,
    input                       bess_islandmodefrqvld_w_crlgc,    
    input               [15:0]  bess_islandmodevolt_w_crlgc,
    input                       bess_islandmodevoltvld_w_crlgc,
    input                       bess_gfmexit_crlgc,

    output              [6:0]   bess_status_r_crlgc,
    output                      bess_gfm_stat_crlgc,
    output  reg                 bess_flt_crlgc,
    output              [31:0]  bess_soc_r_crlgc,
    output              [31:0]  bess_wh_r_crlgc, 
    output              [31:0]  bess_maxdschgpwr_r_crlgc,
    output              [31:0]  bess_maxchgpwr_r_crlgc,
    output              [15:0]  bess_islandmodevolt_r_crlgc,
    output              [15:0]  bess_islandmodefrq_r_crlgc,
    output                      bess_rdata_vld_crlgc


    );
    
    assign bess_status_r_crlgc                          = bess_status_r_psplbram;
    assign bess_gfm_stat_crlgc                          = bess_islandmode_r_psplbram;
    assign bess_soc_r_crlgc                             = bess_soc_r_psplbram;
    assign bess_maxdschgpwr_r_crlgc                     = bess_maxdschgpwr_r_psplbram;
    assign bess_maxchgpwr_r_crlgc                       = bess_maxchgpwr_r_psplbram;
    assign bess_rdata_vld_crlgc                         = bess_rdata_vld_psplbram;
    assign bess_wh_r_crlgc                              = bess_wh_r_psplbram;
    assign bess_islandmodevolt_r_crlgc                  = bess_islandmodevolt_r_psplbram;
    assign bess_islandmodefrq_r_crlgc                   = bess_islandmodefrq_r_psplbram;


    assign bess_run_w_psplbram                          =   bess_run_w_crlgc;
    assign bess_runvld_w_psplbram                       =   bess_runvld_w_crlgc;
    assign bess_p_w_psplbram                            =   bess_p_w_crlgc;
    assign bess_pvld_w_psplbram                         =   bess_pvld_w_crlgc;
    assign bess_q_w_psplbram                            =   bess_q_w_crlgc;
    assign bess_pf_w_psplbram                           =   bess_pf_w_crlgc;
    assign bess_qtyp_w_psplbram                         =   bess_qtyp_w_crlgc;
    assign bess_islandmodefrq_w_psplbram                =   bess_islandmodefrq_w_crlgc;
    assign bess_islandmodefrqvld_w_psplbram             =   bess_islandmodefrqvld_w_crlgc;  
    assign bess_islandmodevolt_w_psplbram               =   bess_islandmodevolt_w_crlgc;  
    assign bess_islandmodevolt_vld_w_psplbram           =   bess_islandmodevoltvld_w_crlgc; 



//bess_flt_crlgc
always @ (posedge clkin, negedge arst_n)
begin
    if (~arst_n)
        bess_flt_crlgc         <= #`adly 1'b0;
    else
        bess_flt_crlgc         <= #`adly (bess_fault_r_psplbram!=8'd0);
end

//bess island mode command, 0-GFL, 1-GFM
always @ (posedge clkin, negedge arst_n)
begin
    if (~arst_n)
    begin
        bess_islandmodevld_w_psplbram       <= #`adly 1'b0;
        bess_islandmode_w_psplbram          <= #`adly 1'b0;
    end
    else if (bess_gfmcmd_crlgc) 
    begin
        bess_islandmodevld_w_psplbram       <= #`adly 1'b1;
        bess_islandmode_w_psplbram          <= #`adly 1'b1;//GFM
    end
    else if (bess_gfmexit_crlgc)
    begin
        bess_islandmodevld_w_psplbram       <= #`adly 1'b1; 
        bess_islandmode_w_psplbram          <= #`adly 1'b0;//GFL
    end
    else
    begin
        bess_islandmodevld_w_psplbram       <= #`adly 1'b0;
        bess_islandmode_w_psplbram          <= #`adly 1'b0;
    end    
end

endmodule
