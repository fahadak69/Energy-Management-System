`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Electric Avenue 
// Engineer: SFA    
// 
// Create Date: 11/15/2020 09:36:15 AM
// Design Name: 
// Module Name: pv_msi
// Project Name: MG EMS
// Target Devices: 
// Tool Versions: 
// Description: Manufacturer Specific Interface for PV. This module maps OEM singals from PV to singals used in core logic
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

`include "defines.vh"

module pv_msi(
    input                   clkin,
    input                   arst_n,

//Interface with pspl_bramctrl module
    input                [31:0]   pv_status_r_psplbram,
    input                [31:0]   pv_fault_r_psplbram,
    input                [31:0]  pv_wattsp_r_psplbram,
    input                [31:0]  pv_watt_r_psplbram,
    input                [31:0]  pv_var_r_psplbram,
    input                [31:0]  pv_yield_r_psplbram,
    input                        pv_rdata_vld_psplbram,

    output                       pv_run_w_psplbram,
    output                       pv_runvld_w_psplbram,
    output               [31:0]  pv_p_w_psplbram,
    output                       pv_pvld_w_psplbram,
    output               [31:0]  pv_q_w_psplbram,
    output               [15:0]  pv_pf_w_psplbram,
    output               [7:0]   pv_qtyp_w_psplbram,


 //Interface with core logic   
    input                       pv_run_w_corelogic,
    input                       pv_runvld_w_corelogic,
    input               [31:0]  pv_p_w_corelogic,
    input                       pv_pvld_w_corelogic,
    input               [31:0]  pv_q_w_corelogic,
    input               [15:0]  pv_pf_w_corelogic,
    input               [7:0]   pv_qtyp_w_corelogic,

    output              [31:0]  pv_status_r_corelogic,
    output              [31:0]  pv_fault_r_corelogic,
    output              [31:0]  pv_wattsp_r_corelogic,
    output              [31:0]  pv_watt_r_corelogic,
    output              [31:0]  pv_var_r_corelogic,
    output              [31:0]  pv_yield_r_corelogic,
    output                      pv_rdata_vld_corelogic
    );

    assign pv_status_r_corelogic = pv_status_r_psplbram;
    assign pv_fault_r_corelogic = pv_fault_r_psplbram;
    assign pv_wattsp_r_corelogic = pv_wattsp_r_psplbram;
    assign pv_watt_r_corelogic = pv_watt_r_psplbram;
    assign pv_var_r_corelogic = pv_var_r_psplbram;
    assign pv_yield_r_corelogic = pv_yield_r_psplbram;
    assign pv_rdata_vld_corelogic = pv_rdata_vld_psplbram;

    assign pv_run_w_psplbram = pv_run_w_corelogic;
    assign pv_runvld_w_psplbram = pv_runvld_w_corelogic;
    assign pv_p_w_psplbram = pv_p_w_corelogic;
    assign pv_pvld_w_psplbram = pv_pvld_w_corelogic;
    assign pv_q_w_psplbram = pv_q_w_corelogic;
    assign pv_pf_w_psplbram = pv_pf_w_corelogic;
    assign pv_qtyp_w_psplbram = pv_qtyp_w_corelogic;

endmodule
