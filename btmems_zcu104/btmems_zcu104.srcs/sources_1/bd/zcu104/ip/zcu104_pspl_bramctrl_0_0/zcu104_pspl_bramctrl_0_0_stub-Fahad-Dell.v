// Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2019.2 (win64) Build 2708876 Wed Nov  6 21:40:23 MST 2019
// Date        : Sat Apr 23 22:21:08 2022
// Host        : Fahad-Dell running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               C:/Users/fahad/OneDrive/FPGA_SoC_Development/Working/btmems_zcu104/btmems_zcu104.srcs/sources_1/bd/zcu104/ip/zcu104_pspl_bramctrl_0_0/zcu104_pspl_bramctrl_0_0_stub.v
// Design      : zcu104_pspl_bramctrl_0_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xczu7ev-ffvc1156-2-e
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* X_CORE_INFO = "pspl_bramctrl,Vivado 2019.2" *)
module zcu104_pspl_bramctrl_0_0(clkin, arst_n, bess_bram_rdataflg, 
  pv_bram_rdataflg, meter_bram_rdataflg, usrparam_bram_rdataflg, bram_addr, bram_din, 
  bram_dout, bram_enb, bram_web, pspl_wcmd_bsy, bramw_addr, bramw_din, bramw_dout, bramw_enb, 
  bramw_web, wcmd_sig, bess_run_w, bess_p_w, bess_pvld_w, bess_q_w, bess_pf_w, bess_qtyp_w, 
  bess_islandmode_w, bess_islandmodefrq_w, bess_islandmodevolt_pu_w, bess_status_r, 
  bess_islandmode_r, bess_fault_r, bess_soc_r, bess_maxdschgpwr_r, bess_maxchgpwr_r, 
  bess_rdata_vld, pv_run_w, pv_p_w, pv_pvld_w, pv_q_w, pv_pf_w, pv_qtyp_w, pv_status_r, pv_fault_r, 
  pv_wattsp_r, pv_watt_r, pv_var_r, pv_yield_r, pv_rdata_vld, meter_poi_3p, meter_poi_3q, 
  meter_poi_3s, meter_poi_pf, meter_poi_ia, meter_poi_ib, meter_poi_ic, meter_poi_in, 
  meter_poi_vab, meter_poi_vbc, meter_poi_vca, meter_poi_freq, meter_rdata_vld, usr_imp_lmt, 
  usr_exp_lmt, usr_besschrg_lmt, usr_bessdsch_lmt, usr_bess_kp, usr_bess_ki, usr_bess_kd, 
  usr_pv_kp, usr_pv_ki, usr_pv_kd, usr_bess_maxsoc, usr_bess_minsoc, usr_pv_max, usr_exp_prio, 
  usr_bess_en, usr_pv_en, usr_param_vld)
/* synthesis syn_black_box black_box_pad_pin="clkin,arst_n,bess_bram_rdataflg,pv_bram_rdataflg,meter_bram_rdataflg,usrparam_bram_rdataflg,bram_addr[31:0],bram_din[31:0],bram_dout[31:0],bram_enb,bram_web[3:0],pspl_wcmd_bsy,bramw_addr[31:0],bramw_din[31:0],bramw_dout[31:0],bramw_enb,bramw_web[3:0],wcmd_sig[31:0],bess_run_w,bess_p_w[31:0],bess_pvld_w,bess_q_w[31:0],bess_pf_w[15:0],bess_qtyp_w[7:0],bess_islandmode_w,bess_islandmodefrq_w[15:0],bess_islandmodevolt_pu_w[7:0],bess_status_r[6:0],bess_islandmode_r,bess_fault_r[7:0],bess_soc_r[31:0],bess_maxdschgpwr_r[31:0],bess_maxchgpwr_r[31:0],bess_rdata_vld,pv_run_w,pv_p_w[31:0],pv_pvld_w,pv_q_w[31:0],pv_pf_w[15:0],pv_qtyp_w[7:0],pv_status_r[7:0],pv_fault_r[7:0],pv_wattsp_r[31:0],pv_watt_r[31:0],pv_var_r[31:0],pv_yield_r[31:0],pv_rdata_vld,meter_poi_3p[31:0],meter_poi_3q[31:0],meter_poi_3s[31:0],meter_poi_pf[31:0],meter_poi_ia[31:0],meter_poi_ib[31:0],meter_poi_ic[31:0],meter_poi_in[31:0],meter_poi_vab[31:0],meter_poi_vbc[31:0],meter_poi_vca[31:0],meter_poi_freq[31:0],meter_rdata_vld,usr_imp_lmt[31:0],usr_exp_lmt[31:0],usr_besschrg_lmt[31:0],usr_bessdsch_lmt[31:0],usr_bess_kp[31:0],usr_bess_ki[31:0],usr_bess_kd[31:0],usr_pv_kp[31:0],usr_pv_ki[31:0],usr_pv_kd[31:0],usr_bess_maxsoc[31:0],usr_bess_minsoc[31:0],usr_pv_max[31:0],usr_exp_prio,usr_bess_en,usr_pv_en,usr_param_vld" */;
  input clkin;
  input arst_n;
  input bess_bram_rdataflg;
  input pv_bram_rdataflg;
  input meter_bram_rdataflg;
  input usrparam_bram_rdataflg;
  output [31:0]bram_addr;
  input [31:0]bram_din;
  output [31:0]bram_dout;
  output bram_enb;
  output [3:0]bram_web;
  input pspl_wcmd_bsy;
  output [31:0]bramw_addr;
  input [31:0]bramw_din;
  output [31:0]bramw_dout;
  output bramw_enb;
  output [3:0]bramw_web;
  output [31:0]wcmd_sig;
  input bess_run_w;
  input [31:0]bess_p_w;
  input bess_pvld_w;
  input [31:0]bess_q_w;
  input [15:0]bess_pf_w;
  input [7:0]bess_qtyp_w;
  input bess_islandmode_w;
  input [15:0]bess_islandmodefrq_w;
  input [7:0]bess_islandmodevolt_pu_w;
  output [6:0]bess_status_r;
  output bess_islandmode_r;
  output [7:0]bess_fault_r;
  output [31:0]bess_soc_r;
  output [31:0]bess_maxdschgpwr_r;
  output [31:0]bess_maxchgpwr_r;
  output bess_rdata_vld;
  input pv_run_w;
  input [31:0]pv_p_w;
  input pv_pvld_w;
  input [31:0]pv_q_w;
  input [15:0]pv_pf_w;
  input [7:0]pv_qtyp_w;
  output [7:0]pv_status_r;
  output [7:0]pv_fault_r;
  output [31:0]pv_wattsp_r;
  output [31:0]pv_watt_r;
  output [31:0]pv_var_r;
  output [31:0]pv_yield_r;
  output pv_rdata_vld;
  output [31:0]meter_poi_3p;
  output [31:0]meter_poi_3q;
  output [31:0]meter_poi_3s;
  output [31:0]meter_poi_pf;
  output [31:0]meter_poi_ia;
  output [31:0]meter_poi_ib;
  output [31:0]meter_poi_ic;
  output [31:0]meter_poi_in;
  output [31:0]meter_poi_vab;
  output [31:0]meter_poi_vbc;
  output [31:0]meter_poi_vca;
  output [31:0]meter_poi_freq;
  output meter_rdata_vld;
  output [31:0]usr_imp_lmt;
  output [31:0]usr_exp_lmt;
  output [31:0]usr_besschrg_lmt;
  output [31:0]usr_bessdsch_lmt;
  output [31:0]usr_bess_kp;
  output [31:0]usr_bess_ki;
  output [31:0]usr_bess_kd;
  output [31:0]usr_pv_kp;
  output [31:0]usr_pv_ki;
  output [31:0]usr_pv_kd;
  output [31:0]usr_bess_maxsoc;
  output [31:0]usr_bess_minsoc;
  output [31:0]usr_pv_max;
  output usr_exp_prio;
  output usr_bess_en;
  output usr_pv_en;
  output usr_param_vld;
endmodule
