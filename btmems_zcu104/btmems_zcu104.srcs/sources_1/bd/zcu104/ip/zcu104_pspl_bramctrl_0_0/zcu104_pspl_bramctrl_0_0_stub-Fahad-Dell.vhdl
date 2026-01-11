-- Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2019.2 (win64) Build 2708876 Wed Nov  6 21:40:23 MST 2019
-- Date        : Sat Apr 23 22:21:08 2022
-- Host        : Fahad-Dell running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode synth_stub
--               C:/Users/fahad/OneDrive/FPGA_SoC_Development/Working/btmems_zcu104/btmems_zcu104.srcs/sources_1/bd/zcu104/ip/zcu104_pspl_bramctrl_0_0/zcu104_pspl_bramctrl_0_0_stub.vhdl
-- Design      : zcu104_pspl_bramctrl_0_0
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xczu7ev-ffvc1156-2-e
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity zcu104_pspl_bramctrl_0_0 is
  Port ( 
    clkin : in STD_LOGIC;
    arst_n : in STD_LOGIC;
    bess_bram_rdataflg : in STD_LOGIC;
    pv_bram_rdataflg : in STD_LOGIC;
    meter_bram_rdataflg : in STD_LOGIC;
    usrparam_bram_rdataflg : in STD_LOGIC;
    bram_addr : out STD_LOGIC_VECTOR ( 31 downto 0 );
    bram_din : in STD_LOGIC_VECTOR ( 31 downto 0 );
    bram_dout : out STD_LOGIC_VECTOR ( 31 downto 0 );
    bram_enb : out STD_LOGIC;
    bram_web : out STD_LOGIC_VECTOR ( 3 downto 0 );
    pspl_wcmd_bsy : in STD_LOGIC;
    bramw_addr : out STD_LOGIC_VECTOR ( 31 downto 0 );
    bramw_din : in STD_LOGIC_VECTOR ( 31 downto 0 );
    bramw_dout : out STD_LOGIC_VECTOR ( 31 downto 0 );
    bramw_enb : out STD_LOGIC;
    bramw_web : out STD_LOGIC_VECTOR ( 3 downto 0 );
    wcmd_sig : out STD_LOGIC_VECTOR ( 31 downto 0 );
    bess_run_w : in STD_LOGIC;
    bess_p_w : in STD_LOGIC_VECTOR ( 31 downto 0 );
    bess_pvld_w : in STD_LOGIC;
    bess_q_w : in STD_LOGIC_VECTOR ( 31 downto 0 );
    bess_pf_w : in STD_LOGIC_VECTOR ( 15 downto 0 );
    bess_qtyp_w : in STD_LOGIC_VECTOR ( 7 downto 0 );
    bess_islandmode_w : in STD_LOGIC;
    bess_islandmodefrq_w : in STD_LOGIC_VECTOR ( 15 downto 0 );
    bess_islandmodevolt_pu_w : in STD_LOGIC_VECTOR ( 7 downto 0 );
    bess_status_r : out STD_LOGIC_VECTOR ( 6 downto 0 );
    bess_islandmode_r : out STD_LOGIC;
    bess_fault_r : out STD_LOGIC_VECTOR ( 7 downto 0 );
    bess_soc_r : out STD_LOGIC_VECTOR ( 31 downto 0 );
    bess_maxdschgpwr_r : out STD_LOGIC_VECTOR ( 31 downto 0 );
    bess_maxchgpwr_r : out STD_LOGIC_VECTOR ( 31 downto 0 );
    bess_rdata_vld : out STD_LOGIC;
    pv_run_w : in STD_LOGIC;
    pv_p_w : in STD_LOGIC_VECTOR ( 31 downto 0 );
    pv_pvld_w : in STD_LOGIC;
    pv_q_w : in STD_LOGIC_VECTOR ( 31 downto 0 );
    pv_pf_w : in STD_LOGIC_VECTOR ( 15 downto 0 );
    pv_qtyp_w : in STD_LOGIC_VECTOR ( 7 downto 0 );
    pv_status_r : out STD_LOGIC_VECTOR ( 7 downto 0 );
    pv_fault_r : out STD_LOGIC_VECTOR ( 7 downto 0 );
    pv_wattsp_r : out STD_LOGIC_VECTOR ( 31 downto 0 );
    pv_watt_r : out STD_LOGIC_VECTOR ( 31 downto 0 );
    pv_var_r : out STD_LOGIC_VECTOR ( 31 downto 0 );
    pv_yield_r : out STD_LOGIC_VECTOR ( 31 downto 0 );
    pv_rdata_vld : out STD_LOGIC;
    meter_poi_3p : out STD_LOGIC_VECTOR ( 31 downto 0 );
    meter_poi_3q : out STD_LOGIC_VECTOR ( 31 downto 0 );
    meter_poi_3s : out STD_LOGIC_VECTOR ( 31 downto 0 );
    meter_poi_pf : out STD_LOGIC_VECTOR ( 31 downto 0 );
    meter_poi_ia : out STD_LOGIC_VECTOR ( 31 downto 0 );
    meter_poi_ib : out STD_LOGIC_VECTOR ( 31 downto 0 );
    meter_poi_ic : out STD_LOGIC_VECTOR ( 31 downto 0 );
    meter_poi_in : out STD_LOGIC_VECTOR ( 31 downto 0 );
    meter_poi_vab : out STD_LOGIC_VECTOR ( 31 downto 0 );
    meter_poi_vbc : out STD_LOGIC_VECTOR ( 31 downto 0 );
    meter_poi_vca : out STD_LOGIC_VECTOR ( 31 downto 0 );
    meter_poi_freq : out STD_LOGIC_VECTOR ( 31 downto 0 );
    meter_rdata_vld : out STD_LOGIC;
    usr_imp_lmt : out STD_LOGIC_VECTOR ( 31 downto 0 );
    usr_exp_lmt : out STD_LOGIC_VECTOR ( 31 downto 0 );
    usr_besschrg_lmt : out STD_LOGIC_VECTOR ( 31 downto 0 );
    usr_bessdsch_lmt : out STD_LOGIC_VECTOR ( 31 downto 0 );
    usr_bess_kp : out STD_LOGIC_VECTOR ( 31 downto 0 );
    usr_bess_ki : out STD_LOGIC_VECTOR ( 31 downto 0 );
    usr_bess_kd : out STD_LOGIC_VECTOR ( 31 downto 0 );
    usr_pv_kp : out STD_LOGIC_VECTOR ( 31 downto 0 );
    usr_pv_ki : out STD_LOGIC_VECTOR ( 31 downto 0 );
    usr_pv_kd : out STD_LOGIC_VECTOR ( 31 downto 0 );
    usr_bess_maxsoc : out STD_LOGIC_VECTOR ( 31 downto 0 );
    usr_bess_minsoc : out STD_LOGIC_VECTOR ( 31 downto 0 );
    usr_pv_max : out STD_LOGIC_VECTOR ( 31 downto 0 );
    usr_exp_prio : out STD_LOGIC;
    usr_bess_en : out STD_LOGIC;
    usr_pv_en : out STD_LOGIC;
    usr_param_vld : out STD_LOGIC
  );

end zcu104_pspl_bramctrl_0_0;

architecture stub of zcu104_pspl_bramctrl_0_0 is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "clkin,arst_n,bess_bram_rdataflg,pv_bram_rdataflg,meter_bram_rdataflg,usrparam_bram_rdataflg,bram_addr[31:0],bram_din[31:0],bram_dout[31:0],bram_enb,bram_web[3:0],pspl_wcmd_bsy,bramw_addr[31:0],bramw_din[31:0],bramw_dout[31:0],bramw_enb,bramw_web[3:0],wcmd_sig[31:0],bess_run_w,bess_p_w[31:0],bess_pvld_w,bess_q_w[31:0],bess_pf_w[15:0],bess_qtyp_w[7:0],bess_islandmode_w,bess_islandmodefrq_w[15:0],bess_islandmodevolt_pu_w[7:0],bess_status_r[6:0],bess_islandmode_r,bess_fault_r[7:0],bess_soc_r[31:0],bess_maxdschgpwr_r[31:0],bess_maxchgpwr_r[31:0],bess_rdata_vld,pv_run_w,pv_p_w[31:0],pv_pvld_w,pv_q_w[31:0],pv_pf_w[15:0],pv_qtyp_w[7:0],pv_status_r[7:0],pv_fault_r[7:0],pv_wattsp_r[31:0],pv_watt_r[31:0],pv_var_r[31:0],pv_yield_r[31:0],pv_rdata_vld,meter_poi_3p[31:0],meter_poi_3q[31:0],meter_poi_3s[31:0],meter_poi_pf[31:0],meter_poi_ia[31:0],meter_poi_ib[31:0],meter_poi_ic[31:0],meter_poi_in[31:0],meter_poi_vab[31:0],meter_poi_vbc[31:0],meter_poi_vca[31:0],meter_poi_freq[31:0],meter_rdata_vld,usr_imp_lmt[31:0],usr_exp_lmt[31:0],usr_besschrg_lmt[31:0],usr_bessdsch_lmt[31:0],usr_bess_kp[31:0],usr_bess_ki[31:0],usr_bess_kd[31:0],usr_pv_kp[31:0],usr_pv_ki[31:0],usr_pv_kd[31:0],usr_bess_maxsoc[31:0],usr_bess_minsoc[31:0],usr_pv_max[31:0],usr_exp_prio,usr_bess_en,usr_pv_en,usr_param_vld";
attribute X_CORE_INFO : string;
attribute X_CORE_INFO of stub : architecture is "pspl_bramctrl,Vivado 2019.2";
begin
end;
