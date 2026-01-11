`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: SFA
// 
// Create Date: 7/1/2023 10:36:00 AM
// Design Name: 
// Module Name: genset_msi
// Project Name: MG EMS
// Target Devices: 
// Tool Versions: 
// Description: Manufacturer Specific Interface for Genset. This module maps OEM singals from Genset to singals used in core logic
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

`include "defines.vh"

module genset_msi(
    input                   clkin,
    input                   arst_n,    

    //Interface with pspl_bramctrl
    input           [31:0]  gen_status_r_psplbram,
    input           [31:0]  gen_fault_r_psplbram,
    input                   gen_rdata_vld_psplbram,
    

    output                  gen_run_w_psplbram,
    output                  gen_runvld_w_psplbram,
    output          [31:0]  gen_p_w_psplbram,
    output                  gen_pvld_w_psplbram,
    output          [31:0]  gen_q_w_psplbram,
    output                  gen_qvld_w_psplbram,
    output          [7:0]   gen_opmod_w_psplbram,
    output                  gen_opmodvld_w_psplbram,

    //Interface with core logic
    input           [7:0]   gen_opmod_w_crlgc,
    input                   gen_opmodvld_w_crlgc,
    input                   gen_run_w_crlgc,
    input                   gen_runvld_w_crlgc,

    output reg              gen_flt_crlgc,
    output                  gen_gfm_stat_crlgc        

    );
    
assign gen_gfm_stat_crlgc       =       gen_status_r_psplbram[0];

//genset_flt_crlgc
always @ (posedge clkin, negedge arst_n)
begin
    if (~arst_n)
        gen_flt_crlgc         <= #`adly 1'b0;
    else
        gen_flt_crlgc         <= #`adly (gen_fault_r_psplbram!=8'd0);
end

assign gen_run_w_psplbram          =   gen_run_w_crlgc;
assign gen_runvld_w_psplbram       =   gen_runvld_w_crlgc;
assign gen_opmod_w_psplbram        =   gen_opmod_w_crlgc;
assign gen_opmodvld_w_psplbram     =   gen_opmodvld_w_crlgc;

endmodule
