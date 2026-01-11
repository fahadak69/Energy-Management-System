`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: SFA
// 
// Create Date: 03/23/2023 04:50:00 PM
// Design Name: 
// Module Name: relay_msi
// Project Name: MG EMS
// Target Devices: 
// Tool Versions: 
// Description: Manufacturer Specific Interface for POI protecion relay. This module maps OEM singals from the relay to signals used in core logic
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

`include "defines.vh"

module relay_msi(

    input                   clkin,
    input                   arst_n,

    //POI Relay Interface with pspl_bramctrl
    input                [31:0]  rly_protstat_r_psplbram,
    input                [31:0]  rly_ioltchsv_r_psplbram,
    input                [31:0]  rly_hwerr_r_psplbram,
    input                [15:0]  rly_lvab_r_psplbram,
    input                [15:0]  rly_lvbc_r_psplbram,
    input                [15:0]  rly_lvca_r_psplbram,
    input                [15:0]  rly_bvab_r_psplbram,
    input                [15:0]  rly_bvbc_r_psplbram,
    input                [15:0]  rly_bvca_r_psplbram,
    input                [15:0]  rly_lfrq_r_psplbram,
    input                [15:0]  rly_bfrq_r_psplbram,
    input                        rly_rdata_vld_psplbram,

    output                       rly_brkop_w_psplbram,
    output                       rly_brkopvld_w_psplbram,
    output                       rly_brkcl_w_psplbram,
    output                       rly_brkclvld_w_psplbram,

    //POI Relay Interface with core logic
     input                       rly_poibrkop_crlgc,
     input                       rly_brkopvld_w_crlgc,
     input                       rly_poibrkcl_crlgc,
     input                       rly_brkclvld_w_crlgc,
    
    // output              [31:0]  rly_protstat_r_corelogic,
    // output              [31:0]  rly_ioltchsv_r_corelogic,
    // output              [31:0]  rly_hwerr_r_corelogic,
    // output              [15:0]  rly_lvab_r_corelogic,
    // output              [15:0]  rly_lvbc_r_corelogic,
    // output              [15:0]  rly_lvca_r_corelogic,
    // output              [15:0]  rly_bvab_r_corelogic,
    // output              [15:0]  rly_bvbc_r_corelogic,
    // output              [15:0]  rly_bvca_r_corelogic,
    // output              [15:0]  rly_lfrq_r_corelogic,
    // output              [15:0]  rly_bfrq_r_corelogic,
    output                         rly_oc_prot,            //set if any OC protecticl in relay operates
    output                         poi_cb_op,
    output                         poi_cb_cl,
    output                         rly_rdata_vld_crlgc

    );

assign poi_cb_cl = rly_ioltchsv_r_psplbram[0];
assign poi_cb_op = ~rly_ioltchsv_r_psplbram[0];

assign rly_oc_prot = rly_protstat_r_psplbram[0];

    
 assign rly_brkop_w_psplbram             =   rly_poibrkop_crlgc;
 assign rly_brkopvld_w_psplbram          =   rly_brkopvld_w_crlgc;
 assign rly_brkcl_w_psplbram             =   rly_poibrkcl_crlgc;
 assign rly_brkclvld_w_psplbram          =   rly_brkclvld_w_crlgc;

// assign rly_protstat_r_corelogic         =   rly_protstat_r_psplbram;
// assign rly_ioltchsv_r_corelogic         =   rly_ioltchsv_r_psplbram;
// assign rly_hwerr_r_corelogic            =   rly_hwerr_r_psplbram;
// assign rly_lvab_r_corelogic             =   rly_lvab_r_psplbram;
// assign rly_lvbc_r_corelogic             =   rly_lvbc_r_psplbram;
// assign rly_lvca_r_corelogic             =   rly_lvca_r_psplbram;
// assign rly_bvab_r_corelogic             =   rly_bvab_r_psplbram;
// assign rly_bvbc_r_corelogic             =   rly_bvbc_r_psplbram;
// assign rly_bvca_r_corelogic             =   rly_bvca_r_psplbram;
// assign rly_lfrq_r_corelogic             =   rly_lfrq_r_psplbram;
// assign rly_bfrq_r_corelogic             =   rly_bfrq_r_psplbram;
 assign rly_rdata_vld_crlgc                =   rly_rdata_vld_psplbram;


    
endmodule
