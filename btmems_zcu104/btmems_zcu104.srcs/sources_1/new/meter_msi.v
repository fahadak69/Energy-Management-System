`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: SFA
// 
// Create Date: 03/23/2023 02:43:00 PM
// Design Name: 
// Module Name: meter_msi
// Project Name: MG EMS
// Target Devices: 
// Tool Versions: 
// Description: Manufacturer Specific Interface for Meter data. This module maps OEM singals from various meters to signals used in core logic
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

`include "defines.vh"

module meter_msi(

    //BESS Meter Interface with pspl_bramctrl
    input          [31:0]  meter_bess_3p_psplbram,
    //BESS Meter Interface with core logic
    output         [31:0]  meter_bess_3p_crlgc,
    output                 meter_bess_rdatavld_crlgc,

    //PV Meter Interface with pspl_bramctrl
    input           [31:0]  meter_pv_3p_psplbram,
    //PV Meter Interface with core logic 
    output          [31:0]  meter_pv_3p_crlgc,
    output                  meter_pv_rdatavld_crlgc,
    
    //Genset Meter Interface with pspl_bramctrl
    input          [31:0]   meter_gen_3p_psplbram,
    //Genset Meter Interface with corelogic
    output         [31:0]   meter_gen_3p_crlgc,
    output                  meter_gen_rdatavld_crlgc,         

    //Load Meter Interface with pspl_bramctrl

    //POI Meter Interface with pspl_bramctrl
    input          [31:0]  meter_poi_3p_psplbram,
    input          [31:0]  meter_poi_3q_psplbram,
    input          [31:0]  meter_poi_3s_psplbram,
    input          [31:0]  meter_poi_pf_psplbram,
    input          [31:0]  meter_poi_ia_psplbram,
    input          [31:0]  meter_poi_ib_psplbram,
    input          [31:0]  meter_poi_ic_psplbram,
    input          [31:0]  meter_poi_in_psplbram,
    input          [31:0]  meter_poi_vab_psplbram,
    input          [31:0]  meter_poi_vbc_psplbram,
    input          [31:0]  meter_poi_vca_psplbram,
    input          [31:0]  meter_poi_freq_psplbram,
    input                  meter_rdata_vld_psplbram,

    //POI Meter Interface with core logic
    output          [31:0]  meter_poi_3p_crlgc,
    output          [31:0]  meter_poi_3q_crlgc,
    output          [31:0]  meter_poi_3s_crlgc,
    output          [31:0]  meter_poi_pf_crlgc,
    output          [31:0]  meter_poi_ia_crlgc,
    output          [31:0]  meter_poi_ib_crlgc,
    output          [31:0]  meter_poi_ic_crlgc,
    output          [31:0]  meter_poi_in_crlgc,
    output          [31:0]  meter_poi_vab_crlgc,
    output          [31:0]  meter_poi_vbc_crlgc,
    output          [31:0]  meter_poi_vca_crlgc,
    output          [31:0]  meter_poi_freq_crlgc,
    output                  meter_poi_rdatavld_crlgc

    );
    
assign meter_poi_3p_crlgc               =   meter_poi_3p_psplbram;
assign meter_poi_3q_crlgc               =   meter_poi_3q_psplbram;
assign meter_poi_3s_crlgc               =   meter_poi_3s_psplbram;
assign meter_poi_pf_crlgc               =   meter_poi_pf_psplbram;
assign meter_poi_ia_crlgc               =   meter_poi_ia_psplbram;
assign meter_poi_ib_crlgc               =   meter_poi_ib_psplbram;
assign meter_poi_ic_crlgc               =   meter_poi_ic_psplbram;
assign meter_poi_in_crlgc               =   meter_poi_in_psplbram;
assign meter_poi_vab_crlgc              =   meter_poi_vab_psplbram;
assign meter_poi_vbc_crlgc              =   meter_poi_vbc_psplbram;
assign meter_poi_vca_crlgc              =   meter_poi_vca_psplbram;
assign meter_poi_freq_crlgc             =   meter_poi_freq_psplbram;
assign meter_poi_rdatavld_crlgc         =   meter_rdata_vld_psplbram;

assign meter_bess_3p_crlgc              =   meter_bess_3p_psplbram;
assign meter_bess_rdatavld_crlgc        =   meter_rdata_vld_psplbram;

assign meter_gen_3p_crlgc              =   meter_gen_3p_psplbram;
assign meter_gen_rdatavld_crlgc        =   meter_rdata_vld_psplbram;

assign meter_pv_3p_crlgc               =   meter_pv_3p_psplbram;
assign meter_pv_rdatavld_crlgc         =   meter_rdata_vld_psplbram;

    
endmodule
