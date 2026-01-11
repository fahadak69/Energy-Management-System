-- Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2019.2 (win64) Build 2708876 Wed Nov  6 21:40:23 MST 2019
-- Date        : Sat Apr 23 22:21:09 2022
-- Host        : Fahad-Dell running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode funcsim
--               C:/Users/fahad/OneDrive/FPGA_SoC_Development/Working/btmems_zcu104/btmems_zcu104.srcs/sources_1/bd/zcu104/ip/zcu104_pspl_bramctrl_0_0/zcu104_pspl_bramctrl_0_0_sim_netlist.vhdl
-- Design      : zcu104_pspl_bramctrl_0_0
-- Purpose     : This VHDL netlist is a functional simulation representation of the design and should not be modified or
--               synthesized. This netlist cannot be used for SDF annotated simulation.
-- Device      : xczu7ev-ffvc1156-2-e
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity zcu104_pspl_bramctrl_0_0_pspl_bramctrl is
  port (
    bram_addr : out STD_LOGIC_VECTOR ( 9 downto 0 );
    bram_enb : out STD_LOGIC;
    bramw_addr : out STD_LOGIC_VECTOR ( 1 downto 0 );
    bramw_dout : out STD_LOGIC_VECTOR ( 31 downto 0 );
    wcmd_sig : out STD_LOGIC_VECTOR ( 4 downto 0 );
    bess_status_r : out STD_LOGIC_VECTOR ( 6 downto 0 );
    bess_fault_r : out STD_LOGIC_VECTOR ( 7 downto 0 );
    bess_soc_r : out STD_LOGIC_VECTOR ( 31 downto 0 );
    bess_maxdschgpwr_r : out STD_LOGIC_VECTOR ( 31 downto 0 );
    bess_maxchgpwr_r : out STD_LOGIC_VECTOR ( 31 downto 0 );
    pv_status_r : out STD_LOGIC_VECTOR ( 7 downto 0 );
    pv_fault_r : out STD_LOGIC_VECTOR ( 7 downto 0 );
    pv_wattsp_r : out STD_LOGIC_VECTOR ( 31 downto 0 );
    pv_watt_r : out STD_LOGIC_VECTOR ( 31 downto 0 );
    pv_var_r : out STD_LOGIC_VECTOR ( 31 downto 0 );
    pv_yield_r : out STD_LOGIC_VECTOR ( 31 downto 0 );
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
    Q : out STD_LOGIC_VECTOR ( 2 downto 0 );
    bess_islandmode_r : out STD_LOGIC;
    bramw_web : out STD_LOGIC_VECTOR ( 0 to 0 );
    bess_rdata_vld : out STD_LOGIC;
    pv_rdata_vld : out STD_LOGIC;
    meter_rdata_vld : out STD_LOGIC;
    usr_param_vld : out STD_LOGIC;
    pv_bram_rdataflg : in STD_LOGIC;
    bess_bram_rdataflg : in STD_LOGIC;
    meter_bram_rdataflg : in STD_LOGIC;
    usrparam_bram_rdataflg : in STD_LOGIC;
    arst_n : in STD_LOGIC;
    clkin : in STD_LOGIC;
    pspl_wcmd_bsy : in STD_LOGIC;
    pv_pvld_w : in STD_LOGIC;
    pv_p_w : in STD_LOGIC_VECTOR ( 31 downto 0 );
    bess_pvld_w : in STD_LOGIC;
    bess_p_w : in STD_LOGIC_VECTOR ( 31 downto 0 );
    bram_din : in STD_LOGIC_VECTOR ( 31 downto 0 )
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of zcu104_pspl_bramctrl_0_0_pspl_bramctrl : entity is "pspl_bramctrl";
end zcu104_pspl_bramctrl_0_0_pspl_bramctrl;

architecture STRUCTURE of zcu104_pspl_bramctrl_0_0_pspl_bramctrl is
  signal \FSM_sequential_state_pv_r[3]_i_1_n_0\ : STD_LOGIC;
  signal \FSM_sequential_state_usrparam_r[0]_i_2_n_0\ : STD_LOGIC;
  signal \FSM_sequential_state_usrparam_r[4]_i_1_n_0\ : STD_LOGIC;
  signal bess_bram_addr : STD_LOGIC_VECTOR ( 9 downto 1 );
  signal \bess_bram_addr[0]_i_1_n_0\ : STD_LOGIC;
  signal \bess_bram_addr[5]_i_2_n_0\ : STD_LOGIC;
  signal \bess_bram_addr[9]_i_1_n_0\ : STD_LOGIC;
  signal \bess_bram_addr[9]_i_3_n_0\ : STD_LOGIC;
  signal \bess_bram_addr[9]_i_4_n_0\ : STD_LOGIC;
  signal \bess_bram_addr_reg_n_0_[0]\ : STD_LOGIC;
  signal \bess_bram_addr_reg_n_0_[1]\ : STD_LOGIC;
  signal \bess_bram_addr_reg_n_0_[2]\ : STD_LOGIC;
  signal \bess_bram_addr_reg_n_0_[3]\ : STD_LOGIC;
  signal \bess_bram_addr_reg_n_0_[4]\ : STD_LOGIC;
  signal \bess_bram_addr_reg_n_0_[5]\ : STD_LOGIC;
  signal \bess_bram_addr_reg_n_0_[6]\ : STD_LOGIC;
  signal \bess_bram_addr_reg_n_0_[7]\ : STD_LOGIC;
  signal \bess_bram_addr_reg_n_0_[8]\ : STD_LOGIC;
  signal \bess_bram_addr_reg_n_0_[9]\ : STD_LOGIC;
  signal bess_bram_enb : STD_LOGIC;
  signal bess_bram_enb_reg_n_0 : STD_LOGIC;
  signal \bess_maxchgpwr_r[31]_i_1_n_0\ : STD_LOGIC;
  signal \bess_maxdschgpwr_r[31]_i_1_n_0\ : STD_LOGIC;
  signal bess_p_w_ltch : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal bess_pvld_wltch : STD_LOGIC;
  attribute DONT_TOUCH : boolean;
  attribute DONT_TOUCH of bess_pvld_wltch : signal is std.standard.true;
  signal bess_pvld_wltch_i_1_n_0 : STD_LOGIC;
  signal bess_rdata_sig_i_1_n_0 : STD_LOGIC;
  signal bess_rdata_sig_reg_n_0 : STD_LOGIC;
  signal \^bess_rdata_vld\ : STD_LOGIC;
  signal bess_rdata_vld_i_1_n_0 : STD_LOGIC;
  signal \bess_soc_r[31]_i_1_n_0\ : STD_LOGIC;
  signal \bess_status_r[6]_i_1_n_0\ : STD_LOGIC;
  signal \bram_addr_10bit[0]_i_1_n_0\ : STD_LOGIC;
  signal \bram_addr_10bit[1]_i_1_n_0\ : STD_LOGIC;
  signal \bram_addr_10bit[2]_i_1_n_0\ : STD_LOGIC;
  signal \bram_addr_10bit[3]_i_1_n_0\ : STD_LOGIC;
  signal \bram_addr_10bit[4]_i_1_n_0\ : STD_LOGIC;
  signal \bram_addr_10bit[5]_i_1_n_0\ : STD_LOGIC;
  signal \bram_addr_10bit[6]_i_1_n_0\ : STD_LOGIC;
  signal \bram_addr_10bit[7]_i_1_n_0\ : STD_LOGIC;
  signal \bram_addr_10bit[8]_i_1_n_0\ : STD_LOGIC;
  signal \bram_addr_10bit[9]_i_1_n_0\ : STD_LOGIC;
  signal \bram_addr_10bit[9]_i_2_n_0\ : STD_LOGIC;
  signal bram_enb0_n_0 : STD_LOGIC;
  signal \bramw_addr_10bit[2]_i_1_n_0\ : STD_LOGIC;
  signal \bramw_addr_10bit[2]_i_2_n_0\ : STD_LOGIC;
  signal \bramw_dout[0]_i_1_n_0\ : STD_LOGIC;
  signal \bramw_dout[10]_i_1_n_0\ : STD_LOGIC;
  signal \bramw_dout[11]_i_1_n_0\ : STD_LOGIC;
  signal \bramw_dout[12]_i_1_n_0\ : STD_LOGIC;
  signal \bramw_dout[13]_i_1_n_0\ : STD_LOGIC;
  signal \bramw_dout[14]_i_1_n_0\ : STD_LOGIC;
  signal \bramw_dout[15]_i_1_n_0\ : STD_LOGIC;
  signal \bramw_dout[16]_i_1_n_0\ : STD_LOGIC;
  signal \bramw_dout[17]_i_1_n_0\ : STD_LOGIC;
  signal \bramw_dout[18]_i_1_n_0\ : STD_LOGIC;
  signal \bramw_dout[19]_i_1_n_0\ : STD_LOGIC;
  signal \bramw_dout[1]_i_1_n_0\ : STD_LOGIC;
  signal \bramw_dout[20]_i_1_n_0\ : STD_LOGIC;
  signal \bramw_dout[21]_i_1_n_0\ : STD_LOGIC;
  signal \bramw_dout[22]_i_1_n_0\ : STD_LOGIC;
  signal \bramw_dout[23]_i_1_n_0\ : STD_LOGIC;
  signal \bramw_dout[24]_i_1_n_0\ : STD_LOGIC;
  signal \bramw_dout[25]_i_1_n_0\ : STD_LOGIC;
  signal \bramw_dout[26]_i_1_n_0\ : STD_LOGIC;
  signal \bramw_dout[27]_i_1_n_0\ : STD_LOGIC;
  signal \bramw_dout[28]_i_1_n_0\ : STD_LOGIC;
  signal \bramw_dout[29]_i_1_n_0\ : STD_LOGIC;
  signal \bramw_dout[2]_i_1_n_0\ : STD_LOGIC;
  signal \bramw_dout[30]_i_1_n_0\ : STD_LOGIC;
  signal \bramw_dout[31]_i_1_n_0\ : STD_LOGIC;
  signal \bramw_dout[3]_i_1_n_0\ : STD_LOGIC;
  signal \bramw_dout[4]_i_1_n_0\ : STD_LOGIC;
  signal \bramw_dout[5]_i_1_n_0\ : STD_LOGIC;
  signal \bramw_dout[6]_i_1_n_0\ : STD_LOGIC;
  signal \bramw_dout[7]_i_1_n_0\ : STD_LOGIC;
  signal \bramw_dout[8]_i_1_n_0\ : STD_LOGIC;
  signal \bramw_dout[9]_i_1_n_0\ : STD_LOGIC;
  signal \^bramw_web\ : STD_LOGIC_VECTOR ( 0 to 0 );
  signal \bramw_web[3]_i_1_n_0\ : STD_LOGIC;
  signal meter_bram_addr : STD_LOGIC_VECTOR ( 9 downto 0 );
  signal \meter_bram_addr[4]_i_2_n_0\ : STD_LOGIC;
  signal \meter_bram_addr[6]_i_2_n_0\ : STD_LOGIC;
  signal \meter_bram_addr[8]_i_2_n_0\ : STD_LOGIC;
  signal \meter_bram_addr[9]_i_1_n_0\ : STD_LOGIC;
  signal \meter_bram_addr[9]_i_3_n_0\ : STD_LOGIC;
  signal \meter_bram_addr[9]_i_4_n_0\ : STD_LOGIC;
  signal \meter_bram_addr_reg_n_0_[0]\ : STD_LOGIC;
  signal \meter_bram_addr_reg_n_0_[1]\ : STD_LOGIC;
  signal \meter_bram_addr_reg_n_0_[2]\ : STD_LOGIC;
  signal \meter_bram_addr_reg_n_0_[3]\ : STD_LOGIC;
  signal \meter_bram_addr_reg_n_0_[4]\ : STD_LOGIC;
  signal \meter_bram_addr_reg_n_0_[5]\ : STD_LOGIC;
  signal \meter_bram_addr_reg_n_0_[6]\ : STD_LOGIC;
  signal \meter_bram_addr_reg_n_0_[7]\ : STD_LOGIC;
  signal \meter_bram_addr_reg_n_0_[8]\ : STD_LOGIC;
  signal \meter_bram_addr_reg_n_0_[9]\ : STD_LOGIC;
  signal meter_bram_enb : STD_LOGIC;
  signal meter_bram_enb_reg_n_0 : STD_LOGIC;
  signal \meter_poi_3p[31]_i_1_n_0\ : STD_LOGIC;
  signal \meter_poi_3q[31]_i_1_n_0\ : STD_LOGIC;
  signal \meter_poi_3s[31]_i_1_n_0\ : STD_LOGIC;
  signal \meter_poi_freq[31]_i_1_n_0\ : STD_LOGIC;
  signal \meter_poi_ia[31]_i_1_n_0\ : STD_LOGIC;
  signal \meter_poi_ib[31]_i_1_n_0\ : STD_LOGIC;
  signal \meter_poi_ic[31]_i_1_n_0\ : STD_LOGIC;
  signal \meter_poi_in[31]_i_1_n_0\ : STD_LOGIC;
  signal \meter_poi_pf[31]_i_1_n_0\ : STD_LOGIC;
  signal \meter_poi_vab[31]_i_1_n_0\ : STD_LOGIC;
  signal \meter_poi_vbc[31]_i_1_n_0\ : STD_LOGIC;
  signal \meter_poi_vca[31]_i_1_n_0\ : STD_LOGIC;
  signal meter_rdata_sig_i_1_n_0 : STD_LOGIC;
  signal meter_rdata_sig_reg_n_0 : STD_LOGIC;
  signal \^meter_rdata_vld\ : STD_LOGIC;
  signal meter_rdata_vld_i_1_n_0 : STD_LOGIC;
  signal \p_0_in__0\ : STD_LOGIC_VECTOR ( 0 to 0 );
  signal p_2_out : STD_LOGIC_VECTOR ( 31 to 31 );
  signal pspl_wcmd_bsyreg : STD_LOGIC;
  signal pv_bram_addr : STD_LOGIC_VECTOR ( 9 downto 0 );
  signal \pv_bram_addr[3]_i_2_n_0\ : STD_LOGIC;
  signal \pv_bram_addr[5]_i_2_n_0\ : STD_LOGIC;
  signal \pv_bram_addr[9]_i_1_n_0\ : STD_LOGIC;
  signal \pv_bram_addr[9]_i_3_n_0\ : STD_LOGIC;
  signal \pv_bram_addr[9]_i_4_n_0\ : STD_LOGIC;
  signal \pv_bram_addr_reg_n_0_[0]\ : STD_LOGIC;
  signal \pv_bram_addr_reg_n_0_[1]\ : STD_LOGIC;
  signal \pv_bram_addr_reg_n_0_[2]\ : STD_LOGIC;
  signal \pv_bram_addr_reg_n_0_[3]\ : STD_LOGIC;
  signal \pv_bram_addr_reg_n_0_[4]\ : STD_LOGIC;
  signal \pv_bram_addr_reg_n_0_[5]\ : STD_LOGIC;
  signal \pv_bram_addr_reg_n_0_[6]\ : STD_LOGIC;
  signal \pv_bram_addr_reg_n_0_[7]\ : STD_LOGIC;
  signal \pv_bram_addr_reg_n_0_[8]\ : STD_LOGIC;
  signal \pv_bram_addr_reg_n_0_[9]\ : STD_LOGIC;
  signal pv_bram_enb : STD_LOGIC;
  signal pv_bram_enb_reg_n_0 : STD_LOGIC;
  signal pv_p_w_ltch : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal pv_pvld_wltch : STD_LOGIC;
  signal pv_pvld_wltch_i_1_n_0 : STD_LOGIC;
  signal pv_rdata_sig_i_1_n_0 : STD_LOGIC;
  signal pv_rdata_sig_reg_n_0 : STD_LOGIC;
  signal \^pv_rdata_vld\ : STD_LOGIC;
  signal pv_rdata_vld_i_1_n_0 : STD_LOGIC;
  signal \pv_status_r[7]_i_1_n_0\ : STD_LOGIC;
  signal \pv_var_r[31]_i_1_n_0\ : STD_LOGIC;
  signal \pv_watt_r[31]_i_1_n_0\ : STD_LOGIC;
  signal \pv_wattsp_r[31]_i_1_n_0\ : STD_LOGIC;
  signal \pv_yield_r[31]_i_1_n_0\ : STD_LOGIC;
  signal state : STD_LOGIC;
  signal \state__0\ : STD_LOGIC;
  signal state_bess_r : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal \state_bess_r__0\ : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal state_meter_r : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal \state_meter_r__0\ : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal state_pv_r : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal \state_pv_r__0\ : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal state_usrparam_r : STD_LOGIC_VECTOR ( 4 downto 0 );
  signal \state_usrparam_r__0\ : STD_LOGIC_VECTOR ( 4 downto 0 );
  signal state_wcmd : STD_LOGIC_VECTOR ( 1 downto 0 );
  attribute DONT_TOUCH of state_wcmd : signal is std.standard.true;
  signal \state_wcmd1__1\ : STD_LOGIC;
  signal \state_wcmd[0]_i_2_n_0\ : STD_LOGIC;
  signal \state_wcmd[1]_i_1_n_0\ : STD_LOGIC;
  signal \usr_bess_kd[31]_i_1_n_0\ : STD_LOGIC;
  signal \usr_bess_ki[31]_i_1_n_0\ : STD_LOGIC;
  signal \usr_bess_kp[31]_i_1_n_0\ : STD_LOGIC;
  signal \usr_bess_maxsoc[31]_i_1_n_0\ : STD_LOGIC;
  signal \usr_bess_minsoc[31]_i_1_n_0\ : STD_LOGIC;
  signal \usr_besschrg_lmt[31]_i_1_n_0\ : STD_LOGIC;
  signal \usr_bessdsch_lmt[31]_i_1_n_0\ : STD_LOGIC;
  signal \usr_cmd_reg[0]_i_1_n_0\ : STD_LOGIC;
  signal \usr_exp_lmt[31]_i_1_n_0\ : STD_LOGIC;
  signal \usr_imp_lmt[31]_i_1_n_0\ : STD_LOGIC;
  signal \^usr_param_vld\ : STD_LOGIC;
  signal usr_param_vld_i_1_n_0 : STD_LOGIC;
  signal \usr_pv_kd[31]_i_1_n_0\ : STD_LOGIC;
  signal \usr_pv_ki[31]_i_1_n_0\ : STD_LOGIC;
  signal \usr_pv_kp[31]_i_1_n_0\ : STD_LOGIC;
  signal \usr_pv_max[31]_i_1_n_0\ : STD_LOGIC;
  signal \usrparam_bram_addr[0]_i_1_n_0\ : STD_LOGIC;
  signal \usrparam_bram_addr[1]_i_1_n_0\ : STD_LOGIC;
  signal \usrparam_bram_addr[2]_i_1_n_0\ : STD_LOGIC;
  signal \usrparam_bram_addr[3]_i_1_n_0\ : STD_LOGIC;
  signal \usrparam_bram_addr[4]_i_1_n_0\ : STD_LOGIC;
  signal \usrparam_bram_addr[5]_i_1_n_0\ : STD_LOGIC;
  signal \usrparam_bram_addr[5]_i_2_n_0\ : STD_LOGIC;
  signal \usrparam_bram_addr[6]_i_1_n_0\ : STD_LOGIC;
  signal \usrparam_bram_addr[7]_i_1_n_0\ : STD_LOGIC;
  signal \usrparam_bram_addr[7]_i_2_n_0\ : STD_LOGIC;
  signal \usrparam_bram_addr[8]_i_1_n_0\ : STD_LOGIC;
  signal \usrparam_bram_addr[9]_i_1_n_0\ : STD_LOGIC;
  signal \usrparam_bram_addr[9]_i_2_n_0\ : STD_LOGIC;
  signal \usrparam_bram_addr[9]_i_3_n_0\ : STD_LOGIC;
  signal \usrparam_bram_addr[9]_i_4_n_0\ : STD_LOGIC;
  signal \usrparam_bram_addr_reg_n_0_[0]\ : STD_LOGIC;
  signal \usrparam_bram_addr_reg_n_0_[1]\ : STD_LOGIC;
  signal \usrparam_bram_addr_reg_n_0_[2]\ : STD_LOGIC;
  signal \usrparam_bram_addr_reg_n_0_[3]\ : STD_LOGIC;
  signal \usrparam_bram_addr_reg_n_0_[4]\ : STD_LOGIC;
  signal \usrparam_bram_addr_reg_n_0_[5]\ : STD_LOGIC;
  signal \usrparam_bram_addr_reg_n_0_[6]\ : STD_LOGIC;
  signal \usrparam_bram_addr_reg_n_0_[7]\ : STD_LOGIC;
  signal \usrparam_bram_addr_reg_n_0_[8]\ : STD_LOGIC;
  signal \usrparam_bram_addr_reg_n_0_[9]\ : STD_LOGIC;
  signal usrparam_bram_enb : STD_LOGIC;
  signal usrparam_bram_enb_reg_n_0 : STD_LOGIC;
  signal usrparam_rdata_sig_i_1_n_0 : STD_LOGIC;
  signal usrparam_rdata_sig_reg_n_0 : STD_LOGIC;
  signal \^wcmd_sig\ : STD_LOGIC_VECTOR ( 4 downto 0 );
  signal \wcmd_sig[31]_i_1_n_0\ : STD_LOGIC;
  signal wcmd_sig_hld : STD_LOGIC_VECTOR ( 29 downto 22 );
  signal \wcmd_sig_hld[14]_i_1_n_0\ : STD_LOGIC;
  signal \wcmd_sig_hld[22]_i_1_n_0\ : STD_LOGIC;
  signal \wcmd_sig_hld[29]_i_2_n_0\ : STD_LOGIC;
  signal \wcmd_sig_hld[29]_i_3_n_0\ : STD_LOGIC;
  signal \wcmd_sig_hld[30]_i_2_n_0\ : STD_LOGIC;
  signal \wcmd_sig_hld_reg_n_0_[14]\ : STD_LOGIC;
  signal \wcmd_sig_hld_reg_n_0_[22]\ : STD_LOGIC;
  signal \wcmd_sig_hld_reg_n_0_[29]\ : STD_LOGIC;
  signal \wcmd_sig_hld_reg_n_0_[30]\ : STD_LOGIC;
  signal wcmd_sig_lastcmd : STD_LOGIC_VECTOR ( 22 downto 14 );
  signal \wcmd_sig_lastcmd[14]_i_1_n_0\ : STD_LOGIC;
  signal \wcmd_sig_lastcmd[22]_i_1_n_0\ : STD_LOGIC;
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of \FSM_sequential_state_bess_r[0]_i_1\ : label is "soft_lutpair23";
  attribute SOFT_HLUTNM of \FSM_sequential_state_bess_r[1]_i_1\ : label is "soft_lutpair23";
  attribute SOFT_HLUTNM of \FSM_sequential_state_bess_r[2]_i_1\ : label is "soft_lutpair22";
  attribute FSM_ENCODED_STATES : string;
  attribute FSM_ENCODED_STATES of \FSM_sequential_state_bess_r_reg[0]\ : label is "ST_BESS_R_REG1:010,ST_BESS_R_REG2:011,ST_BESS_R_REG3:100,ST_BESS_R_REG4:101,ST_BESS_R_REG5:110,ST_BESS_R_INTRM:001,ST_BESS_R_IDLE:000,ST_BESS_R_VLD:111";
  attribute FSM_ENCODED_STATES of \FSM_sequential_state_bess_r_reg[1]\ : label is "ST_BESS_R_REG1:010,ST_BESS_R_REG2:011,ST_BESS_R_REG3:100,ST_BESS_R_REG4:101,ST_BESS_R_REG5:110,ST_BESS_R_INTRM:001,ST_BESS_R_IDLE:000,ST_BESS_R_VLD:111";
  attribute FSM_ENCODED_STATES of \FSM_sequential_state_bess_r_reg[2]\ : label is "ST_BESS_R_REG1:010,ST_BESS_R_REG2:011,ST_BESS_R_REG3:100,ST_BESS_R_REG4:101,ST_BESS_R_REG5:110,ST_BESS_R_INTRM:001,ST_BESS_R_IDLE:000,ST_BESS_R_VLD:111";
  attribute SOFT_HLUTNM of \FSM_sequential_state_meter_r[0]_i_1\ : label is "soft_lutpair4";
  attribute SOFT_HLUTNM of \FSM_sequential_state_meter_r[1]_i_1\ : label is "soft_lutpair6";
  attribute SOFT_HLUTNM of \FSM_sequential_state_meter_r[2]_i_1\ : label is "soft_lutpair6";
  attribute SOFT_HLUTNM of \FSM_sequential_state_meter_r[3]_i_1\ : label is "soft_lutpair4";
  attribute FSM_ENCODED_STATES of \FSM_sequential_state_meter_r_reg[0]\ : label is "ST_METER_R_REG3:0100,ST_METER_R_REG2:0011,ST_METER_R_REG12:1101,ST_METER_R_REG1:0010,ST_METER_R_REG10:1011,ST_METER_R_REG11:1100,ST_METER_R_REG9:1010,ST_METER_R_INTRM:0001,ST_METER_R_IDLE:0000,ST_METER_R_REG8:1001,ST_METER_R_REG6:0111,ST_METER_R_REG7:1000,ST_METER_R_REG5:0110,ST_METER_R_VLD:1111,ST_METER_R_REG13:1110,ST_METER_R_REG4:0101";
  attribute FSM_ENCODED_STATES of \FSM_sequential_state_meter_r_reg[1]\ : label is "ST_METER_R_REG3:0100,ST_METER_R_REG2:0011,ST_METER_R_REG12:1101,ST_METER_R_REG1:0010,ST_METER_R_REG10:1011,ST_METER_R_REG11:1100,ST_METER_R_REG9:1010,ST_METER_R_INTRM:0001,ST_METER_R_IDLE:0000,ST_METER_R_REG8:1001,ST_METER_R_REG6:0111,ST_METER_R_REG7:1000,ST_METER_R_REG5:0110,ST_METER_R_VLD:1111,ST_METER_R_REG13:1110,ST_METER_R_REG4:0101";
  attribute FSM_ENCODED_STATES of \FSM_sequential_state_meter_r_reg[2]\ : label is "ST_METER_R_REG3:0100,ST_METER_R_REG2:0011,ST_METER_R_REG12:1101,ST_METER_R_REG1:0010,ST_METER_R_REG10:1011,ST_METER_R_REG11:1100,ST_METER_R_REG9:1010,ST_METER_R_INTRM:0001,ST_METER_R_IDLE:0000,ST_METER_R_REG8:1001,ST_METER_R_REG6:0111,ST_METER_R_REG7:1000,ST_METER_R_REG5:0110,ST_METER_R_VLD:1111,ST_METER_R_REG13:1110,ST_METER_R_REG4:0101";
  attribute FSM_ENCODED_STATES of \FSM_sequential_state_meter_r_reg[3]\ : label is "ST_METER_R_REG3:0100,ST_METER_R_REG2:0011,ST_METER_R_REG12:1101,ST_METER_R_REG1:0010,ST_METER_R_REG10:1011,ST_METER_R_REG11:1100,ST_METER_R_REG9:1010,ST_METER_R_INTRM:0001,ST_METER_R_IDLE:0000,ST_METER_R_REG8:1001,ST_METER_R_REG6:0111,ST_METER_R_REG7:1000,ST_METER_R_REG5:0110,ST_METER_R_VLD:1111,ST_METER_R_REG13:1110,ST_METER_R_REG4:0101";
  attribute SOFT_HLUTNM of \FSM_sequential_state_pv_r[0]_i_1\ : label is "soft_lutpair3";
  attribute SOFT_HLUTNM of \FSM_sequential_state_pv_r[1]_i_1\ : label is "soft_lutpair21";
  attribute SOFT_HLUTNM of \FSM_sequential_state_pv_r[2]_i_1\ : label is "soft_lutpair21";
  attribute SOFT_HLUTNM of \FSM_sequential_state_pv_r[3]_i_2\ : label is "soft_lutpair3";
  attribute FSM_ENCODED_STATES of \FSM_sequential_state_pv_r_reg[0]\ : label is "ST_PV_R_REG2:0011,ST_PV_R_REG3:0100,ST_PV_R_REG1:0010,ST_PV_R_INTRM:0001,ST_PV_R_IDLE:0000,ST_PV_R_REG6:0111,ST_PV_R_VLD:1000,ST_PV_R_REG5:0110,ST_PV_R_REG4:0101";
  attribute FSM_ENCODED_STATES of \FSM_sequential_state_pv_r_reg[1]\ : label is "ST_PV_R_REG2:0011,ST_PV_R_REG3:0100,ST_PV_R_REG1:0010,ST_PV_R_INTRM:0001,ST_PV_R_IDLE:0000,ST_PV_R_REG6:0111,ST_PV_R_VLD:1000,ST_PV_R_REG5:0110,ST_PV_R_REG4:0101";
  attribute FSM_ENCODED_STATES of \FSM_sequential_state_pv_r_reg[2]\ : label is "ST_PV_R_REG2:0011,ST_PV_R_REG3:0100,ST_PV_R_REG1:0010,ST_PV_R_INTRM:0001,ST_PV_R_IDLE:0000,ST_PV_R_REG6:0111,ST_PV_R_VLD:1000,ST_PV_R_REG5:0110,ST_PV_R_REG4:0101";
  attribute FSM_ENCODED_STATES of \FSM_sequential_state_pv_r_reg[3]\ : label is "ST_PV_R_REG2:0011,ST_PV_R_REG3:0100,ST_PV_R_REG1:0010,ST_PV_R_INTRM:0001,ST_PV_R_IDLE:0000,ST_PV_R_REG6:0111,ST_PV_R_VLD:1000,ST_PV_R_REG5:0110,ST_PV_R_REG4:0101";
  attribute FSM_ENCODED_STATES of FSM_sequential_state_reg : label is "ST_IDLE:0,ST_1SHOT:1";
  attribute SOFT_HLUTNM of \FSM_sequential_state_usrparam_r[0]_i_2\ : label is "soft_lutpair12";
  attribute SOFT_HLUTNM of \FSM_sequential_state_usrparam_r[1]_i_1\ : label is "soft_lutpair20";
  attribute SOFT_HLUTNM of \FSM_sequential_state_usrparam_r[2]_i_1\ : label is "soft_lutpair20";
  attribute SOFT_HLUTNM of \FSM_sequential_state_usrparam_r[3]_i_1\ : label is "soft_lutpair11";
  attribute FSM_ENCODED_STATES of \FSM_sequential_state_usrparam_r_reg[0]\ : label is "ST_USRPARAM_R_REG14:01111,ST_USRPARAM_R_REG3:00100,ST_USRPARAM_R_REG13:01110,ST_USRPARAM_R_REG12:01101,ST_USRPARAM_R_REG11:01100,ST_USRPARAM_R_REG2:00011,ST_USRPARAM_R_REG1:00010,ST_USRPARAM_R_VLD:10001,ST_USRPARAM_R_REG15:10000,ST_USRPARAM_R_INTRM:00001,ST_USRPARAM_R_REG10:01011,ST_USRPARAM_R_IDLE:00000,ST_USRPARAM_R_REG9:01010,ST_USRPARAM_R_REG6:00111,ST_USRPARAM_R_REG5:00110,ST_USRPARAM_R_REG8:01001,ST_USRPARAM_R_REG7:01000,ST_USRPARAM_R_REG4:00101";
  attribute FSM_ENCODED_STATES of \FSM_sequential_state_usrparam_r_reg[1]\ : label is "ST_USRPARAM_R_REG14:01111,ST_USRPARAM_R_REG3:00100,ST_USRPARAM_R_REG13:01110,ST_USRPARAM_R_REG12:01101,ST_USRPARAM_R_REG11:01100,ST_USRPARAM_R_REG2:00011,ST_USRPARAM_R_REG1:00010,ST_USRPARAM_R_VLD:10001,ST_USRPARAM_R_REG15:10000,ST_USRPARAM_R_INTRM:00001,ST_USRPARAM_R_REG10:01011,ST_USRPARAM_R_IDLE:00000,ST_USRPARAM_R_REG9:01010,ST_USRPARAM_R_REG6:00111,ST_USRPARAM_R_REG5:00110,ST_USRPARAM_R_REG8:01001,ST_USRPARAM_R_REG7:01000,ST_USRPARAM_R_REG4:00101";
  attribute FSM_ENCODED_STATES of \FSM_sequential_state_usrparam_r_reg[2]\ : label is "ST_USRPARAM_R_REG14:01111,ST_USRPARAM_R_REG3:00100,ST_USRPARAM_R_REG13:01110,ST_USRPARAM_R_REG12:01101,ST_USRPARAM_R_REG11:01100,ST_USRPARAM_R_REG2:00011,ST_USRPARAM_R_REG1:00010,ST_USRPARAM_R_VLD:10001,ST_USRPARAM_R_REG15:10000,ST_USRPARAM_R_INTRM:00001,ST_USRPARAM_R_REG10:01011,ST_USRPARAM_R_IDLE:00000,ST_USRPARAM_R_REG9:01010,ST_USRPARAM_R_REG6:00111,ST_USRPARAM_R_REG5:00110,ST_USRPARAM_R_REG8:01001,ST_USRPARAM_R_REG7:01000,ST_USRPARAM_R_REG4:00101";
  attribute FSM_ENCODED_STATES of \FSM_sequential_state_usrparam_r_reg[3]\ : label is "ST_USRPARAM_R_REG14:01111,ST_USRPARAM_R_REG3:00100,ST_USRPARAM_R_REG13:01110,ST_USRPARAM_R_REG12:01101,ST_USRPARAM_R_REG11:01100,ST_USRPARAM_R_REG2:00011,ST_USRPARAM_R_REG1:00010,ST_USRPARAM_R_VLD:10001,ST_USRPARAM_R_REG15:10000,ST_USRPARAM_R_INTRM:00001,ST_USRPARAM_R_REG10:01011,ST_USRPARAM_R_IDLE:00000,ST_USRPARAM_R_REG9:01010,ST_USRPARAM_R_REG6:00111,ST_USRPARAM_R_REG5:00110,ST_USRPARAM_R_REG8:01001,ST_USRPARAM_R_REG7:01000,ST_USRPARAM_R_REG4:00101";
  attribute FSM_ENCODED_STATES of \FSM_sequential_state_usrparam_r_reg[4]\ : label is "ST_USRPARAM_R_REG14:01111,ST_USRPARAM_R_REG3:00100,ST_USRPARAM_R_REG13:01110,ST_USRPARAM_R_REG12:01101,ST_USRPARAM_R_REG11:01100,ST_USRPARAM_R_REG2:00011,ST_USRPARAM_R_REG1:00010,ST_USRPARAM_R_VLD:10001,ST_USRPARAM_R_REG15:10000,ST_USRPARAM_R_INTRM:00001,ST_USRPARAM_R_REG10:01011,ST_USRPARAM_R_IDLE:00000,ST_USRPARAM_R_REG9:01010,ST_USRPARAM_R_REG6:00111,ST_USRPARAM_R_REG5:00110,ST_USRPARAM_R_REG8:01001,ST_USRPARAM_R_REG7:01000,ST_USRPARAM_R_REG4:00101";
  attribute SOFT_HLUTNM of \__7/i_\ : label is "soft_lutpair2";
  attribute SOFT_HLUTNM of \bess_bram_addr[0]_i_1\ : label is "soft_lutpair19";
  attribute SOFT_HLUTNM of \bess_bram_addr[1]_i_1\ : label is "soft_lutpair8";
  attribute SOFT_HLUTNM of \bess_bram_addr[2]_i_1\ : label is "soft_lutpair8";
  attribute SOFT_HLUTNM of \bess_bram_addr[5]_i_1\ : label is "soft_lutpair24";
  attribute SOFT_HLUTNM of \bess_bram_addr[6]_i_1\ : label is "soft_lutpair0";
  attribute SOFT_HLUTNM of \bess_bram_addr[7]_i_1\ : label is "soft_lutpair0";
  attribute SOFT_HLUTNM of \bess_bram_addr[9]_i_4\ : label is "soft_lutpair24";
  attribute SOFT_HLUTNM of bess_bram_enb_i_1 : label is "soft_lutpair19";
  attribute DONT_TOUCH of bess_pvld_wltch_reg : label is std.standard.true;
  attribute KEEP : string;
  attribute KEEP of bess_pvld_wltch_reg : label is "yes";
  attribute SOFT_HLUTNM of bess_rdata_sig_i_1 : label is "soft_lutpair1";
  attribute SOFT_HLUTNM of bess_rdata_vld_i_1 : label is "soft_lutpair22";
  attribute SOFT_HLUTNM of \meter_bram_addr[0]_i_1\ : label is "soft_lutpair5";
  attribute SOFT_HLUTNM of \meter_bram_addr[2]_i_1\ : label is "soft_lutpair7";
  attribute SOFT_HLUTNM of \meter_bram_addr[3]_i_1\ : label is "soft_lutpair7";
  attribute SOFT_HLUTNM of \meter_bram_addr[4]_i_2\ : label is "soft_lutpair17";
  attribute SOFT_HLUTNM of \meter_bram_addr[6]_i_2\ : label is "soft_lutpair9";
  attribute SOFT_HLUTNM of \meter_bram_addr[8]_i_2\ : label is "soft_lutpair17";
  attribute SOFT_HLUTNM of \meter_bram_addr[9]_i_4\ : label is "soft_lutpair5";
  attribute SOFT_HLUTNM of meter_bram_enb_i_1 : label is "soft_lutpair9";
  attribute SOFT_HLUTNM of meter_rdata_sig_i_1 : label is "soft_lutpair1";
  attribute SOFT_HLUTNM of \pv_bram_addr[0]_i_1\ : label is "soft_lutpair16";
  attribute SOFT_HLUTNM of \pv_bram_addr[1]_i_1\ : label is "soft_lutpair16";
  attribute SOFT_HLUTNM of \pv_bram_addr[3]_i_2\ : label is "soft_lutpair15";
  attribute SOFT_HLUTNM of \pv_bram_addr[5]_i_2\ : label is "soft_lutpair15";
  attribute SOFT_HLUTNM of \pv_bram_addr[7]_i_1\ : label is "soft_lutpair13";
  attribute SOFT_HLUTNM of \pv_bram_addr[8]_i_1\ : label is "soft_lutpair13";
  attribute SOFT_HLUTNM of \pv_bram_addr[9]_i_4\ : label is "soft_lutpair18";
  attribute SOFT_HLUTNM of pv_rdata_sig_i_1 : label is "soft_lutpair2";
  attribute SOFT_HLUTNM of pv_rdata_vld_i_1 : label is "soft_lutpair18";
  attribute DONT_TOUCH of \state_wcmd_reg[0]\ : label is std.standard.true;
  attribute FSM_ENCODED_STATES of \state_wcmd_reg[0]\ : label is "ST_WCMD_LOOP:00,ST_WCMD_SIG:01";
  attribute KEEP of \state_wcmd_reg[0]\ : label is "yes";
  attribute DONT_TOUCH of \state_wcmd_reg[1]\ : label is std.standard.true;
  attribute FSM_ENCODED_STATES of \state_wcmd_reg[1]\ : label is "ST_WCMD_LOOP:00,ST_WCMD_SIG:01";
  attribute KEEP of \state_wcmd_reg[1]\ : label is "yes";
  attribute SOFT_HLUTNM of \usrparam_bram_addr[0]_i_1\ : label is "soft_lutpair12";
  attribute SOFT_HLUTNM of \usrparam_bram_addr[1]_i_1\ : label is "soft_lutpair25";
  attribute SOFT_HLUTNM of \usrparam_bram_addr[2]_i_1\ : label is "soft_lutpair14";
  attribute SOFT_HLUTNM of \usrparam_bram_addr[3]_i_1\ : label is "soft_lutpair14";
  attribute SOFT_HLUTNM of \usrparam_bram_addr[5]_i_1\ : label is "soft_lutpair25";
  attribute SOFT_HLUTNM of \usrparam_bram_addr[6]_i_1\ : label is "soft_lutpair10";
  attribute SOFT_HLUTNM of \usrparam_bram_addr[7]_i_1\ : label is "soft_lutpair10";
  attribute SOFT_HLUTNM of \usrparam_bram_addr[9]_i_4\ : label is "soft_lutpair11";
begin
  bess_rdata_vld <= \^bess_rdata_vld\;
  bramw_web(0) <= \^bramw_web\(0);
  meter_rdata_vld <= \^meter_rdata_vld\;
  pv_rdata_vld <= \^pv_rdata_vld\;
  usr_param_vld <= \^usr_param_vld\;
  wcmd_sig(4 downto 0) <= \^wcmd_sig\(4 downto 0);
\FSM_sequential_state_bess_r[0]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"8F0E"
    )
        port map (
      I0 => bess_rdata_sig_reg_n_0,
      I1 => state_bess_r(1),
      I2 => state_bess_r(0),
      I3 => state_bess_r(2),
      O => \state_bess_r__0\(0)
    );
\FSM_sequential_state_bess_r[1]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"8FF0"
    )
        port map (
      I0 => state_bess_r(2),
      I1 => bess_rdata_sig_reg_n_0,
      I2 => state_bess_r(1),
      I3 => state_bess_r(0),
      O => \state_bess_r__0\(1)
    );
\FSM_sequential_state_bess_r[2]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"BCCC"
    )
        port map (
      I0 => bess_rdata_sig_reg_n_0,
      I1 => state_bess_r(2),
      I2 => state_bess_r(1),
      I3 => state_bess_r(0),
      O => \state_bess_r__0\(2)
    );
\FSM_sequential_state_bess_r_reg[0]\: unisim.vcomponents.FDCE
     port map (
      C => clkin,
      CE => '1',
      CLR => \bram_addr_10bit[9]_i_2_n_0\,
      D => \state_bess_r__0\(0),
      Q => state_bess_r(0)
    );
\FSM_sequential_state_bess_r_reg[1]\: unisim.vcomponents.FDCE
     port map (
      C => clkin,
      CE => '1',
      CLR => \bram_addr_10bit[9]_i_2_n_0\,
      D => \state_bess_r__0\(1),
      Q => state_bess_r(1)
    );
\FSM_sequential_state_bess_r_reg[2]\: unisim.vcomponents.FDCE
     port map (
      C => clkin,
      CE => '1',
      CLR => \bram_addr_10bit[9]_i_2_n_0\,
      D => \state_bess_r__0\(2),
      Q => state_bess_r(2)
    );
\FSM_sequential_state_meter_r[0]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"8000FFFE"
    )
        port map (
      I0 => state_meter_r(1),
      I1 => state_meter_r(3),
      I2 => state_meter_r(2),
      I3 => meter_rdata_sig_reg_n_0,
      I4 => state_meter_r(0),
      O => \state_meter_r__0\(0)
    );
\FSM_sequential_state_meter_r[1]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"80FFFF00"
    )
        port map (
      I0 => state_meter_r(3),
      I1 => state_meter_r(2),
      I2 => meter_rdata_sig_reg_n_0,
      I3 => state_meter_r(1),
      I4 => state_meter_r(0),
      O => \state_meter_r__0\(1)
    );
\FSM_sequential_state_meter_r[2]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"8FF0F0F0"
    )
        port map (
      I0 => state_meter_r(3),
      I1 => meter_rdata_sig_reg_n_0,
      I2 => state_meter_r(2),
      I3 => state_meter_r(1),
      I4 => state_meter_r(0),
      O => \state_meter_r__0\(2)
    );
\FSM_sequential_state_meter_r[3]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"F8F078F0"
    )
        port map (
      I0 => state_meter_r(0),
      I1 => state_meter_r(1),
      I2 => state_meter_r(3),
      I3 => state_meter_r(2),
      I4 => meter_rdata_sig_reg_n_0,
      O => \state_meter_r__0\(3)
    );
\FSM_sequential_state_meter_r_reg[0]\: unisim.vcomponents.FDCE
     port map (
      C => clkin,
      CE => '1',
      CLR => \bram_addr_10bit[9]_i_2_n_0\,
      D => \state_meter_r__0\(0),
      Q => state_meter_r(0)
    );
\FSM_sequential_state_meter_r_reg[1]\: unisim.vcomponents.FDCE
     port map (
      C => clkin,
      CE => '1',
      CLR => \bram_addr_10bit[9]_i_2_n_0\,
      D => \state_meter_r__0\(1),
      Q => state_meter_r(1)
    );
\FSM_sequential_state_meter_r_reg[2]\: unisim.vcomponents.FDCE
     port map (
      C => clkin,
      CE => '1',
      CLR => \bram_addr_10bit[9]_i_2_n_0\,
      D => \state_meter_r__0\(2),
      Q => state_meter_r(2)
    );
\FSM_sequential_state_meter_r_reg[3]\: unisim.vcomponents.FDCE
     port map (
      C => clkin,
      CE => '1',
      CLR => \bram_addr_10bit[9]_i_2_n_0\,
      D => \state_meter_r__0\(3),
      Q => state_meter_r(3)
    );
\FSM_sequential_state_pv_r[0]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"000000FE"
    )
        port map (
      I0 => state_pv_r(2),
      I1 => pv_rdata_sig_reg_n_0,
      I2 => state_pv_r(1),
      I3 => state_pv_r(0),
      I4 => state_pv_r(3),
      O => \state_pv_r__0\(0)
    );
\FSM_sequential_state_pv_r[1]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"06"
    )
        port map (
      I0 => state_pv_r(0),
      I1 => state_pv_r(1),
      I2 => state_pv_r(3),
      O => \state_pv_r__0\(1)
    );
\FSM_sequential_state_pv_r[2]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0708"
    )
        port map (
      I0 => state_pv_r(1),
      I1 => state_pv_r(0),
      I2 => state_pv_r(3),
      I3 => state_pv_r(2),
      O => \state_pv_r__0\(2)
    );
\FSM_sequential_state_pv_r[3]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"01FF"
    )
        port map (
      I0 => state_pv_r(2),
      I1 => state_pv_r(1),
      I2 => state_pv_r(0),
      I3 => state_pv_r(3),
      O => \FSM_sequential_state_pv_r[3]_i_1_n_0\
    );
\FSM_sequential_state_pv_r[3]_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"AAAAC000"
    )
        port map (
      I0 => pv_rdata_sig_reg_n_0,
      I1 => state_pv_r(1),
      I2 => state_pv_r(0),
      I3 => state_pv_r(2),
      I4 => state_pv_r(3),
      O => \state_pv_r__0\(3)
    );
\FSM_sequential_state_pv_r_reg[0]\: unisim.vcomponents.FDCE
     port map (
      C => clkin,
      CE => \FSM_sequential_state_pv_r[3]_i_1_n_0\,
      CLR => \bram_addr_10bit[9]_i_2_n_0\,
      D => \state_pv_r__0\(0),
      Q => state_pv_r(0)
    );
\FSM_sequential_state_pv_r_reg[1]\: unisim.vcomponents.FDCE
     port map (
      C => clkin,
      CE => \FSM_sequential_state_pv_r[3]_i_1_n_0\,
      CLR => \bram_addr_10bit[9]_i_2_n_0\,
      D => \state_pv_r__0\(1),
      Q => state_pv_r(1)
    );
\FSM_sequential_state_pv_r_reg[2]\: unisim.vcomponents.FDCE
     port map (
      C => clkin,
      CE => \FSM_sequential_state_pv_r[3]_i_1_n_0\,
      CLR => \bram_addr_10bit[9]_i_2_n_0\,
      D => \state_pv_r__0\(2),
      Q => state_pv_r(2)
    );
\FSM_sequential_state_pv_r_reg[3]\: unisim.vcomponents.FDCE
     port map (
      C => clkin,
      CE => \FSM_sequential_state_pv_r[3]_i_1_n_0\,
      CLR => \bram_addr_10bit[9]_i_2_n_0\,
      D => \state_pv_r__0\(3),
      Q => state_pv_r(3)
    );
FSM_sequential_state_reg: unisim.vcomponents.FDCE
     port map (
      C => clkin,
      CE => '1',
      CLR => \bram_addr_10bit[9]_i_2_n_0\,
      D => \state__0\,
      Q => state
    );
\FSM_sequential_state_usrparam_r[0]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFF00FF00FE00FE"
    )
        port map (
      I0 => state_usrparam_r(1),
      I1 => \FSM_sequential_state_usrparam_r[0]_i_2_n_0\,
      I2 => usrparam_rdata_sig_reg_n_0,
      I3 => state_usrparam_r(0),
      I4 => bess_rdata_sig_reg_n_0,
      I5 => state_usrparam_r(4),
      O => \state_usrparam_r__0\(0)
    );
\FSM_sequential_state_usrparam_r[0]_i_2\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"E"
    )
        port map (
      I0 => state_usrparam_r(2),
      I1 => state_usrparam_r(3),
      O => \FSM_sequential_state_usrparam_r[0]_i_2_n_0\
    );
\FSM_sequential_state_usrparam_r[1]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"06"
    )
        port map (
      I0 => state_usrparam_r(0),
      I1 => state_usrparam_r(1),
      I2 => state_usrparam_r(4),
      O => \state_usrparam_r__0\(1)
    );
\FSM_sequential_state_usrparam_r[2]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0708"
    )
        port map (
      I0 => state_usrparam_r(0),
      I1 => state_usrparam_r(1),
      I2 => state_usrparam_r(4),
      I3 => state_usrparam_r(2),
      O => \state_usrparam_r__0\(2)
    );
\FSM_sequential_state_usrparam_r[3]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"070F0800"
    )
        port map (
      I0 => state_usrparam_r(0),
      I1 => state_usrparam_r(2),
      I2 => state_usrparam_r(4),
      I3 => state_usrparam_r(1),
      I4 => state_usrparam_r(3),
      O => \state_usrparam_r__0\(3)
    );
\FSM_sequential_state_usrparam_r[4]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"01FF"
    )
        port map (
      I0 => state_usrparam_r(1),
      I1 => state_usrparam_r(2),
      I2 => state_usrparam_r(3),
      I3 => state_usrparam_r(4),
      O => \FSM_sequential_state_usrparam_r[4]_i_1_n_0\
    );
\FSM_sequential_state_usrparam_r[4]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFF800000FF8000"
    )
        port map (
      I0 => state_usrparam_r(3),
      I1 => state_usrparam_r(1),
      I2 => state_usrparam_r(2),
      I3 => state_usrparam_r(0),
      I4 => state_usrparam_r(4),
      I5 => bess_rdata_sig_reg_n_0,
      O => \state_usrparam_r__0\(4)
    );
\FSM_sequential_state_usrparam_r_reg[0]\: unisim.vcomponents.FDCE
     port map (
      C => clkin,
      CE => \FSM_sequential_state_usrparam_r[4]_i_1_n_0\,
      CLR => \bram_addr_10bit[9]_i_2_n_0\,
      D => \state_usrparam_r__0\(0),
      Q => state_usrparam_r(0)
    );
\FSM_sequential_state_usrparam_r_reg[1]\: unisim.vcomponents.FDCE
     port map (
      C => clkin,
      CE => \FSM_sequential_state_usrparam_r[4]_i_1_n_0\,
      CLR => \bram_addr_10bit[9]_i_2_n_0\,
      D => \state_usrparam_r__0\(1),
      Q => state_usrparam_r(1)
    );
\FSM_sequential_state_usrparam_r_reg[2]\: unisim.vcomponents.FDCE
     port map (
      C => clkin,
      CE => \FSM_sequential_state_usrparam_r[4]_i_1_n_0\,
      CLR => \bram_addr_10bit[9]_i_2_n_0\,
      D => \state_usrparam_r__0\(2),
      Q => state_usrparam_r(2)
    );
\FSM_sequential_state_usrparam_r_reg[3]\: unisim.vcomponents.FDCE
     port map (
      C => clkin,
      CE => \FSM_sequential_state_usrparam_r[4]_i_1_n_0\,
      CLR => \bram_addr_10bit[9]_i_2_n_0\,
      D => \state_usrparam_r__0\(3),
      Q => state_usrparam_r(3)
    );
\FSM_sequential_state_usrparam_r_reg[4]\: unisim.vcomponents.FDCE
     port map (
      C => clkin,
      CE => \FSM_sequential_state_usrparam_r[4]_i_1_n_0\,
      CLR => \bram_addr_10bit[9]_i_2_n_0\,
      D => \state_usrparam_r__0\(4),
      Q => state_usrparam_r(4)
    );
\__7/i_\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"AAABABBC"
    )
        port map (
      I0 => state,
      I1 => bess_bram_rdataflg,
      I2 => pv_bram_rdataflg,
      I3 => meter_bram_rdataflg,
      I4 => usrparam_bram_rdataflg,
      O => \state__0\
    );
\bess_bram_addr[0]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"0E"
    )
        port map (
      I0 => state_bess_r(0),
      I1 => state_bess_r(1),
      I2 => \bess_bram_addr_reg_n_0_[0]\,
      O => \bess_bram_addr[0]_i_1_n_0\
    );
\bess_bram_addr[1]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0EE0"
    )
        port map (
      I0 => state_bess_r(1),
      I1 => state_bess_r(0),
      I2 => \bess_bram_addr_reg_n_0_[0]\,
      I3 => \bess_bram_addr_reg_n_0_[1]\,
      O => bess_bram_addr(1)
    );
\bess_bram_addr[2]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"0EEEE000"
    )
        port map (
      I0 => state_bess_r(1),
      I1 => state_bess_r(0),
      I2 => \bess_bram_addr_reg_n_0_[1]\,
      I3 => \bess_bram_addr_reg_n_0_[0]\,
      I4 => \bess_bram_addr_reg_n_0_[2]\,
      O => bess_bram_addr(2)
    );
\bess_bram_addr[3]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"7F7F7F0080808000"
    )
        port map (
      I0 => \bess_bram_addr_reg_n_0_[1]\,
      I1 => \bess_bram_addr_reg_n_0_[0]\,
      I2 => \bess_bram_addr_reg_n_0_[2]\,
      I3 => state_bess_r(0),
      I4 => state_bess_r(1),
      I5 => \bess_bram_addr_reg_n_0_[3]\,
      O => bess_bram_addr(3)
    );
\bess_bram_addr[4]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"7FFF000080000000"
    )
        port map (
      I0 => \bess_bram_addr_reg_n_0_[2]\,
      I1 => \bess_bram_addr_reg_n_0_[0]\,
      I2 => \bess_bram_addr_reg_n_0_[1]\,
      I3 => \bess_bram_addr_reg_n_0_[3]\,
      I4 => \bess_bram_addr[9]_i_4_n_0\,
      I5 => \bess_bram_addr_reg_n_0_[4]\,
      O => bess_bram_addr(4)
    );
\bess_bram_addr[5]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"54A8"
    )
        port map (
      I0 => \bess_bram_addr[5]_i_2_n_0\,
      I1 => state_bess_r(0),
      I2 => state_bess_r(1),
      I3 => \bess_bram_addr_reg_n_0_[5]\,
      O => bess_bram_addr(5)
    );
\bess_bram_addr[5]_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"80000000"
    )
        port map (
      I0 => \bess_bram_addr_reg_n_0_[4]\,
      I1 => \bess_bram_addr_reg_n_0_[3]\,
      I2 => \bess_bram_addr_reg_n_0_[1]\,
      I3 => \bess_bram_addr_reg_n_0_[0]\,
      I4 => \bess_bram_addr_reg_n_0_[2]\,
      O => \bess_bram_addr[5]_i_2_n_0\
    );
\bess_bram_addr[6]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"A854"
    )
        port map (
      I0 => \bess_bram_addr[9]_i_3_n_0\,
      I1 => state_bess_r(0),
      I2 => state_bess_r(1),
      I3 => \bess_bram_addr_reg_n_0_[6]\,
      O => bess_bram_addr(6)
    );
\bess_bram_addr[7]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"BBB04440"
    )
        port map (
      I0 => \bess_bram_addr[9]_i_3_n_0\,
      I1 => \bess_bram_addr_reg_n_0_[6]\,
      I2 => state_bess_r(0),
      I3 => state_bess_r(1),
      I4 => \bess_bram_addr_reg_n_0_[7]\,
      O => bess_bram_addr(7)
    );
\bess_bram_addr[8]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"DFDFDF0020202000"
    )
        port map (
      I0 => \bess_bram_addr_reg_n_0_[6]\,
      I1 => \bess_bram_addr[9]_i_3_n_0\,
      I2 => \bess_bram_addr_reg_n_0_[7]\,
      I3 => state_bess_r(0),
      I4 => state_bess_r(1),
      I5 => \bess_bram_addr_reg_n_0_[8]\,
      O => bess_bram_addr(8)
    );
\bess_bram_addr[9]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"57"
    )
        port map (
      I0 => state_bess_r(2),
      I1 => state_bess_r(0),
      I2 => state_bess_r(1),
      O => \bess_bram_addr[9]_i_1_n_0\
    );
\bess_bram_addr[9]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"DFFF000020000000"
    )
        port map (
      I0 => \bess_bram_addr_reg_n_0_[7]\,
      I1 => \bess_bram_addr[9]_i_3_n_0\,
      I2 => \bess_bram_addr_reg_n_0_[6]\,
      I3 => \bess_bram_addr_reg_n_0_[8]\,
      I4 => \bess_bram_addr[9]_i_4_n_0\,
      I5 => \bess_bram_addr_reg_n_0_[9]\,
      O => bess_bram_addr(9)
    );
\bess_bram_addr[9]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"7FFFFFFFFFFFFFFF"
    )
        port map (
      I0 => \bess_bram_addr_reg_n_0_[2]\,
      I1 => \bess_bram_addr_reg_n_0_[0]\,
      I2 => \bess_bram_addr_reg_n_0_[1]\,
      I3 => \bess_bram_addr_reg_n_0_[3]\,
      I4 => \bess_bram_addr_reg_n_0_[4]\,
      I5 => \bess_bram_addr_reg_n_0_[5]\,
      O => \bess_bram_addr[9]_i_3_n_0\
    );
\bess_bram_addr[9]_i_4\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"E"
    )
        port map (
      I0 => state_bess_r(1),
      I1 => state_bess_r(0),
      O => \bess_bram_addr[9]_i_4_n_0\
    );
\bess_bram_addr_reg[0]\: unisim.vcomponents.FDCE
     port map (
      C => clkin,
      CE => \bess_bram_addr[9]_i_1_n_0\,
      CLR => \bram_addr_10bit[9]_i_2_n_0\,
      D => \bess_bram_addr[0]_i_1_n_0\,
      Q => \bess_bram_addr_reg_n_0_[0]\
    );
\bess_bram_addr_reg[1]\: unisim.vcomponents.FDCE
     port map (
      C => clkin,
      CE => \bess_bram_addr[9]_i_1_n_0\,
      CLR => \bram_addr_10bit[9]_i_2_n_0\,
      D => bess_bram_addr(1),
      Q => \bess_bram_addr_reg_n_0_[1]\
    );
\bess_bram_addr_reg[2]\: unisim.vcomponents.FDCE
     port map (
      C => clkin,
      CE => \bess_bram_addr[9]_i_1_n_0\,
      CLR => \bram_addr_10bit[9]_i_2_n_0\,
      D => bess_bram_addr(2),
      Q => \bess_bram_addr_reg_n_0_[2]\
    );
\bess_bram_addr_reg[3]\: unisim.vcomponents.FDCE
     port map (
      C => clkin,
      CE => \bess_bram_addr[9]_i_1_n_0\,
      CLR => \bram_addr_10bit[9]_i_2_n_0\,
      D => bess_bram_addr(3),
      Q => \bess_bram_addr_reg_n_0_[3]\
    );
\bess_bram_addr_reg[4]\: unisim.vcomponents.FDCE
     port map (
      C => clkin,
      CE => \bess_bram_addr[9]_i_1_n_0\,
      CLR => \bram_addr_10bit[9]_i_2_n_0\,
      D => bess_bram_addr(4),
      Q => \bess_bram_addr_reg_n_0_[4]\
    );
\bess_bram_addr_reg[5]\: unisim.vcomponents.FDCE
     port map (
      C => clkin,
      CE => \bess_bram_addr[9]_i_1_n_0\,
      CLR => \bram_addr_10bit[9]_i_2_n_0\,
      D => bess_bram_addr(5),
      Q => \bess_bram_addr_reg_n_0_[5]\
    );
\bess_bram_addr_reg[6]\: unisim.vcomponents.FDCE
     port map (
      C => clkin,
      CE => \bess_bram_addr[9]_i_1_n_0\,
      CLR => \bram_addr_10bit[9]_i_2_n_0\,
      D => bess_bram_addr(6),
      Q => \bess_bram_addr_reg_n_0_[6]\
    );
\bess_bram_addr_reg[7]\: unisim.vcomponents.FDCE
     port map (
      C => clkin,
      CE => \bess_bram_addr[9]_i_1_n_0\,
      CLR => \bram_addr_10bit[9]_i_2_n_0\,
      D => bess_bram_addr(7),
      Q => \bess_bram_addr_reg_n_0_[7]\
    );
\bess_bram_addr_reg[8]\: unisim.vcomponents.FDCE
     port map (
      C => clkin,
      CE => \bess_bram_addr[9]_i_1_n_0\,
      CLR => \bram_addr_10bit[9]_i_2_n_0\,
      D => bess_bram_addr(8),
      Q => \bess_bram_addr_reg_n_0_[8]\
    );
\bess_bram_addr_reg[9]\: unisim.vcomponents.FDCE
     port map (
      C => clkin,
      CE => \bess_bram_addr[9]_i_1_n_0\,
      CLR => \bram_addr_10bit[9]_i_2_n_0\,
      D => bess_bram_addr(9),
      Q => \bess_bram_addr_reg_n_0_[9]\
    );
bess_bram_enb_i_1: unisim.vcomponents.LUT4
    generic map(
      INIT => X"3332"
    )
        port map (
      I0 => bess_rdata_sig_reg_n_0,
      I1 => state_bess_r(2),
      I2 => state_bess_r(1),
      I3 => state_bess_r(0),
      O => bess_bram_enb
    );
bess_bram_enb_reg: unisim.vcomponents.FDCE
     port map (
      C => clkin,
      CE => \bess_bram_addr[9]_i_1_n_0\,
      CLR => \bram_addr_10bit[9]_i_2_n_0\,
      D => bess_bram_enb,
      Q => bess_bram_enb_reg_n_0
    );
\bess_fault_r_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \bess_status_r[6]_i_1_n_0\,
      D => bram_din(8),
      Q => bess_fault_r(0),
      R => '0'
    );
\bess_fault_r_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \bess_status_r[6]_i_1_n_0\,
      D => bram_din(9),
      Q => bess_fault_r(1),
      R => '0'
    );
\bess_fault_r_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \bess_status_r[6]_i_1_n_0\,
      D => bram_din(10),
      Q => bess_fault_r(2),
      R => '0'
    );
\bess_fault_r_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \bess_status_r[6]_i_1_n_0\,
      D => bram_din(11),
      Q => bess_fault_r(3),
      R => '0'
    );
\bess_fault_r_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \bess_status_r[6]_i_1_n_0\,
      D => bram_din(12),
      Q => bess_fault_r(4),
      R => '0'
    );
\bess_fault_r_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \bess_status_r[6]_i_1_n_0\,
      D => bram_din(13),
      Q => bess_fault_r(5),
      R => '0'
    );
\bess_fault_r_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \bess_status_r[6]_i_1_n_0\,
      D => bram_din(14),
      Q => bess_fault_r(6),
      R => '0'
    );
\bess_fault_r_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \bess_status_r[6]_i_1_n_0\,
      D => bram_din(15),
      Q => bess_fault_r(7),
      R => '0'
    );
bess_islandmode_r_reg: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \bess_status_r[6]_i_1_n_0\,
      D => bram_din(7),
      Q => bess_islandmode_r,
      R => '0'
    );
\bess_maxchgpwr_r[31]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"4000"
    )
        port map (
      I0 => state_bess_r(0),
      I1 => arst_n,
      I2 => state_bess_r(2),
      I3 => state_bess_r(1),
      O => \bess_maxchgpwr_r[31]_i_1_n_0\
    );
\bess_maxchgpwr_r_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \bess_maxchgpwr_r[31]_i_1_n_0\,
      D => bram_din(0),
      Q => bess_maxchgpwr_r(0),
      R => '0'
    );
\bess_maxchgpwr_r_reg[10]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \bess_maxchgpwr_r[31]_i_1_n_0\,
      D => bram_din(10),
      Q => bess_maxchgpwr_r(10),
      R => '0'
    );
\bess_maxchgpwr_r_reg[11]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \bess_maxchgpwr_r[31]_i_1_n_0\,
      D => bram_din(11),
      Q => bess_maxchgpwr_r(11),
      R => '0'
    );
\bess_maxchgpwr_r_reg[12]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \bess_maxchgpwr_r[31]_i_1_n_0\,
      D => bram_din(12),
      Q => bess_maxchgpwr_r(12),
      R => '0'
    );
\bess_maxchgpwr_r_reg[13]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \bess_maxchgpwr_r[31]_i_1_n_0\,
      D => bram_din(13),
      Q => bess_maxchgpwr_r(13),
      R => '0'
    );
\bess_maxchgpwr_r_reg[14]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \bess_maxchgpwr_r[31]_i_1_n_0\,
      D => bram_din(14),
      Q => bess_maxchgpwr_r(14),
      R => '0'
    );
\bess_maxchgpwr_r_reg[15]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \bess_maxchgpwr_r[31]_i_1_n_0\,
      D => bram_din(15),
      Q => bess_maxchgpwr_r(15),
      R => '0'
    );
\bess_maxchgpwr_r_reg[16]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \bess_maxchgpwr_r[31]_i_1_n_0\,
      D => bram_din(16),
      Q => bess_maxchgpwr_r(16),
      R => '0'
    );
\bess_maxchgpwr_r_reg[17]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \bess_maxchgpwr_r[31]_i_1_n_0\,
      D => bram_din(17),
      Q => bess_maxchgpwr_r(17),
      R => '0'
    );
\bess_maxchgpwr_r_reg[18]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \bess_maxchgpwr_r[31]_i_1_n_0\,
      D => bram_din(18),
      Q => bess_maxchgpwr_r(18),
      R => '0'
    );
\bess_maxchgpwr_r_reg[19]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \bess_maxchgpwr_r[31]_i_1_n_0\,
      D => bram_din(19),
      Q => bess_maxchgpwr_r(19),
      R => '0'
    );
\bess_maxchgpwr_r_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \bess_maxchgpwr_r[31]_i_1_n_0\,
      D => bram_din(1),
      Q => bess_maxchgpwr_r(1),
      R => '0'
    );
\bess_maxchgpwr_r_reg[20]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \bess_maxchgpwr_r[31]_i_1_n_0\,
      D => bram_din(20),
      Q => bess_maxchgpwr_r(20),
      R => '0'
    );
\bess_maxchgpwr_r_reg[21]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \bess_maxchgpwr_r[31]_i_1_n_0\,
      D => bram_din(21),
      Q => bess_maxchgpwr_r(21),
      R => '0'
    );
\bess_maxchgpwr_r_reg[22]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \bess_maxchgpwr_r[31]_i_1_n_0\,
      D => bram_din(22),
      Q => bess_maxchgpwr_r(22),
      R => '0'
    );
\bess_maxchgpwr_r_reg[23]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \bess_maxchgpwr_r[31]_i_1_n_0\,
      D => bram_din(23),
      Q => bess_maxchgpwr_r(23),
      R => '0'
    );
\bess_maxchgpwr_r_reg[24]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \bess_maxchgpwr_r[31]_i_1_n_0\,
      D => bram_din(24),
      Q => bess_maxchgpwr_r(24),
      R => '0'
    );
\bess_maxchgpwr_r_reg[25]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \bess_maxchgpwr_r[31]_i_1_n_0\,
      D => bram_din(25),
      Q => bess_maxchgpwr_r(25),
      R => '0'
    );
\bess_maxchgpwr_r_reg[26]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \bess_maxchgpwr_r[31]_i_1_n_0\,
      D => bram_din(26),
      Q => bess_maxchgpwr_r(26),
      R => '0'
    );
\bess_maxchgpwr_r_reg[27]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \bess_maxchgpwr_r[31]_i_1_n_0\,
      D => bram_din(27),
      Q => bess_maxchgpwr_r(27),
      R => '0'
    );
\bess_maxchgpwr_r_reg[28]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \bess_maxchgpwr_r[31]_i_1_n_0\,
      D => bram_din(28),
      Q => bess_maxchgpwr_r(28),
      R => '0'
    );
\bess_maxchgpwr_r_reg[29]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \bess_maxchgpwr_r[31]_i_1_n_0\,
      D => bram_din(29),
      Q => bess_maxchgpwr_r(29),
      R => '0'
    );
\bess_maxchgpwr_r_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \bess_maxchgpwr_r[31]_i_1_n_0\,
      D => bram_din(2),
      Q => bess_maxchgpwr_r(2),
      R => '0'
    );
\bess_maxchgpwr_r_reg[30]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \bess_maxchgpwr_r[31]_i_1_n_0\,
      D => bram_din(30),
      Q => bess_maxchgpwr_r(30),
      R => '0'
    );
\bess_maxchgpwr_r_reg[31]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \bess_maxchgpwr_r[31]_i_1_n_0\,
      D => bram_din(31),
      Q => bess_maxchgpwr_r(31),
      R => '0'
    );
\bess_maxchgpwr_r_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \bess_maxchgpwr_r[31]_i_1_n_0\,
      D => bram_din(3),
      Q => bess_maxchgpwr_r(3),
      R => '0'
    );
\bess_maxchgpwr_r_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \bess_maxchgpwr_r[31]_i_1_n_0\,
      D => bram_din(4),
      Q => bess_maxchgpwr_r(4),
      R => '0'
    );
\bess_maxchgpwr_r_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \bess_maxchgpwr_r[31]_i_1_n_0\,
      D => bram_din(5),
      Q => bess_maxchgpwr_r(5),
      R => '0'
    );
\bess_maxchgpwr_r_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \bess_maxchgpwr_r[31]_i_1_n_0\,
      D => bram_din(6),
      Q => bess_maxchgpwr_r(6),
      R => '0'
    );
\bess_maxchgpwr_r_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \bess_maxchgpwr_r[31]_i_1_n_0\,
      D => bram_din(7),
      Q => bess_maxchgpwr_r(7),
      R => '0'
    );
\bess_maxchgpwr_r_reg[8]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \bess_maxchgpwr_r[31]_i_1_n_0\,
      D => bram_din(8),
      Q => bess_maxchgpwr_r(8),
      R => '0'
    );
\bess_maxchgpwr_r_reg[9]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \bess_maxchgpwr_r[31]_i_1_n_0\,
      D => bram_din(9),
      Q => bess_maxchgpwr_r(9),
      R => '0'
    );
\bess_maxdschgpwr_r[31]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0800"
    )
        port map (
      I0 => state_bess_r(0),
      I1 => arst_n,
      I2 => state_bess_r(1),
      I3 => state_bess_r(2),
      O => \bess_maxdschgpwr_r[31]_i_1_n_0\
    );
\bess_maxdschgpwr_r_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \bess_maxdschgpwr_r[31]_i_1_n_0\,
      D => bram_din(0),
      Q => bess_maxdschgpwr_r(0),
      R => '0'
    );
\bess_maxdschgpwr_r_reg[10]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \bess_maxdschgpwr_r[31]_i_1_n_0\,
      D => bram_din(10),
      Q => bess_maxdschgpwr_r(10),
      R => '0'
    );
\bess_maxdschgpwr_r_reg[11]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \bess_maxdschgpwr_r[31]_i_1_n_0\,
      D => bram_din(11),
      Q => bess_maxdschgpwr_r(11),
      R => '0'
    );
\bess_maxdschgpwr_r_reg[12]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \bess_maxdschgpwr_r[31]_i_1_n_0\,
      D => bram_din(12),
      Q => bess_maxdschgpwr_r(12),
      R => '0'
    );
\bess_maxdschgpwr_r_reg[13]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \bess_maxdschgpwr_r[31]_i_1_n_0\,
      D => bram_din(13),
      Q => bess_maxdschgpwr_r(13),
      R => '0'
    );
\bess_maxdschgpwr_r_reg[14]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \bess_maxdschgpwr_r[31]_i_1_n_0\,
      D => bram_din(14),
      Q => bess_maxdschgpwr_r(14),
      R => '0'
    );
\bess_maxdschgpwr_r_reg[15]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \bess_maxdschgpwr_r[31]_i_1_n_0\,
      D => bram_din(15),
      Q => bess_maxdschgpwr_r(15),
      R => '0'
    );
\bess_maxdschgpwr_r_reg[16]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \bess_maxdschgpwr_r[31]_i_1_n_0\,
      D => bram_din(16),
      Q => bess_maxdschgpwr_r(16),
      R => '0'
    );
\bess_maxdschgpwr_r_reg[17]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \bess_maxdschgpwr_r[31]_i_1_n_0\,
      D => bram_din(17),
      Q => bess_maxdschgpwr_r(17),
      R => '0'
    );
\bess_maxdschgpwr_r_reg[18]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \bess_maxdschgpwr_r[31]_i_1_n_0\,
      D => bram_din(18),
      Q => bess_maxdschgpwr_r(18),
      R => '0'
    );
\bess_maxdschgpwr_r_reg[19]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \bess_maxdschgpwr_r[31]_i_1_n_0\,
      D => bram_din(19),
      Q => bess_maxdschgpwr_r(19),
      R => '0'
    );
\bess_maxdschgpwr_r_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \bess_maxdschgpwr_r[31]_i_1_n_0\,
      D => bram_din(1),
      Q => bess_maxdschgpwr_r(1),
      R => '0'
    );
\bess_maxdschgpwr_r_reg[20]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \bess_maxdschgpwr_r[31]_i_1_n_0\,
      D => bram_din(20),
      Q => bess_maxdschgpwr_r(20),
      R => '0'
    );
\bess_maxdschgpwr_r_reg[21]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \bess_maxdschgpwr_r[31]_i_1_n_0\,
      D => bram_din(21),
      Q => bess_maxdschgpwr_r(21),
      R => '0'
    );
\bess_maxdschgpwr_r_reg[22]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \bess_maxdschgpwr_r[31]_i_1_n_0\,
      D => bram_din(22),
      Q => bess_maxdschgpwr_r(22),
      R => '0'
    );
\bess_maxdschgpwr_r_reg[23]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \bess_maxdschgpwr_r[31]_i_1_n_0\,
      D => bram_din(23),
      Q => bess_maxdschgpwr_r(23),
      R => '0'
    );
\bess_maxdschgpwr_r_reg[24]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \bess_maxdschgpwr_r[31]_i_1_n_0\,
      D => bram_din(24),
      Q => bess_maxdschgpwr_r(24),
      R => '0'
    );
\bess_maxdschgpwr_r_reg[25]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \bess_maxdschgpwr_r[31]_i_1_n_0\,
      D => bram_din(25),
      Q => bess_maxdschgpwr_r(25),
      R => '0'
    );
\bess_maxdschgpwr_r_reg[26]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \bess_maxdschgpwr_r[31]_i_1_n_0\,
      D => bram_din(26),
      Q => bess_maxdschgpwr_r(26),
      R => '0'
    );
\bess_maxdschgpwr_r_reg[27]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \bess_maxdschgpwr_r[31]_i_1_n_0\,
      D => bram_din(27),
      Q => bess_maxdschgpwr_r(27),
      R => '0'
    );
\bess_maxdschgpwr_r_reg[28]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \bess_maxdschgpwr_r[31]_i_1_n_0\,
      D => bram_din(28),
      Q => bess_maxdschgpwr_r(28),
      R => '0'
    );
\bess_maxdschgpwr_r_reg[29]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \bess_maxdschgpwr_r[31]_i_1_n_0\,
      D => bram_din(29),
      Q => bess_maxdschgpwr_r(29),
      R => '0'
    );
\bess_maxdschgpwr_r_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \bess_maxdschgpwr_r[31]_i_1_n_0\,
      D => bram_din(2),
      Q => bess_maxdschgpwr_r(2),
      R => '0'
    );
\bess_maxdschgpwr_r_reg[30]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \bess_maxdschgpwr_r[31]_i_1_n_0\,
      D => bram_din(30),
      Q => bess_maxdschgpwr_r(30),
      R => '0'
    );
\bess_maxdschgpwr_r_reg[31]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \bess_maxdschgpwr_r[31]_i_1_n_0\,
      D => bram_din(31),
      Q => bess_maxdschgpwr_r(31),
      R => '0'
    );
\bess_maxdschgpwr_r_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \bess_maxdschgpwr_r[31]_i_1_n_0\,
      D => bram_din(3),
      Q => bess_maxdschgpwr_r(3),
      R => '0'
    );
\bess_maxdschgpwr_r_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \bess_maxdschgpwr_r[31]_i_1_n_0\,
      D => bram_din(4),
      Q => bess_maxdschgpwr_r(4),
      R => '0'
    );
\bess_maxdschgpwr_r_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \bess_maxdschgpwr_r[31]_i_1_n_0\,
      D => bram_din(5),
      Q => bess_maxdschgpwr_r(5),
      R => '0'
    );
\bess_maxdschgpwr_r_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \bess_maxdschgpwr_r[31]_i_1_n_0\,
      D => bram_din(6),
      Q => bess_maxdschgpwr_r(6),
      R => '0'
    );
\bess_maxdschgpwr_r_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \bess_maxdschgpwr_r[31]_i_1_n_0\,
      D => bram_din(7),
      Q => bess_maxdschgpwr_r(7),
      R => '0'
    );
\bess_maxdschgpwr_r_reg[8]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \bess_maxdschgpwr_r[31]_i_1_n_0\,
      D => bram_din(8),
      Q => bess_maxdschgpwr_r(8),
      R => '0'
    );
\bess_maxdschgpwr_r_reg[9]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \bess_maxdschgpwr_r[31]_i_1_n_0\,
      D => bram_din(9),
      Q => bess_maxdschgpwr_r(9),
      R => '0'
    );
\bess_p_w_ltch_reg[0]\: unisim.vcomponents.FDCE
     port map (
      C => clkin,
      CE => bess_pvld_w,
      CLR => \bram_addr_10bit[9]_i_2_n_0\,
      D => bess_p_w(0),
      Q => bess_p_w_ltch(0)
    );
\bess_p_w_ltch_reg[10]\: unisim.vcomponents.FDCE
     port map (
      C => clkin,
      CE => bess_pvld_w,
      CLR => \bram_addr_10bit[9]_i_2_n_0\,
      D => bess_p_w(10),
      Q => bess_p_w_ltch(10)
    );
\bess_p_w_ltch_reg[11]\: unisim.vcomponents.FDCE
     port map (
      C => clkin,
      CE => bess_pvld_w,
      CLR => \bram_addr_10bit[9]_i_2_n_0\,
      D => bess_p_w(11),
      Q => bess_p_w_ltch(11)
    );
\bess_p_w_ltch_reg[12]\: unisim.vcomponents.FDCE
     port map (
      C => clkin,
      CE => bess_pvld_w,
      CLR => \bram_addr_10bit[9]_i_2_n_0\,
      D => bess_p_w(12),
      Q => bess_p_w_ltch(12)
    );
\bess_p_w_ltch_reg[13]\: unisim.vcomponents.FDCE
     port map (
      C => clkin,
      CE => bess_pvld_w,
      CLR => \bram_addr_10bit[9]_i_2_n_0\,
      D => bess_p_w(13),
      Q => bess_p_w_ltch(13)
    );
\bess_p_w_ltch_reg[14]\: unisim.vcomponents.FDCE
     port map (
      C => clkin,
      CE => bess_pvld_w,
      CLR => \bram_addr_10bit[9]_i_2_n_0\,
      D => bess_p_w(14),
      Q => bess_p_w_ltch(14)
    );
\bess_p_w_ltch_reg[15]\: unisim.vcomponents.FDCE
     port map (
      C => clkin,
      CE => bess_pvld_w,
      CLR => \bram_addr_10bit[9]_i_2_n_0\,
      D => bess_p_w(15),
      Q => bess_p_w_ltch(15)
    );
\bess_p_w_ltch_reg[16]\: unisim.vcomponents.FDCE
     port map (
      C => clkin,
      CE => bess_pvld_w,
      CLR => \bram_addr_10bit[9]_i_2_n_0\,
      D => bess_p_w(16),
      Q => bess_p_w_ltch(16)
    );
\bess_p_w_ltch_reg[17]\: unisim.vcomponents.FDCE
     port map (
      C => clkin,
      CE => bess_pvld_w,
      CLR => \bram_addr_10bit[9]_i_2_n_0\,
      D => bess_p_w(17),
      Q => bess_p_w_ltch(17)
    );
\bess_p_w_ltch_reg[18]\: unisim.vcomponents.FDCE
     port map (
      C => clkin,
      CE => bess_pvld_w,
      CLR => \bram_addr_10bit[9]_i_2_n_0\,
      D => bess_p_w(18),
      Q => bess_p_w_ltch(18)
    );
\bess_p_w_ltch_reg[19]\: unisim.vcomponents.FDCE
     port map (
      C => clkin,
      CE => bess_pvld_w,
      CLR => \bram_addr_10bit[9]_i_2_n_0\,
      D => bess_p_w(19),
      Q => bess_p_w_ltch(19)
    );
\bess_p_w_ltch_reg[1]\: unisim.vcomponents.FDCE
     port map (
      C => clkin,
      CE => bess_pvld_w,
      CLR => \bram_addr_10bit[9]_i_2_n_0\,
      D => bess_p_w(1),
      Q => bess_p_w_ltch(1)
    );
\bess_p_w_ltch_reg[20]\: unisim.vcomponents.FDCE
     port map (
      C => clkin,
      CE => bess_pvld_w,
      CLR => \bram_addr_10bit[9]_i_2_n_0\,
      D => bess_p_w(20),
      Q => bess_p_w_ltch(20)
    );
\bess_p_w_ltch_reg[21]\: unisim.vcomponents.FDCE
     port map (
      C => clkin,
      CE => bess_pvld_w,
      CLR => \bram_addr_10bit[9]_i_2_n_0\,
      D => bess_p_w(21),
      Q => bess_p_w_ltch(21)
    );
\bess_p_w_ltch_reg[22]\: unisim.vcomponents.FDCE
     port map (
      C => clkin,
      CE => bess_pvld_w,
      CLR => \bram_addr_10bit[9]_i_2_n_0\,
      D => bess_p_w(22),
      Q => bess_p_w_ltch(22)
    );
\bess_p_w_ltch_reg[23]\: unisim.vcomponents.FDCE
     port map (
      C => clkin,
      CE => bess_pvld_w,
      CLR => \bram_addr_10bit[9]_i_2_n_0\,
      D => bess_p_w(23),
      Q => bess_p_w_ltch(23)
    );
\bess_p_w_ltch_reg[24]\: unisim.vcomponents.FDCE
     port map (
      C => clkin,
      CE => bess_pvld_w,
      CLR => \bram_addr_10bit[9]_i_2_n_0\,
      D => bess_p_w(24),
      Q => bess_p_w_ltch(24)
    );
\bess_p_w_ltch_reg[25]\: unisim.vcomponents.FDCE
     port map (
      C => clkin,
      CE => bess_pvld_w,
      CLR => \bram_addr_10bit[9]_i_2_n_0\,
      D => bess_p_w(25),
      Q => bess_p_w_ltch(25)
    );
\bess_p_w_ltch_reg[26]\: unisim.vcomponents.FDCE
     port map (
      C => clkin,
      CE => bess_pvld_w,
      CLR => \bram_addr_10bit[9]_i_2_n_0\,
      D => bess_p_w(26),
      Q => bess_p_w_ltch(26)
    );
\bess_p_w_ltch_reg[27]\: unisim.vcomponents.FDCE
     port map (
      C => clkin,
      CE => bess_pvld_w,
      CLR => \bram_addr_10bit[9]_i_2_n_0\,
      D => bess_p_w(27),
      Q => bess_p_w_ltch(27)
    );
\bess_p_w_ltch_reg[28]\: unisim.vcomponents.FDCE
     port map (
      C => clkin,
      CE => bess_pvld_w,
      CLR => \bram_addr_10bit[9]_i_2_n_0\,
      D => bess_p_w(28),
      Q => bess_p_w_ltch(28)
    );
\bess_p_w_ltch_reg[29]\: unisim.vcomponents.FDCE
     port map (
      C => clkin,
      CE => bess_pvld_w,
      CLR => \bram_addr_10bit[9]_i_2_n_0\,
      D => bess_p_w(29),
      Q => bess_p_w_ltch(29)
    );
\bess_p_w_ltch_reg[2]\: unisim.vcomponents.FDCE
     port map (
      C => clkin,
      CE => bess_pvld_w,
      CLR => \bram_addr_10bit[9]_i_2_n_0\,
      D => bess_p_w(2),
      Q => bess_p_w_ltch(2)
    );
\bess_p_w_ltch_reg[30]\: unisim.vcomponents.FDCE
     port map (
      C => clkin,
      CE => bess_pvld_w,
      CLR => \bram_addr_10bit[9]_i_2_n_0\,
      D => bess_p_w(30),
      Q => bess_p_w_ltch(30)
    );
\bess_p_w_ltch_reg[31]\: unisim.vcomponents.FDCE
     port map (
      C => clkin,
      CE => bess_pvld_w,
      CLR => \bram_addr_10bit[9]_i_2_n_0\,
      D => bess_p_w(31),
      Q => bess_p_w_ltch(31)
    );
\bess_p_w_ltch_reg[3]\: unisim.vcomponents.FDCE
     port map (
      C => clkin,
      CE => bess_pvld_w,
      CLR => \bram_addr_10bit[9]_i_2_n_0\,
      D => bess_p_w(3),
      Q => bess_p_w_ltch(3)
    );
\bess_p_w_ltch_reg[4]\: unisim.vcomponents.FDCE
     port map (
      C => clkin,
      CE => bess_pvld_w,
      CLR => \bram_addr_10bit[9]_i_2_n_0\,
      D => bess_p_w(4),
      Q => bess_p_w_ltch(4)
    );
\bess_p_w_ltch_reg[5]\: unisim.vcomponents.FDCE
     port map (
      C => clkin,
      CE => bess_pvld_w,
      CLR => \bram_addr_10bit[9]_i_2_n_0\,
      D => bess_p_w(5),
      Q => bess_p_w_ltch(5)
    );
\bess_p_w_ltch_reg[6]\: unisim.vcomponents.FDCE
     port map (
      C => clkin,
      CE => bess_pvld_w,
      CLR => \bram_addr_10bit[9]_i_2_n_0\,
      D => bess_p_w(6),
      Q => bess_p_w_ltch(6)
    );
\bess_p_w_ltch_reg[7]\: unisim.vcomponents.FDCE
     port map (
      C => clkin,
      CE => bess_pvld_w,
      CLR => \bram_addr_10bit[9]_i_2_n_0\,
      D => bess_p_w(7),
      Q => bess_p_w_ltch(7)
    );
\bess_p_w_ltch_reg[8]\: unisim.vcomponents.FDCE
     port map (
      C => clkin,
      CE => bess_pvld_w,
      CLR => \bram_addr_10bit[9]_i_2_n_0\,
      D => bess_p_w(8),
      Q => bess_p_w_ltch(8)
    );
\bess_p_w_ltch_reg[9]\: unisim.vcomponents.FDCE
     port map (
      C => clkin,
      CE => bess_pvld_w,
      CLR => \bram_addr_10bit[9]_i_2_n_0\,
      D => bess_p_w(9),
      Q => bess_p_w_ltch(9)
    );
bess_pvld_wltch_i_1: unisim.vcomponents.LUT3
    generic map(
      INIT => X"F4"
    )
        port map (
      I0 => wcmd_sig_lastcmd(22),
      I1 => bess_pvld_wltch,
      I2 => bess_pvld_w,
      O => bess_pvld_wltch_i_1_n_0
    );
bess_pvld_wltch_reg: unisim.vcomponents.FDCE
     port map (
      C => clkin,
      CE => '1',
      CLR => \bram_addr_10bit[9]_i_2_n_0\,
      D => bess_pvld_wltch_i_1_n_0,
      Q => bess_pvld_wltch
    );
bess_rdata_sig_i_1: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00000004"
    )
        port map (
      I0 => pv_bram_rdataflg,
      I1 => bess_bram_rdataflg,
      I2 => meter_bram_rdataflg,
      I3 => usrparam_bram_rdataflg,
      I4 => state,
      O => bess_rdata_sig_i_1_n_0
    );
bess_rdata_sig_reg: unisim.vcomponents.FDCE
     port map (
      C => clkin,
      CE => '1',
      CLR => \bram_addr_10bit[9]_i_2_n_0\,
      D => bess_rdata_sig_i_1_n_0,
      Q => bess_rdata_sig_reg_n_0
    );
bess_rdata_vld_i_1: unisim.vcomponents.LUT4
    generic map(
      INIT => X"7F40"
    )
        port map (
      I0 => state_bess_r(0),
      I1 => state_bess_r(1),
      I2 => state_bess_r(2),
      I3 => \^bess_rdata_vld\,
      O => bess_rdata_vld_i_1_n_0
    );
bess_rdata_vld_reg: unisim.vcomponents.FDCE
     port map (
      C => clkin,
      CE => '1',
      CLR => \bram_addr_10bit[9]_i_2_n_0\,
      D => bess_rdata_vld_i_1_n_0,
      Q => \^bess_rdata_vld\
    );
\bess_soc_r[31]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0008"
    )
        port map (
      I0 => state_bess_r(2),
      I1 => arst_n,
      I2 => state_bess_r(0),
      I3 => state_bess_r(1),
      O => \bess_soc_r[31]_i_1_n_0\
    );
\bess_soc_r_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \bess_soc_r[31]_i_1_n_0\,
      D => bram_din(0),
      Q => bess_soc_r(0),
      R => '0'
    );
\bess_soc_r_reg[10]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \bess_soc_r[31]_i_1_n_0\,
      D => bram_din(10),
      Q => bess_soc_r(10),
      R => '0'
    );
\bess_soc_r_reg[11]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \bess_soc_r[31]_i_1_n_0\,
      D => bram_din(11),
      Q => bess_soc_r(11),
      R => '0'
    );
\bess_soc_r_reg[12]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \bess_soc_r[31]_i_1_n_0\,
      D => bram_din(12),
      Q => bess_soc_r(12),
      R => '0'
    );
\bess_soc_r_reg[13]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \bess_soc_r[31]_i_1_n_0\,
      D => bram_din(13),
      Q => bess_soc_r(13),
      R => '0'
    );
\bess_soc_r_reg[14]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \bess_soc_r[31]_i_1_n_0\,
      D => bram_din(14),
      Q => bess_soc_r(14),
      R => '0'
    );
\bess_soc_r_reg[15]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \bess_soc_r[31]_i_1_n_0\,
      D => bram_din(15),
      Q => bess_soc_r(15),
      R => '0'
    );
\bess_soc_r_reg[16]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \bess_soc_r[31]_i_1_n_0\,
      D => bram_din(16),
      Q => bess_soc_r(16),
      R => '0'
    );
\bess_soc_r_reg[17]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \bess_soc_r[31]_i_1_n_0\,
      D => bram_din(17),
      Q => bess_soc_r(17),
      R => '0'
    );
\bess_soc_r_reg[18]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \bess_soc_r[31]_i_1_n_0\,
      D => bram_din(18),
      Q => bess_soc_r(18),
      R => '0'
    );
\bess_soc_r_reg[19]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \bess_soc_r[31]_i_1_n_0\,
      D => bram_din(19),
      Q => bess_soc_r(19),
      R => '0'
    );
\bess_soc_r_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \bess_soc_r[31]_i_1_n_0\,
      D => bram_din(1),
      Q => bess_soc_r(1),
      R => '0'
    );
\bess_soc_r_reg[20]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \bess_soc_r[31]_i_1_n_0\,
      D => bram_din(20),
      Q => bess_soc_r(20),
      R => '0'
    );
\bess_soc_r_reg[21]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \bess_soc_r[31]_i_1_n_0\,
      D => bram_din(21),
      Q => bess_soc_r(21),
      R => '0'
    );
\bess_soc_r_reg[22]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \bess_soc_r[31]_i_1_n_0\,
      D => bram_din(22),
      Q => bess_soc_r(22),
      R => '0'
    );
\bess_soc_r_reg[23]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \bess_soc_r[31]_i_1_n_0\,
      D => bram_din(23),
      Q => bess_soc_r(23),
      R => '0'
    );
\bess_soc_r_reg[24]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \bess_soc_r[31]_i_1_n_0\,
      D => bram_din(24),
      Q => bess_soc_r(24),
      R => '0'
    );
\bess_soc_r_reg[25]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \bess_soc_r[31]_i_1_n_0\,
      D => bram_din(25),
      Q => bess_soc_r(25),
      R => '0'
    );
\bess_soc_r_reg[26]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \bess_soc_r[31]_i_1_n_0\,
      D => bram_din(26),
      Q => bess_soc_r(26),
      R => '0'
    );
\bess_soc_r_reg[27]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \bess_soc_r[31]_i_1_n_0\,
      D => bram_din(27),
      Q => bess_soc_r(27),
      R => '0'
    );
\bess_soc_r_reg[28]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \bess_soc_r[31]_i_1_n_0\,
      D => bram_din(28),
      Q => bess_soc_r(28),
      R => '0'
    );
\bess_soc_r_reg[29]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \bess_soc_r[31]_i_1_n_0\,
      D => bram_din(29),
      Q => bess_soc_r(29),
      R => '0'
    );
\bess_soc_r_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \bess_soc_r[31]_i_1_n_0\,
      D => bram_din(2),
      Q => bess_soc_r(2),
      R => '0'
    );
\bess_soc_r_reg[30]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \bess_soc_r[31]_i_1_n_0\,
      D => bram_din(30),
      Q => bess_soc_r(30),
      R => '0'
    );
\bess_soc_r_reg[31]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \bess_soc_r[31]_i_1_n_0\,
      D => bram_din(31),
      Q => bess_soc_r(31),
      R => '0'
    );
\bess_soc_r_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \bess_soc_r[31]_i_1_n_0\,
      D => bram_din(3),
      Q => bess_soc_r(3),
      R => '0'
    );
\bess_soc_r_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \bess_soc_r[31]_i_1_n_0\,
      D => bram_din(4),
      Q => bess_soc_r(4),
      R => '0'
    );
\bess_soc_r_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \bess_soc_r[31]_i_1_n_0\,
      D => bram_din(5),
      Q => bess_soc_r(5),
      R => '0'
    );
\bess_soc_r_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \bess_soc_r[31]_i_1_n_0\,
      D => bram_din(6),
      Q => bess_soc_r(6),
      R => '0'
    );
\bess_soc_r_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \bess_soc_r[31]_i_1_n_0\,
      D => bram_din(7),
      Q => bess_soc_r(7),
      R => '0'
    );
\bess_soc_r_reg[8]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \bess_soc_r[31]_i_1_n_0\,
      D => bram_din(8),
      Q => bess_soc_r(8),
      R => '0'
    );
\bess_soc_r_reg[9]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \bess_soc_r[31]_i_1_n_0\,
      D => bram_din(9),
      Q => bess_soc_r(9),
      R => '0'
    );
\bess_status_r[6]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"4000"
    )
        port map (
      I0 => state_bess_r(2),
      I1 => arst_n,
      I2 => state_bess_r(0),
      I3 => state_bess_r(1),
      O => \bess_status_r[6]_i_1_n_0\
    );
\bess_status_r_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \bess_status_r[6]_i_1_n_0\,
      D => bram_din(0),
      Q => bess_status_r(0),
      R => '0'
    );
\bess_status_r_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \bess_status_r[6]_i_1_n_0\,
      D => bram_din(1),
      Q => bess_status_r(1),
      R => '0'
    );
\bess_status_r_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \bess_status_r[6]_i_1_n_0\,
      D => bram_din(2),
      Q => bess_status_r(2),
      R => '0'
    );
\bess_status_r_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \bess_status_r[6]_i_1_n_0\,
      D => bram_din(3),
      Q => bess_status_r(3),
      R => '0'
    );
\bess_status_r_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \bess_status_r[6]_i_1_n_0\,
      D => bram_din(4),
      Q => bess_status_r(4),
      R => '0'
    );
\bess_status_r_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \bess_status_r[6]_i_1_n_0\,
      D => bram_din(5),
      Q => bess_status_r(5),
      R => '0'
    );
\bess_status_r_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \bess_status_r[6]_i_1_n_0\,
      D => bram_din(6),
      Q => bess_status_r(6),
      R => '0'
    );
\bram_addr_10bit[0]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FFFE"
    )
        port map (
      I0 => \pv_bram_addr_reg_n_0_[0]\,
      I1 => \meter_bram_addr_reg_n_0_[0]\,
      I2 => \usrparam_bram_addr_reg_n_0_[0]\,
      I3 => \bess_bram_addr_reg_n_0_[0]\,
      O => \bram_addr_10bit[0]_i_1_n_0\
    );
\bram_addr_10bit[1]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FFFE"
    )
        port map (
      I0 => \pv_bram_addr_reg_n_0_[1]\,
      I1 => \meter_bram_addr_reg_n_0_[1]\,
      I2 => \usrparam_bram_addr_reg_n_0_[1]\,
      I3 => \bess_bram_addr_reg_n_0_[1]\,
      O => \bram_addr_10bit[1]_i_1_n_0\
    );
\bram_addr_10bit[2]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FFFE"
    )
        port map (
      I0 => \pv_bram_addr_reg_n_0_[2]\,
      I1 => \meter_bram_addr_reg_n_0_[2]\,
      I2 => \usrparam_bram_addr_reg_n_0_[2]\,
      I3 => \bess_bram_addr_reg_n_0_[2]\,
      O => \bram_addr_10bit[2]_i_1_n_0\
    );
\bram_addr_10bit[3]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FFFE"
    )
        port map (
      I0 => \pv_bram_addr_reg_n_0_[3]\,
      I1 => \meter_bram_addr_reg_n_0_[3]\,
      I2 => \usrparam_bram_addr_reg_n_0_[3]\,
      I3 => \bess_bram_addr_reg_n_0_[3]\,
      O => \bram_addr_10bit[3]_i_1_n_0\
    );
\bram_addr_10bit[4]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FFFE"
    )
        port map (
      I0 => \pv_bram_addr_reg_n_0_[4]\,
      I1 => \meter_bram_addr_reg_n_0_[4]\,
      I2 => \usrparam_bram_addr_reg_n_0_[4]\,
      I3 => \bess_bram_addr_reg_n_0_[4]\,
      O => \bram_addr_10bit[4]_i_1_n_0\
    );
\bram_addr_10bit[5]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FFFE"
    )
        port map (
      I0 => \pv_bram_addr_reg_n_0_[5]\,
      I1 => \meter_bram_addr_reg_n_0_[5]\,
      I2 => \usrparam_bram_addr_reg_n_0_[5]\,
      I3 => \bess_bram_addr_reg_n_0_[5]\,
      O => \bram_addr_10bit[5]_i_1_n_0\
    );
\bram_addr_10bit[6]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FFFE"
    )
        port map (
      I0 => \pv_bram_addr_reg_n_0_[6]\,
      I1 => \meter_bram_addr_reg_n_0_[6]\,
      I2 => \usrparam_bram_addr_reg_n_0_[6]\,
      I3 => \bess_bram_addr_reg_n_0_[6]\,
      O => \bram_addr_10bit[6]_i_1_n_0\
    );
\bram_addr_10bit[7]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FFFE"
    )
        port map (
      I0 => \pv_bram_addr_reg_n_0_[7]\,
      I1 => \meter_bram_addr_reg_n_0_[7]\,
      I2 => \usrparam_bram_addr_reg_n_0_[7]\,
      I3 => \bess_bram_addr_reg_n_0_[7]\,
      O => \bram_addr_10bit[7]_i_1_n_0\
    );
\bram_addr_10bit[8]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FFFE"
    )
        port map (
      I0 => \pv_bram_addr_reg_n_0_[8]\,
      I1 => \meter_bram_addr_reg_n_0_[8]\,
      I2 => \usrparam_bram_addr_reg_n_0_[8]\,
      I3 => \bess_bram_addr_reg_n_0_[8]\,
      O => \bram_addr_10bit[8]_i_1_n_0\
    );
\bram_addr_10bit[9]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FFFE"
    )
        port map (
      I0 => \pv_bram_addr_reg_n_0_[9]\,
      I1 => \meter_bram_addr_reg_n_0_[9]\,
      I2 => \usrparam_bram_addr_reg_n_0_[9]\,
      I3 => \bess_bram_addr_reg_n_0_[9]\,
      O => \bram_addr_10bit[9]_i_1_n_0\
    );
\bram_addr_10bit[9]_i_2\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => arst_n,
      O => \bram_addr_10bit[9]_i_2_n_0\
    );
\bram_addr_10bit_reg[0]\: unisim.vcomponents.FDCE
     port map (
      C => clkin,
      CE => '1',
      CLR => \bram_addr_10bit[9]_i_2_n_0\,
      D => \bram_addr_10bit[0]_i_1_n_0\,
      Q => bram_addr(0)
    );
\bram_addr_10bit_reg[1]\: unisim.vcomponents.FDCE
     port map (
      C => clkin,
      CE => '1',
      CLR => \bram_addr_10bit[9]_i_2_n_0\,
      D => \bram_addr_10bit[1]_i_1_n_0\,
      Q => bram_addr(1)
    );
\bram_addr_10bit_reg[2]\: unisim.vcomponents.FDCE
     port map (
      C => clkin,
      CE => '1',
      CLR => \bram_addr_10bit[9]_i_2_n_0\,
      D => \bram_addr_10bit[2]_i_1_n_0\,
      Q => bram_addr(2)
    );
\bram_addr_10bit_reg[3]\: unisim.vcomponents.FDCE
     port map (
      C => clkin,
      CE => '1',
      CLR => \bram_addr_10bit[9]_i_2_n_0\,
      D => \bram_addr_10bit[3]_i_1_n_0\,
      Q => bram_addr(3)
    );
\bram_addr_10bit_reg[4]\: unisim.vcomponents.FDCE
     port map (
      C => clkin,
      CE => '1',
      CLR => \bram_addr_10bit[9]_i_2_n_0\,
      D => \bram_addr_10bit[4]_i_1_n_0\,
      Q => bram_addr(4)
    );
\bram_addr_10bit_reg[5]\: unisim.vcomponents.FDCE
     port map (
      C => clkin,
      CE => '1',
      CLR => \bram_addr_10bit[9]_i_2_n_0\,
      D => \bram_addr_10bit[5]_i_1_n_0\,
      Q => bram_addr(5)
    );
\bram_addr_10bit_reg[6]\: unisim.vcomponents.FDCE
     port map (
      C => clkin,
      CE => '1',
      CLR => \bram_addr_10bit[9]_i_2_n_0\,
      D => \bram_addr_10bit[6]_i_1_n_0\,
      Q => bram_addr(6)
    );
\bram_addr_10bit_reg[7]\: unisim.vcomponents.FDCE
     port map (
      C => clkin,
      CE => '1',
      CLR => \bram_addr_10bit[9]_i_2_n_0\,
      D => \bram_addr_10bit[7]_i_1_n_0\,
      Q => bram_addr(7)
    );
\bram_addr_10bit_reg[8]\: unisim.vcomponents.FDCE
     port map (
      C => clkin,
      CE => '1',
      CLR => \bram_addr_10bit[9]_i_2_n_0\,
      D => \bram_addr_10bit[8]_i_1_n_0\,
      Q => bram_addr(8)
    );
\bram_addr_10bit_reg[9]\: unisim.vcomponents.FDCE
     port map (
      C => clkin,
      CE => '1',
      CLR => \bram_addr_10bit[9]_i_2_n_0\,
      D => \bram_addr_10bit[9]_i_1_n_0\,
      Q => bram_addr(9)
    );
bram_enb0: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FFFE"
    )
        port map (
      I0 => usrparam_bram_enb_reg_n_0,
      I1 => bess_bram_enb_reg_n_0,
      I2 => pv_bram_enb_reg_n_0,
      I3 => meter_bram_enb_reg_n_0,
      O => bram_enb0_n_0
    );
bram_enb_reg: unisim.vcomponents.FDCE
     port map (
      C => clkin,
      CE => '1',
      CLR => \bram_addr_10bit[9]_i_2_n_0\,
      D => bram_enb0_n_0,
      Q => bram_enb
    );
\bramw_addr_10bit[2]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00000000000000E0"
    )
        port map (
      I0 => pv_pvld_wltch,
      I1 => bess_pvld_wltch,
      I2 => arst_n,
      I3 => state_wcmd(1),
      I4 => \state_wcmd1__1\,
      I5 => state_wcmd(0),
      O => \bramw_addr_10bit[2]_i_1_n_0\
    );
\bramw_addr_10bit[2]_i_2\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => bess_pvld_wltch,
      O => \bramw_addr_10bit[2]_i_2_n_0\
    );
\bramw_addr_10bit[2]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"4444444444444440"
    )
        port map (
      I0 => pspl_wcmd_bsyreg,
      I1 => pspl_wcmd_bsy,
      I2 => \wcmd_sig_hld_reg_n_0_[30]\,
      I3 => \wcmd_sig_hld_reg_n_0_[14]\,
      I4 => \wcmd_sig_hld_reg_n_0_[22]\,
      I5 => \wcmd_sig_hld_reg_n_0_[29]\,
      O => \state_wcmd1__1\
    );
\bramw_addr_10bit_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \bramw_addr_10bit[2]_i_1_n_0\,
      D => bess_pvld_wltch,
      Q => bramw_addr(0),
      R => '0'
    );
\bramw_addr_10bit_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \bramw_addr_10bit[2]_i_1_n_0\,
      D => \bramw_addr_10bit[2]_i_2_n_0\,
      Q => bramw_addr(1),
      R => '0'
    );
\bramw_dout[0]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => bess_p_w_ltch(0),
      I1 => bess_pvld_wltch,
      I2 => pv_p_w_ltch(0),
      O => \bramw_dout[0]_i_1_n_0\
    );
\bramw_dout[10]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => bess_p_w_ltch(10),
      I1 => bess_pvld_wltch,
      I2 => pv_p_w_ltch(10),
      O => \bramw_dout[10]_i_1_n_0\
    );
\bramw_dout[11]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => bess_p_w_ltch(11),
      I1 => bess_pvld_wltch,
      I2 => pv_p_w_ltch(11),
      O => \bramw_dout[11]_i_1_n_0\
    );
\bramw_dout[12]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => bess_p_w_ltch(12),
      I1 => bess_pvld_wltch,
      I2 => pv_p_w_ltch(12),
      O => \bramw_dout[12]_i_1_n_0\
    );
\bramw_dout[13]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => bess_p_w_ltch(13),
      I1 => bess_pvld_wltch,
      I2 => pv_p_w_ltch(13),
      O => \bramw_dout[13]_i_1_n_0\
    );
\bramw_dout[14]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => bess_p_w_ltch(14),
      I1 => bess_pvld_wltch,
      I2 => pv_p_w_ltch(14),
      O => \bramw_dout[14]_i_1_n_0\
    );
\bramw_dout[15]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => bess_p_w_ltch(15),
      I1 => bess_pvld_wltch,
      I2 => pv_p_w_ltch(15),
      O => \bramw_dout[15]_i_1_n_0\
    );
\bramw_dout[16]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => bess_p_w_ltch(16),
      I1 => bess_pvld_wltch,
      I2 => pv_p_w_ltch(16),
      O => \bramw_dout[16]_i_1_n_0\
    );
\bramw_dout[17]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => bess_p_w_ltch(17),
      I1 => bess_pvld_wltch,
      I2 => pv_p_w_ltch(17),
      O => \bramw_dout[17]_i_1_n_0\
    );
\bramw_dout[18]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => bess_p_w_ltch(18),
      I1 => bess_pvld_wltch,
      I2 => pv_p_w_ltch(18),
      O => \bramw_dout[18]_i_1_n_0\
    );
\bramw_dout[19]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => bess_p_w_ltch(19),
      I1 => bess_pvld_wltch,
      I2 => pv_p_w_ltch(19),
      O => \bramw_dout[19]_i_1_n_0\
    );
\bramw_dout[1]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => bess_p_w_ltch(1),
      I1 => bess_pvld_wltch,
      I2 => pv_p_w_ltch(1),
      O => \bramw_dout[1]_i_1_n_0\
    );
\bramw_dout[20]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => bess_p_w_ltch(20),
      I1 => bess_pvld_wltch,
      I2 => pv_p_w_ltch(20),
      O => \bramw_dout[20]_i_1_n_0\
    );
\bramw_dout[21]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => bess_p_w_ltch(21),
      I1 => bess_pvld_wltch,
      I2 => pv_p_w_ltch(21),
      O => \bramw_dout[21]_i_1_n_0\
    );
\bramw_dout[22]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => bess_p_w_ltch(22),
      I1 => bess_pvld_wltch,
      I2 => pv_p_w_ltch(22),
      O => \bramw_dout[22]_i_1_n_0\
    );
\bramw_dout[23]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => bess_p_w_ltch(23),
      I1 => bess_pvld_wltch,
      I2 => pv_p_w_ltch(23),
      O => \bramw_dout[23]_i_1_n_0\
    );
\bramw_dout[24]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => bess_p_w_ltch(24),
      I1 => bess_pvld_wltch,
      I2 => pv_p_w_ltch(24),
      O => \bramw_dout[24]_i_1_n_0\
    );
\bramw_dout[25]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => bess_p_w_ltch(25),
      I1 => bess_pvld_wltch,
      I2 => pv_p_w_ltch(25),
      O => \bramw_dout[25]_i_1_n_0\
    );
\bramw_dout[26]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => bess_p_w_ltch(26),
      I1 => bess_pvld_wltch,
      I2 => pv_p_w_ltch(26),
      O => \bramw_dout[26]_i_1_n_0\
    );
\bramw_dout[27]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => bess_p_w_ltch(27),
      I1 => bess_pvld_wltch,
      I2 => pv_p_w_ltch(27),
      O => \bramw_dout[27]_i_1_n_0\
    );
\bramw_dout[28]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => bess_p_w_ltch(28),
      I1 => bess_pvld_wltch,
      I2 => pv_p_w_ltch(28),
      O => \bramw_dout[28]_i_1_n_0\
    );
\bramw_dout[29]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => bess_p_w_ltch(29),
      I1 => bess_pvld_wltch,
      I2 => pv_p_w_ltch(29),
      O => \bramw_dout[29]_i_1_n_0\
    );
\bramw_dout[2]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => bess_p_w_ltch(2),
      I1 => bess_pvld_wltch,
      I2 => pv_p_w_ltch(2),
      O => \bramw_dout[2]_i_1_n_0\
    );
\bramw_dout[30]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => bess_p_w_ltch(30),
      I1 => bess_pvld_wltch,
      I2 => pv_p_w_ltch(30),
      O => \bramw_dout[30]_i_1_n_0\
    );
\bramw_dout[31]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => bess_p_w_ltch(31),
      I1 => bess_pvld_wltch,
      I2 => pv_p_w_ltch(31),
      O => \bramw_dout[31]_i_1_n_0\
    );
\bramw_dout[3]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => bess_p_w_ltch(3),
      I1 => bess_pvld_wltch,
      I2 => pv_p_w_ltch(3),
      O => \bramw_dout[3]_i_1_n_0\
    );
\bramw_dout[4]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => bess_p_w_ltch(4),
      I1 => bess_pvld_wltch,
      I2 => pv_p_w_ltch(4),
      O => \bramw_dout[4]_i_1_n_0\
    );
\bramw_dout[5]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => bess_p_w_ltch(5),
      I1 => bess_pvld_wltch,
      I2 => pv_p_w_ltch(5),
      O => \bramw_dout[5]_i_1_n_0\
    );
\bramw_dout[6]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => bess_p_w_ltch(6),
      I1 => bess_pvld_wltch,
      I2 => pv_p_w_ltch(6),
      O => \bramw_dout[6]_i_1_n_0\
    );
\bramw_dout[7]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => bess_p_w_ltch(7),
      I1 => bess_pvld_wltch,
      I2 => pv_p_w_ltch(7),
      O => \bramw_dout[7]_i_1_n_0\
    );
\bramw_dout[8]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => bess_p_w_ltch(8),
      I1 => bess_pvld_wltch,
      I2 => pv_p_w_ltch(8),
      O => \bramw_dout[8]_i_1_n_0\
    );
\bramw_dout[9]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => bess_p_w_ltch(9),
      I1 => bess_pvld_wltch,
      I2 => pv_p_w_ltch(9),
      O => \bramw_dout[9]_i_1_n_0\
    );
\bramw_dout_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \bramw_addr_10bit[2]_i_1_n_0\,
      D => \bramw_dout[0]_i_1_n_0\,
      Q => bramw_dout(0),
      R => '0'
    );
\bramw_dout_reg[10]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \bramw_addr_10bit[2]_i_1_n_0\,
      D => \bramw_dout[10]_i_1_n_0\,
      Q => bramw_dout(10),
      R => '0'
    );
\bramw_dout_reg[11]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \bramw_addr_10bit[2]_i_1_n_0\,
      D => \bramw_dout[11]_i_1_n_0\,
      Q => bramw_dout(11),
      R => '0'
    );
\bramw_dout_reg[12]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \bramw_addr_10bit[2]_i_1_n_0\,
      D => \bramw_dout[12]_i_1_n_0\,
      Q => bramw_dout(12),
      R => '0'
    );
\bramw_dout_reg[13]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \bramw_addr_10bit[2]_i_1_n_0\,
      D => \bramw_dout[13]_i_1_n_0\,
      Q => bramw_dout(13),
      R => '0'
    );
\bramw_dout_reg[14]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \bramw_addr_10bit[2]_i_1_n_0\,
      D => \bramw_dout[14]_i_1_n_0\,
      Q => bramw_dout(14),
      R => '0'
    );
\bramw_dout_reg[15]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \bramw_addr_10bit[2]_i_1_n_0\,
      D => \bramw_dout[15]_i_1_n_0\,
      Q => bramw_dout(15),
      R => '0'
    );
\bramw_dout_reg[16]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \bramw_addr_10bit[2]_i_1_n_0\,
      D => \bramw_dout[16]_i_1_n_0\,
      Q => bramw_dout(16),
      R => '0'
    );
\bramw_dout_reg[17]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \bramw_addr_10bit[2]_i_1_n_0\,
      D => \bramw_dout[17]_i_1_n_0\,
      Q => bramw_dout(17),
      R => '0'
    );
\bramw_dout_reg[18]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \bramw_addr_10bit[2]_i_1_n_0\,
      D => \bramw_dout[18]_i_1_n_0\,
      Q => bramw_dout(18),
      R => '0'
    );
\bramw_dout_reg[19]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \bramw_addr_10bit[2]_i_1_n_0\,
      D => \bramw_dout[19]_i_1_n_0\,
      Q => bramw_dout(19),
      R => '0'
    );
\bramw_dout_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \bramw_addr_10bit[2]_i_1_n_0\,
      D => \bramw_dout[1]_i_1_n_0\,
      Q => bramw_dout(1),
      R => '0'
    );
\bramw_dout_reg[20]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \bramw_addr_10bit[2]_i_1_n_0\,
      D => \bramw_dout[20]_i_1_n_0\,
      Q => bramw_dout(20),
      R => '0'
    );
\bramw_dout_reg[21]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \bramw_addr_10bit[2]_i_1_n_0\,
      D => \bramw_dout[21]_i_1_n_0\,
      Q => bramw_dout(21),
      R => '0'
    );
\bramw_dout_reg[22]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \bramw_addr_10bit[2]_i_1_n_0\,
      D => \bramw_dout[22]_i_1_n_0\,
      Q => bramw_dout(22),
      R => '0'
    );
\bramw_dout_reg[23]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \bramw_addr_10bit[2]_i_1_n_0\,
      D => \bramw_dout[23]_i_1_n_0\,
      Q => bramw_dout(23),
      R => '0'
    );
\bramw_dout_reg[24]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \bramw_addr_10bit[2]_i_1_n_0\,
      D => \bramw_dout[24]_i_1_n_0\,
      Q => bramw_dout(24),
      R => '0'
    );
\bramw_dout_reg[25]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \bramw_addr_10bit[2]_i_1_n_0\,
      D => \bramw_dout[25]_i_1_n_0\,
      Q => bramw_dout(25),
      R => '0'
    );
\bramw_dout_reg[26]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \bramw_addr_10bit[2]_i_1_n_0\,
      D => \bramw_dout[26]_i_1_n_0\,
      Q => bramw_dout(26),
      R => '0'
    );
\bramw_dout_reg[27]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \bramw_addr_10bit[2]_i_1_n_0\,
      D => \bramw_dout[27]_i_1_n_0\,
      Q => bramw_dout(27),
      R => '0'
    );
\bramw_dout_reg[28]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \bramw_addr_10bit[2]_i_1_n_0\,
      D => \bramw_dout[28]_i_1_n_0\,
      Q => bramw_dout(28),
      R => '0'
    );
\bramw_dout_reg[29]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \bramw_addr_10bit[2]_i_1_n_0\,
      D => \bramw_dout[29]_i_1_n_0\,
      Q => bramw_dout(29),
      R => '0'
    );
\bramw_dout_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \bramw_addr_10bit[2]_i_1_n_0\,
      D => \bramw_dout[2]_i_1_n_0\,
      Q => bramw_dout(2),
      R => '0'
    );
\bramw_dout_reg[30]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \bramw_addr_10bit[2]_i_1_n_0\,
      D => \bramw_dout[30]_i_1_n_0\,
      Q => bramw_dout(30),
      R => '0'
    );
\bramw_dout_reg[31]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \bramw_addr_10bit[2]_i_1_n_0\,
      D => \bramw_dout[31]_i_1_n_0\,
      Q => bramw_dout(31),
      R => '0'
    );
\bramw_dout_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \bramw_addr_10bit[2]_i_1_n_0\,
      D => \bramw_dout[3]_i_1_n_0\,
      Q => bramw_dout(3),
      R => '0'
    );
\bramw_dout_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \bramw_addr_10bit[2]_i_1_n_0\,
      D => \bramw_dout[4]_i_1_n_0\,
      Q => bramw_dout(4),
      R => '0'
    );
\bramw_dout_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \bramw_addr_10bit[2]_i_1_n_0\,
      D => \bramw_dout[5]_i_1_n_0\,
      Q => bramw_dout(5),
      R => '0'
    );
\bramw_dout_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \bramw_addr_10bit[2]_i_1_n_0\,
      D => \bramw_dout[6]_i_1_n_0\,
      Q => bramw_dout(6),
      R => '0'
    );
\bramw_dout_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \bramw_addr_10bit[2]_i_1_n_0\,
      D => \bramw_dout[7]_i_1_n_0\,
      Q => bramw_dout(7),
      R => '0'
    );
\bramw_dout_reg[8]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \bramw_addr_10bit[2]_i_1_n_0\,
      D => \bramw_dout[8]_i_1_n_0\,
      Q => bramw_dout(8),
      R => '0'
    );
\bramw_dout_reg[9]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \bramw_addr_10bit[2]_i_1_n_0\,
      D => \bramw_dout[9]_i_1_n_0\,
      Q => bramw_dout(9),
      R => '0'
    );
\bramw_web[3]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FF00FFFF00000054"
    )
        port map (
      I0 => \state_wcmd1__1\,
      I1 => bess_pvld_wltch,
      I2 => pv_pvld_wltch,
      I3 => state_wcmd(1),
      I4 => state_wcmd(0),
      I5 => \^bramw_web\(0),
      O => \bramw_web[3]_i_1_n_0\
    );
\bramw_web_reg[3]\: unisim.vcomponents.FDCE
     port map (
      C => clkin,
      CE => '1',
      CLR => \bram_addr_10bit[9]_i_2_n_0\,
      D => \bramw_web[3]_i_1_n_0\,
      Q => \^bramw_web\(0)
    );
\meter_bram_addr[0]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"0000FDFE"
    )
        port map (
      I0 => state_meter_r(3),
      I1 => state_meter_r(1),
      I2 => state_meter_r(0),
      I3 => state_meter_r(2),
      I4 => \meter_bram_addr_reg_n_0_[0]\,
      O => meter_bram_addr(0)
    );
\meter_bram_addr[1]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000FDFEFDFE0000"
    )
        port map (
      I0 => state_meter_r(2),
      I1 => state_meter_r(0),
      I2 => state_meter_r(1),
      I3 => state_meter_r(3),
      I4 => \meter_bram_addr_reg_n_0_[0]\,
      I5 => \meter_bram_addr_reg_n_0_[1]\,
      O => meter_bram_addr(1)
    );
\meter_bram_addr[2]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"1540"
    )
        port map (
      I0 => \meter_bram_addr[9]_i_4_n_0\,
      I1 => \meter_bram_addr_reg_n_0_[1]\,
      I2 => \meter_bram_addr_reg_n_0_[0]\,
      I3 => \meter_bram_addr_reg_n_0_[2]\,
      O => meter_bram_addr(2)
    );
\meter_bram_addr[3]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"15554000"
    )
        port map (
      I0 => \meter_bram_addr[9]_i_4_n_0\,
      I1 => \meter_bram_addr_reg_n_0_[2]\,
      I2 => \meter_bram_addr_reg_n_0_[0]\,
      I3 => \meter_bram_addr_reg_n_0_[1]\,
      I4 => \meter_bram_addr_reg_n_0_[3]\,
      O => meter_bram_addr(3)
    );
\meter_bram_addr[4]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00990099999F9990"
    )
        port map (
      I0 => \meter_bram_addr[4]_i_2_n_0\,
      I1 => \meter_bram_addr_reg_n_0_[4]\,
      I2 => \meter_bram_addr[6]_i_2_n_0\,
      I3 => state_meter_r(3),
      I4 => meter_rdata_sig_reg_n_0,
      I5 => state_meter_r(2),
      O => meter_bram_addr(4)
    );
\meter_bram_addr[4]_i_2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"7FFF"
    )
        port map (
      I0 => \meter_bram_addr_reg_n_0_[2]\,
      I1 => \meter_bram_addr_reg_n_0_[0]\,
      I2 => \meter_bram_addr_reg_n_0_[1]\,
      I3 => \meter_bram_addr_reg_n_0_[3]\,
      O => \meter_bram_addr[4]_i_2_n_0\
    );
\meter_bram_addr[5]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"55515554AAA2AAA8"
    )
        port map (
      I0 => \meter_bram_addr[8]_i_2_n_0\,
      I1 => state_meter_r(3),
      I2 => state_meter_r(1),
      I3 => state_meter_r(0),
      I4 => state_meter_r(2),
      I5 => \meter_bram_addr_reg_n_0_[5]\,
      O => meter_bram_addr(5)
    );
\meter_bram_addr[6]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00990099999F9990"
    )
        port map (
      I0 => \meter_bram_addr[9]_i_3_n_0\,
      I1 => \meter_bram_addr_reg_n_0_[6]\,
      I2 => \meter_bram_addr[6]_i_2_n_0\,
      I3 => state_meter_r(3),
      I4 => meter_rdata_sig_reg_n_0,
      I5 => state_meter_r(2),
      O => meter_bram_addr(6)
    );
\meter_bram_addr[6]_i_2\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"E"
    )
        port map (
      I0 => state_meter_r(1),
      I1 => state_meter_r(0),
      O => \meter_bram_addr[6]_i_2_n_0\
    );
\meter_bram_addr[7]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"007F0080"
    )
        port map (
      I0 => \meter_bram_addr_reg_n_0_[5]\,
      I1 => \meter_bram_addr[8]_i_2_n_0\,
      I2 => \meter_bram_addr_reg_n_0_[6]\,
      I3 => \meter_bram_addr[9]_i_4_n_0\,
      I4 => \meter_bram_addr_reg_n_0_[7]\,
      O => meter_bram_addr(7)
    );
\meter_bram_addr[8]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00007FFF00008000"
    )
        port map (
      I0 => \meter_bram_addr_reg_n_0_[6]\,
      I1 => \meter_bram_addr[8]_i_2_n_0\,
      I2 => \meter_bram_addr_reg_n_0_[5]\,
      I3 => \meter_bram_addr_reg_n_0_[7]\,
      I4 => \meter_bram_addr[9]_i_4_n_0\,
      I5 => \meter_bram_addr_reg_n_0_[8]\,
      O => meter_bram_addr(8)
    );
\meter_bram_addr[8]_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"80000000"
    )
        port map (
      I0 => \meter_bram_addr_reg_n_0_[4]\,
      I1 => \meter_bram_addr_reg_n_0_[3]\,
      I2 => \meter_bram_addr_reg_n_0_[1]\,
      I3 => \meter_bram_addr_reg_n_0_[0]\,
      I4 => \meter_bram_addr_reg_n_0_[2]\,
      O => \meter_bram_addr[8]_i_2_n_0\
    );
\meter_bram_addr[9]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"777F"
    )
        port map (
      I0 => state_meter_r(2),
      I1 => state_meter_r(3),
      I2 => state_meter_r(0),
      I3 => state_meter_r(1),
      O => \meter_bram_addr[9]_i_1_n_0\
    );
\meter_bram_addr[9]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000DFFF00002000"
    )
        port map (
      I0 => \meter_bram_addr_reg_n_0_[7]\,
      I1 => \meter_bram_addr[9]_i_3_n_0\,
      I2 => \meter_bram_addr_reg_n_0_[6]\,
      I3 => \meter_bram_addr_reg_n_0_[8]\,
      I4 => \meter_bram_addr[9]_i_4_n_0\,
      I5 => \meter_bram_addr_reg_n_0_[9]\,
      O => meter_bram_addr(9)
    );
\meter_bram_addr[9]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"7FFFFFFFFFFFFFFF"
    )
        port map (
      I0 => \meter_bram_addr_reg_n_0_[2]\,
      I1 => \meter_bram_addr_reg_n_0_[0]\,
      I2 => \meter_bram_addr_reg_n_0_[1]\,
      I3 => \meter_bram_addr_reg_n_0_[3]\,
      I4 => \meter_bram_addr_reg_n_0_[4]\,
      I5 => \meter_bram_addr_reg_n_0_[5]\,
      O => \meter_bram_addr[9]_i_3_n_0\
    );
\meter_bram_addr[9]_i_4\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0201"
    )
        port map (
      I0 => state_meter_r(2),
      I1 => state_meter_r(0),
      I2 => state_meter_r(1),
      I3 => state_meter_r(3),
      O => \meter_bram_addr[9]_i_4_n_0\
    );
\meter_bram_addr_reg[0]\: unisim.vcomponents.FDCE
     port map (
      C => clkin,
      CE => \meter_bram_addr[9]_i_1_n_0\,
      CLR => \bram_addr_10bit[9]_i_2_n_0\,
      D => meter_bram_addr(0),
      Q => \meter_bram_addr_reg_n_0_[0]\
    );
\meter_bram_addr_reg[1]\: unisim.vcomponents.FDCE
     port map (
      C => clkin,
      CE => \meter_bram_addr[9]_i_1_n_0\,
      CLR => \bram_addr_10bit[9]_i_2_n_0\,
      D => meter_bram_addr(1),
      Q => \meter_bram_addr_reg_n_0_[1]\
    );
\meter_bram_addr_reg[2]\: unisim.vcomponents.FDCE
     port map (
      C => clkin,
      CE => \meter_bram_addr[9]_i_1_n_0\,
      CLR => \bram_addr_10bit[9]_i_2_n_0\,
      D => meter_bram_addr(2),
      Q => \meter_bram_addr_reg_n_0_[2]\
    );
\meter_bram_addr_reg[3]\: unisim.vcomponents.FDCE
     port map (
      C => clkin,
      CE => \meter_bram_addr[9]_i_1_n_0\,
      CLR => \bram_addr_10bit[9]_i_2_n_0\,
      D => meter_bram_addr(3),
      Q => \meter_bram_addr_reg_n_0_[3]\
    );
\meter_bram_addr_reg[4]\: unisim.vcomponents.FDCE
     port map (
      C => clkin,
      CE => \meter_bram_addr[9]_i_1_n_0\,
      CLR => \bram_addr_10bit[9]_i_2_n_0\,
      D => meter_bram_addr(4),
      Q => \meter_bram_addr_reg_n_0_[4]\
    );
\meter_bram_addr_reg[5]\: unisim.vcomponents.FDCE
     port map (
      C => clkin,
      CE => \meter_bram_addr[9]_i_1_n_0\,
      CLR => \bram_addr_10bit[9]_i_2_n_0\,
      D => meter_bram_addr(5),
      Q => \meter_bram_addr_reg_n_0_[5]\
    );
\meter_bram_addr_reg[6]\: unisim.vcomponents.FDCE
     port map (
      C => clkin,
      CE => \meter_bram_addr[9]_i_1_n_0\,
      CLR => \bram_addr_10bit[9]_i_2_n_0\,
      D => meter_bram_addr(6),
      Q => \meter_bram_addr_reg_n_0_[6]\
    );
\meter_bram_addr_reg[7]\: unisim.vcomponents.FDCE
     port map (
      C => clkin,
      CE => \meter_bram_addr[9]_i_1_n_0\,
      CLR => \bram_addr_10bit[9]_i_2_n_0\,
      D => meter_bram_addr(7),
      Q => \meter_bram_addr_reg_n_0_[7]\
    );
\meter_bram_addr_reg[8]\: unisim.vcomponents.FDCE
     port map (
      C => clkin,
      CE => \meter_bram_addr[9]_i_1_n_0\,
      CLR => \bram_addr_10bit[9]_i_2_n_0\,
      D => meter_bram_addr(8),
      Q => \meter_bram_addr_reg_n_0_[8]\
    );
\meter_bram_addr_reg[9]\: unisim.vcomponents.FDCE
     port map (
      C => clkin,
      CE => \meter_bram_addr[9]_i_1_n_0\,
      CLR => \bram_addr_10bit[9]_i_2_n_0\,
      D => meter_bram_addr(9),
      Q => \meter_bram_addr_reg_n_0_[9]\
    );
meter_bram_enb_i_1: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFFFF3E"
    )
        port map (
      I0 => meter_rdata_sig_reg_n_0,
      I1 => state_meter_r(2),
      I2 => state_meter_r(3),
      I3 => state_meter_r(1),
      I4 => state_meter_r(0),
      O => meter_bram_enb
    );
meter_bram_enb_reg: unisim.vcomponents.FDCE
     port map (
      C => clkin,
      CE => \meter_bram_addr[9]_i_1_n_0\,
      CLR => \bram_addr_10bit[9]_i_2_n_0\,
      D => meter_bram_enb,
      Q => meter_bram_enb_reg_n_0
    );
\meter_poi_3p[31]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00000080"
    )
        port map (
      I0 => state_meter_r(1),
      I1 => state_meter_r(0),
      I2 => arst_n,
      I3 => state_meter_r(2),
      I4 => state_meter_r(3),
      O => \meter_poi_3p[31]_i_1_n_0\
    );
\meter_poi_3p_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_3p[31]_i_1_n_0\,
      D => bram_din(0),
      Q => meter_poi_3p(0),
      R => '0'
    );
\meter_poi_3p_reg[10]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_3p[31]_i_1_n_0\,
      D => bram_din(10),
      Q => meter_poi_3p(10),
      R => '0'
    );
\meter_poi_3p_reg[11]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_3p[31]_i_1_n_0\,
      D => bram_din(11),
      Q => meter_poi_3p(11),
      R => '0'
    );
\meter_poi_3p_reg[12]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_3p[31]_i_1_n_0\,
      D => bram_din(12),
      Q => meter_poi_3p(12),
      R => '0'
    );
\meter_poi_3p_reg[13]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_3p[31]_i_1_n_0\,
      D => bram_din(13),
      Q => meter_poi_3p(13),
      R => '0'
    );
\meter_poi_3p_reg[14]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_3p[31]_i_1_n_0\,
      D => bram_din(14),
      Q => meter_poi_3p(14),
      R => '0'
    );
\meter_poi_3p_reg[15]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_3p[31]_i_1_n_0\,
      D => bram_din(15),
      Q => meter_poi_3p(15),
      R => '0'
    );
\meter_poi_3p_reg[16]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_3p[31]_i_1_n_0\,
      D => bram_din(16),
      Q => meter_poi_3p(16),
      R => '0'
    );
\meter_poi_3p_reg[17]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_3p[31]_i_1_n_0\,
      D => bram_din(17),
      Q => meter_poi_3p(17),
      R => '0'
    );
\meter_poi_3p_reg[18]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_3p[31]_i_1_n_0\,
      D => bram_din(18),
      Q => meter_poi_3p(18),
      R => '0'
    );
\meter_poi_3p_reg[19]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_3p[31]_i_1_n_0\,
      D => bram_din(19),
      Q => meter_poi_3p(19),
      R => '0'
    );
\meter_poi_3p_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_3p[31]_i_1_n_0\,
      D => bram_din(1),
      Q => meter_poi_3p(1),
      R => '0'
    );
\meter_poi_3p_reg[20]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_3p[31]_i_1_n_0\,
      D => bram_din(20),
      Q => meter_poi_3p(20),
      R => '0'
    );
\meter_poi_3p_reg[21]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_3p[31]_i_1_n_0\,
      D => bram_din(21),
      Q => meter_poi_3p(21),
      R => '0'
    );
\meter_poi_3p_reg[22]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_3p[31]_i_1_n_0\,
      D => bram_din(22),
      Q => meter_poi_3p(22),
      R => '0'
    );
\meter_poi_3p_reg[23]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_3p[31]_i_1_n_0\,
      D => bram_din(23),
      Q => meter_poi_3p(23),
      R => '0'
    );
\meter_poi_3p_reg[24]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_3p[31]_i_1_n_0\,
      D => bram_din(24),
      Q => meter_poi_3p(24),
      R => '0'
    );
\meter_poi_3p_reg[25]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_3p[31]_i_1_n_0\,
      D => bram_din(25),
      Q => meter_poi_3p(25),
      R => '0'
    );
\meter_poi_3p_reg[26]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_3p[31]_i_1_n_0\,
      D => bram_din(26),
      Q => meter_poi_3p(26),
      R => '0'
    );
\meter_poi_3p_reg[27]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_3p[31]_i_1_n_0\,
      D => bram_din(27),
      Q => meter_poi_3p(27),
      R => '0'
    );
\meter_poi_3p_reg[28]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_3p[31]_i_1_n_0\,
      D => bram_din(28),
      Q => meter_poi_3p(28),
      R => '0'
    );
\meter_poi_3p_reg[29]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_3p[31]_i_1_n_0\,
      D => bram_din(29),
      Q => meter_poi_3p(29),
      R => '0'
    );
\meter_poi_3p_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_3p[31]_i_1_n_0\,
      D => bram_din(2),
      Q => meter_poi_3p(2),
      R => '0'
    );
\meter_poi_3p_reg[30]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_3p[31]_i_1_n_0\,
      D => bram_din(30),
      Q => meter_poi_3p(30),
      R => '0'
    );
\meter_poi_3p_reg[31]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_3p[31]_i_1_n_0\,
      D => bram_din(31),
      Q => meter_poi_3p(31),
      R => '0'
    );
\meter_poi_3p_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_3p[31]_i_1_n_0\,
      D => bram_din(3),
      Q => meter_poi_3p(3),
      R => '0'
    );
\meter_poi_3p_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_3p[31]_i_1_n_0\,
      D => bram_din(4),
      Q => meter_poi_3p(4),
      R => '0'
    );
\meter_poi_3p_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_3p[31]_i_1_n_0\,
      D => bram_din(5),
      Q => meter_poi_3p(5),
      R => '0'
    );
\meter_poi_3p_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_3p[31]_i_1_n_0\,
      D => bram_din(6),
      Q => meter_poi_3p(6),
      R => '0'
    );
\meter_poi_3p_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_3p[31]_i_1_n_0\,
      D => bram_din(7),
      Q => meter_poi_3p(7),
      R => '0'
    );
\meter_poi_3p_reg[8]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_3p[31]_i_1_n_0\,
      D => bram_din(8),
      Q => meter_poi_3p(8),
      R => '0'
    );
\meter_poi_3p_reg[9]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_3p[31]_i_1_n_0\,
      D => bram_din(9),
      Q => meter_poi_3p(9),
      R => '0'
    );
\meter_poi_3q[31]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00000008"
    )
        port map (
      I0 => arst_n,
      I1 => state_meter_r(2),
      I2 => state_meter_r(3),
      I3 => state_meter_r(1),
      I4 => state_meter_r(0),
      O => \meter_poi_3q[31]_i_1_n_0\
    );
\meter_poi_3q_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_3q[31]_i_1_n_0\,
      D => bram_din(0),
      Q => meter_poi_3q(0),
      R => '0'
    );
\meter_poi_3q_reg[10]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_3q[31]_i_1_n_0\,
      D => bram_din(10),
      Q => meter_poi_3q(10),
      R => '0'
    );
\meter_poi_3q_reg[11]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_3q[31]_i_1_n_0\,
      D => bram_din(11),
      Q => meter_poi_3q(11),
      R => '0'
    );
\meter_poi_3q_reg[12]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_3q[31]_i_1_n_0\,
      D => bram_din(12),
      Q => meter_poi_3q(12),
      R => '0'
    );
\meter_poi_3q_reg[13]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_3q[31]_i_1_n_0\,
      D => bram_din(13),
      Q => meter_poi_3q(13),
      R => '0'
    );
\meter_poi_3q_reg[14]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_3q[31]_i_1_n_0\,
      D => bram_din(14),
      Q => meter_poi_3q(14),
      R => '0'
    );
\meter_poi_3q_reg[15]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_3q[31]_i_1_n_0\,
      D => bram_din(15),
      Q => meter_poi_3q(15),
      R => '0'
    );
\meter_poi_3q_reg[16]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_3q[31]_i_1_n_0\,
      D => bram_din(16),
      Q => meter_poi_3q(16),
      R => '0'
    );
\meter_poi_3q_reg[17]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_3q[31]_i_1_n_0\,
      D => bram_din(17),
      Q => meter_poi_3q(17),
      R => '0'
    );
\meter_poi_3q_reg[18]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_3q[31]_i_1_n_0\,
      D => bram_din(18),
      Q => meter_poi_3q(18),
      R => '0'
    );
\meter_poi_3q_reg[19]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_3q[31]_i_1_n_0\,
      D => bram_din(19),
      Q => meter_poi_3q(19),
      R => '0'
    );
\meter_poi_3q_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_3q[31]_i_1_n_0\,
      D => bram_din(1),
      Q => meter_poi_3q(1),
      R => '0'
    );
\meter_poi_3q_reg[20]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_3q[31]_i_1_n_0\,
      D => bram_din(20),
      Q => meter_poi_3q(20),
      R => '0'
    );
\meter_poi_3q_reg[21]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_3q[31]_i_1_n_0\,
      D => bram_din(21),
      Q => meter_poi_3q(21),
      R => '0'
    );
\meter_poi_3q_reg[22]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_3q[31]_i_1_n_0\,
      D => bram_din(22),
      Q => meter_poi_3q(22),
      R => '0'
    );
\meter_poi_3q_reg[23]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_3q[31]_i_1_n_0\,
      D => bram_din(23),
      Q => meter_poi_3q(23),
      R => '0'
    );
\meter_poi_3q_reg[24]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_3q[31]_i_1_n_0\,
      D => bram_din(24),
      Q => meter_poi_3q(24),
      R => '0'
    );
\meter_poi_3q_reg[25]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_3q[31]_i_1_n_0\,
      D => bram_din(25),
      Q => meter_poi_3q(25),
      R => '0'
    );
\meter_poi_3q_reg[26]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_3q[31]_i_1_n_0\,
      D => bram_din(26),
      Q => meter_poi_3q(26),
      R => '0'
    );
\meter_poi_3q_reg[27]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_3q[31]_i_1_n_0\,
      D => bram_din(27),
      Q => meter_poi_3q(27),
      R => '0'
    );
\meter_poi_3q_reg[28]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_3q[31]_i_1_n_0\,
      D => bram_din(28),
      Q => meter_poi_3q(28),
      R => '0'
    );
\meter_poi_3q_reg[29]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_3q[31]_i_1_n_0\,
      D => bram_din(29),
      Q => meter_poi_3q(29),
      R => '0'
    );
\meter_poi_3q_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_3q[31]_i_1_n_0\,
      D => bram_din(2),
      Q => meter_poi_3q(2),
      R => '0'
    );
\meter_poi_3q_reg[30]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_3q[31]_i_1_n_0\,
      D => bram_din(30),
      Q => meter_poi_3q(30),
      R => '0'
    );
\meter_poi_3q_reg[31]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_3q[31]_i_1_n_0\,
      D => bram_din(31),
      Q => meter_poi_3q(31),
      R => '0'
    );
\meter_poi_3q_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_3q[31]_i_1_n_0\,
      D => bram_din(3),
      Q => meter_poi_3q(3),
      R => '0'
    );
\meter_poi_3q_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_3q[31]_i_1_n_0\,
      D => bram_din(4),
      Q => meter_poi_3q(4),
      R => '0'
    );
\meter_poi_3q_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_3q[31]_i_1_n_0\,
      D => bram_din(5),
      Q => meter_poi_3q(5),
      R => '0'
    );
\meter_poi_3q_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_3q[31]_i_1_n_0\,
      D => bram_din(6),
      Q => meter_poi_3q(6),
      R => '0'
    );
\meter_poi_3q_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_3q[31]_i_1_n_0\,
      D => bram_din(7),
      Q => meter_poi_3q(7),
      R => '0'
    );
\meter_poi_3q_reg[8]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_3q[31]_i_1_n_0\,
      D => bram_din(8),
      Q => meter_poi_3q(8),
      R => '0'
    );
\meter_poi_3q_reg[9]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_3q[31]_i_1_n_0\,
      D => bram_din(9),
      Q => meter_poi_3q(9),
      R => '0'
    );
\meter_poi_3s[31]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00080000"
    )
        port map (
      I0 => arst_n,
      I1 => state_meter_r(2),
      I2 => state_meter_r(3),
      I3 => state_meter_r(1),
      I4 => state_meter_r(0),
      O => \meter_poi_3s[31]_i_1_n_0\
    );
\meter_poi_3s_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_3s[31]_i_1_n_0\,
      D => bram_din(0),
      Q => meter_poi_3s(0),
      R => '0'
    );
\meter_poi_3s_reg[10]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_3s[31]_i_1_n_0\,
      D => bram_din(10),
      Q => meter_poi_3s(10),
      R => '0'
    );
\meter_poi_3s_reg[11]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_3s[31]_i_1_n_0\,
      D => bram_din(11),
      Q => meter_poi_3s(11),
      R => '0'
    );
\meter_poi_3s_reg[12]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_3s[31]_i_1_n_0\,
      D => bram_din(12),
      Q => meter_poi_3s(12),
      R => '0'
    );
\meter_poi_3s_reg[13]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_3s[31]_i_1_n_0\,
      D => bram_din(13),
      Q => meter_poi_3s(13),
      R => '0'
    );
\meter_poi_3s_reg[14]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_3s[31]_i_1_n_0\,
      D => bram_din(14),
      Q => meter_poi_3s(14),
      R => '0'
    );
\meter_poi_3s_reg[15]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_3s[31]_i_1_n_0\,
      D => bram_din(15),
      Q => meter_poi_3s(15),
      R => '0'
    );
\meter_poi_3s_reg[16]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_3s[31]_i_1_n_0\,
      D => bram_din(16),
      Q => meter_poi_3s(16),
      R => '0'
    );
\meter_poi_3s_reg[17]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_3s[31]_i_1_n_0\,
      D => bram_din(17),
      Q => meter_poi_3s(17),
      R => '0'
    );
\meter_poi_3s_reg[18]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_3s[31]_i_1_n_0\,
      D => bram_din(18),
      Q => meter_poi_3s(18),
      R => '0'
    );
\meter_poi_3s_reg[19]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_3s[31]_i_1_n_0\,
      D => bram_din(19),
      Q => meter_poi_3s(19),
      R => '0'
    );
\meter_poi_3s_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_3s[31]_i_1_n_0\,
      D => bram_din(1),
      Q => meter_poi_3s(1),
      R => '0'
    );
\meter_poi_3s_reg[20]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_3s[31]_i_1_n_0\,
      D => bram_din(20),
      Q => meter_poi_3s(20),
      R => '0'
    );
\meter_poi_3s_reg[21]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_3s[31]_i_1_n_0\,
      D => bram_din(21),
      Q => meter_poi_3s(21),
      R => '0'
    );
\meter_poi_3s_reg[22]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_3s[31]_i_1_n_0\,
      D => bram_din(22),
      Q => meter_poi_3s(22),
      R => '0'
    );
\meter_poi_3s_reg[23]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_3s[31]_i_1_n_0\,
      D => bram_din(23),
      Q => meter_poi_3s(23),
      R => '0'
    );
\meter_poi_3s_reg[24]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_3s[31]_i_1_n_0\,
      D => bram_din(24),
      Q => meter_poi_3s(24),
      R => '0'
    );
\meter_poi_3s_reg[25]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_3s[31]_i_1_n_0\,
      D => bram_din(25),
      Q => meter_poi_3s(25),
      R => '0'
    );
\meter_poi_3s_reg[26]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_3s[31]_i_1_n_0\,
      D => bram_din(26),
      Q => meter_poi_3s(26),
      R => '0'
    );
\meter_poi_3s_reg[27]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_3s[31]_i_1_n_0\,
      D => bram_din(27),
      Q => meter_poi_3s(27),
      R => '0'
    );
\meter_poi_3s_reg[28]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_3s[31]_i_1_n_0\,
      D => bram_din(28),
      Q => meter_poi_3s(28),
      R => '0'
    );
\meter_poi_3s_reg[29]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_3s[31]_i_1_n_0\,
      D => bram_din(29),
      Q => meter_poi_3s(29),
      R => '0'
    );
\meter_poi_3s_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_3s[31]_i_1_n_0\,
      D => bram_din(2),
      Q => meter_poi_3s(2),
      R => '0'
    );
\meter_poi_3s_reg[30]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_3s[31]_i_1_n_0\,
      D => bram_din(30),
      Q => meter_poi_3s(30),
      R => '0'
    );
\meter_poi_3s_reg[31]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_3s[31]_i_1_n_0\,
      D => bram_din(31),
      Q => meter_poi_3s(31),
      R => '0'
    );
\meter_poi_3s_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_3s[31]_i_1_n_0\,
      D => bram_din(3),
      Q => meter_poi_3s(3),
      R => '0'
    );
\meter_poi_3s_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_3s[31]_i_1_n_0\,
      D => bram_din(4),
      Q => meter_poi_3s(4),
      R => '0'
    );
\meter_poi_3s_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_3s[31]_i_1_n_0\,
      D => bram_din(5),
      Q => meter_poi_3s(5),
      R => '0'
    );
\meter_poi_3s_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_3s[31]_i_1_n_0\,
      D => bram_din(6),
      Q => meter_poi_3s(6),
      R => '0'
    );
\meter_poi_3s_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_3s[31]_i_1_n_0\,
      D => bram_din(7),
      Q => meter_poi_3s(7),
      R => '0'
    );
\meter_poi_3s_reg[8]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_3s[31]_i_1_n_0\,
      D => bram_din(8),
      Q => meter_poi_3s(8),
      R => '0'
    );
\meter_poi_3s_reg[9]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_3s[31]_i_1_n_0\,
      D => bram_din(9),
      Q => meter_poi_3s(9),
      R => '0'
    );
\meter_poi_freq[31]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"40000000"
    )
        port map (
      I0 => state_meter_r(0),
      I1 => state_meter_r(1),
      I2 => arst_n,
      I3 => state_meter_r(2),
      I4 => state_meter_r(3),
      O => \meter_poi_freq[31]_i_1_n_0\
    );
\meter_poi_freq_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_freq[31]_i_1_n_0\,
      D => bram_din(0),
      Q => meter_poi_freq(0),
      R => '0'
    );
\meter_poi_freq_reg[10]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_freq[31]_i_1_n_0\,
      D => bram_din(10),
      Q => meter_poi_freq(10),
      R => '0'
    );
\meter_poi_freq_reg[11]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_freq[31]_i_1_n_0\,
      D => bram_din(11),
      Q => meter_poi_freq(11),
      R => '0'
    );
\meter_poi_freq_reg[12]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_freq[31]_i_1_n_0\,
      D => bram_din(12),
      Q => meter_poi_freq(12),
      R => '0'
    );
\meter_poi_freq_reg[13]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_freq[31]_i_1_n_0\,
      D => bram_din(13),
      Q => meter_poi_freq(13),
      R => '0'
    );
\meter_poi_freq_reg[14]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_freq[31]_i_1_n_0\,
      D => bram_din(14),
      Q => meter_poi_freq(14),
      R => '0'
    );
\meter_poi_freq_reg[15]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_freq[31]_i_1_n_0\,
      D => bram_din(15),
      Q => meter_poi_freq(15),
      R => '0'
    );
\meter_poi_freq_reg[16]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_freq[31]_i_1_n_0\,
      D => bram_din(16),
      Q => meter_poi_freq(16),
      R => '0'
    );
\meter_poi_freq_reg[17]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_freq[31]_i_1_n_0\,
      D => bram_din(17),
      Q => meter_poi_freq(17),
      R => '0'
    );
\meter_poi_freq_reg[18]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_freq[31]_i_1_n_0\,
      D => bram_din(18),
      Q => meter_poi_freq(18),
      R => '0'
    );
\meter_poi_freq_reg[19]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_freq[31]_i_1_n_0\,
      D => bram_din(19),
      Q => meter_poi_freq(19),
      R => '0'
    );
\meter_poi_freq_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_freq[31]_i_1_n_0\,
      D => bram_din(1),
      Q => meter_poi_freq(1),
      R => '0'
    );
\meter_poi_freq_reg[20]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_freq[31]_i_1_n_0\,
      D => bram_din(20),
      Q => meter_poi_freq(20),
      R => '0'
    );
\meter_poi_freq_reg[21]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_freq[31]_i_1_n_0\,
      D => bram_din(21),
      Q => meter_poi_freq(21),
      R => '0'
    );
\meter_poi_freq_reg[22]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_freq[31]_i_1_n_0\,
      D => bram_din(22),
      Q => meter_poi_freq(22),
      R => '0'
    );
\meter_poi_freq_reg[23]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_freq[31]_i_1_n_0\,
      D => bram_din(23),
      Q => meter_poi_freq(23),
      R => '0'
    );
\meter_poi_freq_reg[24]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_freq[31]_i_1_n_0\,
      D => bram_din(24),
      Q => meter_poi_freq(24),
      R => '0'
    );
\meter_poi_freq_reg[25]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_freq[31]_i_1_n_0\,
      D => bram_din(25),
      Q => meter_poi_freq(25),
      R => '0'
    );
\meter_poi_freq_reg[26]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_freq[31]_i_1_n_0\,
      D => bram_din(26),
      Q => meter_poi_freq(26),
      R => '0'
    );
\meter_poi_freq_reg[27]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_freq[31]_i_1_n_0\,
      D => bram_din(27),
      Q => meter_poi_freq(27),
      R => '0'
    );
\meter_poi_freq_reg[28]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_freq[31]_i_1_n_0\,
      D => bram_din(28),
      Q => meter_poi_freq(28),
      R => '0'
    );
\meter_poi_freq_reg[29]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_freq[31]_i_1_n_0\,
      D => bram_din(29),
      Q => meter_poi_freq(29),
      R => '0'
    );
\meter_poi_freq_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_freq[31]_i_1_n_0\,
      D => bram_din(2),
      Q => meter_poi_freq(2),
      R => '0'
    );
\meter_poi_freq_reg[30]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_freq[31]_i_1_n_0\,
      D => bram_din(30),
      Q => meter_poi_freq(30),
      R => '0'
    );
\meter_poi_freq_reg[31]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_freq[31]_i_1_n_0\,
      D => bram_din(31),
      Q => meter_poi_freq(31),
      R => '0'
    );
\meter_poi_freq_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_freq[31]_i_1_n_0\,
      D => bram_din(3),
      Q => meter_poi_freq(3),
      R => '0'
    );
\meter_poi_freq_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_freq[31]_i_1_n_0\,
      D => bram_din(4),
      Q => meter_poi_freq(4),
      R => '0'
    );
\meter_poi_freq_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_freq[31]_i_1_n_0\,
      D => bram_din(5),
      Q => meter_poi_freq(5),
      R => '0'
    );
\meter_poi_freq_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_freq[31]_i_1_n_0\,
      D => bram_din(6),
      Q => meter_poi_freq(6),
      R => '0'
    );
\meter_poi_freq_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_freq[31]_i_1_n_0\,
      D => bram_din(7),
      Q => meter_poi_freq(7),
      R => '0'
    );
\meter_poi_freq_reg[8]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_freq[31]_i_1_n_0\,
      D => bram_din(8),
      Q => meter_poi_freq(8),
      R => '0'
    );
\meter_poi_freq_reg[9]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_freq[31]_i_1_n_0\,
      D => bram_din(9),
      Q => meter_poi_freq(9),
      R => '0'
    );
\meter_poi_ia[31]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00800000"
    )
        port map (
      I0 => state_meter_r(1),
      I1 => state_meter_r(0),
      I2 => arst_n,
      I3 => state_meter_r(3),
      I4 => state_meter_r(2),
      O => \meter_poi_ia[31]_i_1_n_0\
    );
\meter_poi_ia_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_ia[31]_i_1_n_0\,
      D => bram_din(0),
      Q => meter_poi_ia(0),
      R => '0'
    );
\meter_poi_ia_reg[10]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_ia[31]_i_1_n_0\,
      D => bram_din(10),
      Q => meter_poi_ia(10),
      R => '0'
    );
\meter_poi_ia_reg[11]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_ia[31]_i_1_n_0\,
      D => bram_din(11),
      Q => meter_poi_ia(11),
      R => '0'
    );
\meter_poi_ia_reg[12]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_ia[31]_i_1_n_0\,
      D => bram_din(12),
      Q => meter_poi_ia(12),
      R => '0'
    );
\meter_poi_ia_reg[13]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_ia[31]_i_1_n_0\,
      D => bram_din(13),
      Q => meter_poi_ia(13),
      R => '0'
    );
\meter_poi_ia_reg[14]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_ia[31]_i_1_n_0\,
      D => bram_din(14),
      Q => meter_poi_ia(14),
      R => '0'
    );
\meter_poi_ia_reg[15]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_ia[31]_i_1_n_0\,
      D => bram_din(15),
      Q => meter_poi_ia(15),
      R => '0'
    );
\meter_poi_ia_reg[16]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_ia[31]_i_1_n_0\,
      D => bram_din(16),
      Q => meter_poi_ia(16),
      R => '0'
    );
\meter_poi_ia_reg[17]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_ia[31]_i_1_n_0\,
      D => bram_din(17),
      Q => meter_poi_ia(17),
      R => '0'
    );
\meter_poi_ia_reg[18]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_ia[31]_i_1_n_0\,
      D => bram_din(18),
      Q => meter_poi_ia(18),
      R => '0'
    );
\meter_poi_ia_reg[19]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_ia[31]_i_1_n_0\,
      D => bram_din(19),
      Q => meter_poi_ia(19),
      R => '0'
    );
\meter_poi_ia_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_ia[31]_i_1_n_0\,
      D => bram_din(1),
      Q => meter_poi_ia(1),
      R => '0'
    );
\meter_poi_ia_reg[20]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_ia[31]_i_1_n_0\,
      D => bram_din(20),
      Q => meter_poi_ia(20),
      R => '0'
    );
\meter_poi_ia_reg[21]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_ia[31]_i_1_n_0\,
      D => bram_din(21),
      Q => meter_poi_ia(21),
      R => '0'
    );
\meter_poi_ia_reg[22]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_ia[31]_i_1_n_0\,
      D => bram_din(22),
      Q => meter_poi_ia(22),
      R => '0'
    );
\meter_poi_ia_reg[23]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_ia[31]_i_1_n_0\,
      D => bram_din(23),
      Q => meter_poi_ia(23),
      R => '0'
    );
\meter_poi_ia_reg[24]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_ia[31]_i_1_n_0\,
      D => bram_din(24),
      Q => meter_poi_ia(24),
      R => '0'
    );
\meter_poi_ia_reg[25]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_ia[31]_i_1_n_0\,
      D => bram_din(25),
      Q => meter_poi_ia(25),
      R => '0'
    );
\meter_poi_ia_reg[26]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_ia[31]_i_1_n_0\,
      D => bram_din(26),
      Q => meter_poi_ia(26),
      R => '0'
    );
\meter_poi_ia_reg[27]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_ia[31]_i_1_n_0\,
      D => bram_din(27),
      Q => meter_poi_ia(27),
      R => '0'
    );
\meter_poi_ia_reg[28]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_ia[31]_i_1_n_0\,
      D => bram_din(28),
      Q => meter_poi_ia(28),
      R => '0'
    );
\meter_poi_ia_reg[29]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_ia[31]_i_1_n_0\,
      D => bram_din(29),
      Q => meter_poi_ia(29),
      R => '0'
    );
\meter_poi_ia_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_ia[31]_i_1_n_0\,
      D => bram_din(2),
      Q => meter_poi_ia(2),
      R => '0'
    );
\meter_poi_ia_reg[30]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_ia[31]_i_1_n_0\,
      D => bram_din(30),
      Q => meter_poi_ia(30),
      R => '0'
    );
\meter_poi_ia_reg[31]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_ia[31]_i_1_n_0\,
      D => bram_din(31),
      Q => meter_poi_ia(31),
      R => '0'
    );
\meter_poi_ia_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_ia[31]_i_1_n_0\,
      D => bram_din(3),
      Q => meter_poi_ia(3),
      R => '0'
    );
\meter_poi_ia_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_ia[31]_i_1_n_0\,
      D => bram_din(4),
      Q => meter_poi_ia(4),
      R => '0'
    );
\meter_poi_ia_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_ia[31]_i_1_n_0\,
      D => bram_din(5),
      Q => meter_poi_ia(5),
      R => '0'
    );
\meter_poi_ia_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_ia[31]_i_1_n_0\,
      D => bram_din(6),
      Q => meter_poi_ia(6),
      R => '0'
    );
\meter_poi_ia_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_ia[31]_i_1_n_0\,
      D => bram_din(7),
      Q => meter_poi_ia(7),
      R => '0'
    );
\meter_poi_ia_reg[8]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_ia[31]_i_1_n_0\,
      D => bram_din(8),
      Q => meter_poi_ia(8),
      R => '0'
    );
\meter_poi_ia_reg[9]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_ia[31]_i_1_n_0\,
      D => bram_din(9),
      Q => meter_poi_ia(9),
      R => '0'
    );
\meter_poi_ib[31]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00000008"
    )
        port map (
      I0 => arst_n,
      I1 => state_meter_r(3),
      I2 => state_meter_r(2),
      I3 => state_meter_r(0),
      I4 => state_meter_r(1),
      O => \meter_poi_ib[31]_i_1_n_0\
    );
\meter_poi_ib_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_ib[31]_i_1_n_0\,
      D => bram_din(0),
      Q => meter_poi_ib(0),
      R => '0'
    );
\meter_poi_ib_reg[10]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_ib[31]_i_1_n_0\,
      D => bram_din(10),
      Q => meter_poi_ib(10),
      R => '0'
    );
\meter_poi_ib_reg[11]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_ib[31]_i_1_n_0\,
      D => bram_din(11),
      Q => meter_poi_ib(11),
      R => '0'
    );
\meter_poi_ib_reg[12]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_ib[31]_i_1_n_0\,
      D => bram_din(12),
      Q => meter_poi_ib(12),
      R => '0'
    );
\meter_poi_ib_reg[13]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_ib[31]_i_1_n_0\,
      D => bram_din(13),
      Q => meter_poi_ib(13),
      R => '0'
    );
\meter_poi_ib_reg[14]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_ib[31]_i_1_n_0\,
      D => bram_din(14),
      Q => meter_poi_ib(14),
      R => '0'
    );
\meter_poi_ib_reg[15]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_ib[31]_i_1_n_0\,
      D => bram_din(15),
      Q => meter_poi_ib(15),
      R => '0'
    );
\meter_poi_ib_reg[16]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_ib[31]_i_1_n_0\,
      D => bram_din(16),
      Q => meter_poi_ib(16),
      R => '0'
    );
\meter_poi_ib_reg[17]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_ib[31]_i_1_n_0\,
      D => bram_din(17),
      Q => meter_poi_ib(17),
      R => '0'
    );
\meter_poi_ib_reg[18]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_ib[31]_i_1_n_0\,
      D => bram_din(18),
      Q => meter_poi_ib(18),
      R => '0'
    );
\meter_poi_ib_reg[19]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_ib[31]_i_1_n_0\,
      D => bram_din(19),
      Q => meter_poi_ib(19),
      R => '0'
    );
\meter_poi_ib_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_ib[31]_i_1_n_0\,
      D => bram_din(1),
      Q => meter_poi_ib(1),
      R => '0'
    );
\meter_poi_ib_reg[20]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_ib[31]_i_1_n_0\,
      D => bram_din(20),
      Q => meter_poi_ib(20),
      R => '0'
    );
\meter_poi_ib_reg[21]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_ib[31]_i_1_n_0\,
      D => bram_din(21),
      Q => meter_poi_ib(21),
      R => '0'
    );
\meter_poi_ib_reg[22]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_ib[31]_i_1_n_0\,
      D => bram_din(22),
      Q => meter_poi_ib(22),
      R => '0'
    );
\meter_poi_ib_reg[23]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_ib[31]_i_1_n_0\,
      D => bram_din(23),
      Q => meter_poi_ib(23),
      R => '0'
    );
\meter_poi_ib_reg[24]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_ib[31]_i_1_n_0\,
      D => bram_din(24),
      Q => meter_poi_ib(24),
      R => '0'
    );
\meter_poi_ib_reg[25]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_ib[31]_i_1_n_0\,
      D => bram_din(25),
      Q => meter_poi_ib(25),
      R => '0'
    );
\meter_poi_ib_reg[26]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_ib[31]_i_1_n_0\,
      D => bram_din(26),
      Q => meter_poi_ib(26),
      R => '0'
    );
\meter_poi_ib_reg[27]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_ib[31]_i_1_n_0\,
      D => bram_din(27),
      Q => meter_poi_ib(27),
      R => '0'
    );
\meter_poi_ib_reg[28]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_ib[31]_i_1_n_0\,
      D => bram_din(28),
      Q => meter_poi_ib(28),
      R => '0'
    );
\meter_poi_ib_reg[29]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_ib[31]_i_1_n_0\,
      D => bram_din(29),
      Q => meter_poi_ib(29),
      R => '0'
    );
\meter_poi_ib_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_ib[31]_i_1_n_0\,
      D => bram_din(2),
      Q => meter_poi_ib(2),
      R => '0'
    );
\meter_poi_ib_reg[30]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_ib[31]_i_1_n_0\,
      D => bram_din(30),
      Q => meter_poi_ib(30),
      R => '0'
    );
\meter_poi_ib_reg[31]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_ib[31]_i_1_n_0\,
      D => bram_din(31),
      Q => meter_poi_ib(31),
      R => '0'
    );
\meter_poi_ib_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_ib[31]_i_1_n_0\,
      D => bram_din(3),
      Q => meter_poi_ib(3),
      R => '0'
    );
\meter_poi_ib_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_ib[31]_i_1_n_0\,
      D => bram_din(4),
      Q => meter_poi_ib(4),
      R => '0'
    );
\meter_poi_ib_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_ib[31]_i_1_n_0\,
      D => bram_din(5),
      Q => meter_poi_ib(5),
      R => '0'
    );
\meter_poi_ib_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_ib[31]_i_1_n_0\,
      D => bram_din(6),
      Q => meter_poi_ib(6),
      R => '0'
    );
\meter_poi_ib_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_ib[31]_i_1_n_0\,
      D => bram_din(7),
      Q => meter_poi_ib(7),
      R => '0'
    );
\meter_poi_ib_reg[8]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_ib[31]_i_1_n_0\,
      D => bram_din(8),
      Q => meter_poi_ib(8),
      R => '0'
    );
\meter_poi_ib_reg[9]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_ib[31]_i_1_n_0\,
      D => bram_din(9),
      Q => meter_poi_ib(9),
      R => '0'
    );
\meter_poi_ic[31]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00080000"
    )
        port map (
      I0 => arst_n,
      I1 => state_meter_r(3),
      I2 => state_meter_r(2),
      I3 => state_meter_r(1),
      I4 => state_meter_r(0),
      O => \meter_poi_ic[31]_i_1_n_0\
    );
\meter_poi_ic_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_ic[31]_i_1_n_0\,
      D => bram_din(0),
      Q => meter_poi_ic(0),
      R => '0'
    );
\meter_poi_ic_reg[10]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_ic[31]_i_1_n_0\,
      D => bram_din(10),
      Q => meter_poi_ic(10),
      R => '0'
    );
\meter_poi_ic_reg[11]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_ic[31]_i_1_n_0\,
      D => bram_din(11),
      Q => meter_poi_ic(11),
      R => '0'
    );
\meter_poi_ic_reg[12]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_ic[31]_i_1_n_0\,
      D => bram_din(12),
      Q => meter_poi_ic(12),
      R => '0'
    );
\meter_poi_ic_reg[13]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_ic[31]_i_1_n_0\,
      D => bram_din(13),
      Q => meter_poi_ic(13),
      R => '0'
    );
\meter_poi_ic_reg[14]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_ic[31]_i_1_n_0\,
      D => bram_din(14),
      Q => meter_poi_ic(14),
      R => '0'
    );
\meter_poi_ic_reg[15]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_ic[31]_i_1_n_0\,
      D => bram_din(15),
      Q => meter_poi_ic(15),
      R => '0'
    );
\meter_poi_ic_reg[16]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_ic[31]_i_1_n_0\,
      D => bram_din(16),
      Q => meter_poi_ic(16),
      R => '0'
    );
\meter_poi_ic_reg[17]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_ic[31]_i_1_n_0\,
      D => bram_din(17),
      Q => meter_poi_ic(17),
      R => '0'
    );
\meter_poi_ic_reg[18]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_ic[31]_i_1_n_0\,
      D => bram_din(18),
      Q => meter_poi_ic(18),
      R => '0'
    );
\meter_poi_ic_reg[19]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_ic[31]_i_1_n_0\,
      D => bram_din(19),
      Q => meter_poi_ic(19),
      R => '0'
    );
\meter_poi_ic_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_ic[31]_i_1_n_0\,
      D => bram_din(1),
      Q => meter_poi_ic(1),
      R => '0'
    );
\meter_poi_ic_reg[20]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_ic[31]_i_1_n_0\,
      D => bram_din(20),
      Q => meter_poi_ic(20),
      R => '0'
    );
\meter_poi_ic_reg[21]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_ic[31]_i_1_n_0\,
      D => bram_din(21),
      Q => meter_poi_ic(21),
      R => '0'
    );
\meter_poi_ic_reg[22]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_ic[31]_i_1_n_0\,
      D => bram_din(22),
      Q => meter_poi_ic(22),
      R => '0'
    );
\meter_poi_ic_reg[23]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_ic[31]_i_1_n_0\,
      D => bram_din(23),
      Q => meter_poi_ic(23),
      R => '0'
    );
\meter_poi_ic_reg[24]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_ic[31]_i_1_n_0\,
      D => bram_din(24),
      Q => meter_poi_ic(24),
      R => '0'
    );
\meter_poi_ic_reg[25]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_ic[31]_i_1_n_0\,
      D => bram_din(25),
      Q => meter_poi_ic(25),
      R => '0'
    );
\meter_poi_ic_reg[26]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_ic[31]_i_1_n_0\,
      D => bram_din(26),
      Q => meter_poi_ic(26),
      R => '0'
    );
\meter_poi_ic_reg[27]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_ic[31]_i_1_n_0\,
      D => bram_din(27),
      Q => meter_poi_ic(27),
      R => '0'
    );
\meter_poi_ic_reg[28]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_ic[31]_i_1_n_0\,
      D => bram_din(28),
      Q => meter_poi_ic(28),
      R => '0'
    );
\meter_poi_ic_reg[29]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_ic[31]_i_1_n_0\,
      D => bram_din(29),
      Q => meter_poi_ic(29),
      R => '0'
    );
\meter_poi_ic_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_ic[31]_i_1_n_0\,
      D => bram_din(2),
      Q => meter_poi_ic(2),
      R => '0'
    );
\meter_poi_ic_reg[30]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_ic[31]_i_1_n_0\,
      D => bram_din(30),
      Q => meter_poi_ic(30),
      R => '0'
    );
\meter_poi_ic_reg[31]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_ic[31]_i_1_n_0\,
      D => bram_din(31),
      Q => meter_poi_ic(31),
      R => '0'
    );
\meter_poi_ic_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_ic[31]_i_1_n_0\,
      D => bram_din(3),
      Q => meter_poi_ic(3),
      R => '0'
    );
\meter_poi_ic_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_ic[31]_i_1_n_0\,
      D => bram_din(4),
      Q => meter_poi_ic(4),
      R => '0'
    );
\meter_poi_ic_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_ic[31]_i_1_n_0\,
      D => bram_din(5),
      Q => meter_poi_ic(5),
      R => '0'
    );
\meter_poi_ic_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_ic[31]_i_1_n_0\,
      D => bram_din(6),
      Q => meter_poi_ic(6),
      R => '0'
    );
\meter_poi_ic_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_ic[31]_i_1_n_0\,
      D => bram_din(7),
      Q => meter_poi_ic(7),
      R => '0'
    );
\meter_poi_ic_reg[8]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_ic[31]_i_1_n_0\,
      D => bram_din(8),
      Q => meter_poi_ic(8),
      R => '0'
    );
\meter_poi_ic_reg[9]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_ic[31]_i_1_n_0\,
      D => bram_din(9),
      Q => meter_poi_ic(9),
      R => '0'
    );
\meter_poi_in[31]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00004000"
    )
        port map (
      I0 => state_meter_r(0),
      I1 => state_meter_r(1),
      I2 => arst_n,
      I3 => state_meter_r(3),
      I4 => state_meter_r(2),
      O => \meter_poi_in[31]_i_1_n_0\
    );
\meter_poi_in_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_in[31]_i_1_n_0\,
      D => bram_din(0),
      Q => meter_poi_in(0),
      R => '0'
    );
\meter_poi_in_reg[10]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_in[31]_i_1_n_0\,
      D => bram_din(10),
      Q => meter_poi_in(10),
      R => '0'
    );
\meter_poi_in_reg[11]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_in[31]_i_1_n_0\,
      D => bram_din(11),
      Q => meter_poi_in(11),
      R => '0'
    );
\meter_poi_in_reg[12]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_in[31]_i_1_n_0\,
      D => bram_din(12),
      Q => meter_poi_in(12),
      R => '0'
    );
\meter_poi_in_reg[13]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_in[31]_i_1_n_0\,
      D => bram_din(13),
      Q => meter_poi_in(13),
      R => '0'
    );
\meter_poi_in_reg[14]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_in[31]_i_1_n_0\,
      D => bram_din(14),
      Q => meter_poi_in(14),
      R => '0'
    );
\meter_poi_in_reg[15]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_in[31]_i_1_n_0\,
      D => bram_din(15),
      Q => meter_poi_in(15),
      R => '0'
    );
\meter_poi_in_reg[16]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_in[31]_i_1_n_0\,
      D => bram_din(16),
      Q => meter_poi_in(16),
      R => '0'
    );
\meter_poi_in_reg[17]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_in[31]_i_1_n_0\,
      D => bram_din(17),
      Q => meter_poi_in(17),
      R => '0'
    );
\meter_poi_in_reg[18]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_in[31]_i_1_n_0\,
      D => bram_din(18),
      Q => meter_poi_in(18),
      R => '0'
    );
\meter_poi_in_reg[19]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_in[31]_i_1_n_0\,
      D => bram_din(19),
      Q => meter_poi_in(19),
      R => '0'
    );
\meter_poi_in_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_in[31]_i_1_n_0\,
      D => bram_din(1),
      Q => meter_poi_in(1),
      R => '0'
    );
\meter_poi_in_reg[20]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_in[31]_i_1_n_0\,
      D => bram_din(20),
      Q => meter_poi_in(20),
      R => '0'
    );
\meter_poi_in_reg[21]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_in[31]_i_1_n_0\,
      D => bram_din(21),
      Q => meter_poi_in(21),
      R => '0'
    );
\meter_poi_in_reg[22]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_in[31]_i_1_n_0\,
      D => bram_din(22),
      Q => meter_poi_in(22),
      R => '0'
    );
\meter_poi_in_reg[23]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_in[31]_i_1_n_0\,
      D => bram_din(23),
      Q => meter_poi_in(23),
      R => '0'
    );
\meter_poi_in_reg[24]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_in[31]_i_1_n_0\,
      D => bram_din(24),
      Q => meter_poi_in(24),
      R => '0'
    );
\meter_poi_in_reg[25]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_in[31]_i_1_n_0\,
      D => bram_din(25),
      Q => meter_poi_in(25),
      R => '0'
    );
\meter_poi_in_reg[26]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_in[31]_i_1_n_0\,
      D => bram_din(26),
      Q => meter_poi_in(26),
      R => '0'
    );
\meter_poi_in_reg[27]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_in[31]_i_1_n_0\,
      D => bram_din(27),
      Q => meter_poi_in(27),
      R => '0'
    );
\meter_poi_in_reg[28]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_in[31]_i_1_n_0\,
      D => bram_din(28),
      Q => meter_poi_in(28),
      R => '0'
    );
\meter_poi_in_reg[29]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_in[31]_i_1_n_0\,
      D => bram_din(29),
      Q => meter_poi_in(29),
      R => '0'
    );
\meter_poi_in_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_in[31]_i_1_n_0\,
      D => bram_din(2),
      Q => meter_poi_in(2),
      R => '0'
    );
\meter_poi_in_reg[30]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_in[31]_i_1_n_0\,
      D => bram_din(30),
      Q => meter_poi_in(30),
      R => '0'
    );
\meter_poi_in_reg[31]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_in[31]_i_1_n_0\,
      D => bram_din(31),
      Q => meter_poi_in(31),
      R => '0'
    );
\meter_poi_in_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_in[31]_i_1_n_0\,
      D => bram_din(3),
      Q => meter_poi_in(3),
      R => '0'
    );
\meter_poi_in_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_in[31]_i_1_n_0\,
      D => bram_din(4),
      Q => meter_poi_in(4),
      R => '0'
    );
\meter_poi_in_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_in[31]_i_1_n_0\,
      D => bram_din(5),
      Q => meter_poi_in(5),
      R => '0'
    );
\meter_poi_in_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_in[31]_i_1_n_0\,
      D => bram_din(6),
      Q => meter_poi_in(6),
      R => '0'
    );
\meter_poi_in_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_in[31]_i_1_n_0\,
      D => bram_din(7),
      Q => meter_poi_in(7),
      R => '0'
    );
\meter_poi_in_reg[8]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_in[31]_i_1_n_0\,
      D => bram_din(8),
      Q => meter_poi_in(8),
      R => '0'
    );
\meter_poi_in_reg[9]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_in[31]_i_1_n_0\,
      D => bram_din(9),
      Q => meter_poi_in(9),
      R => '0'
    );
\meter_poi_pf[31]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00400000"
    )
        port map (
      I0 => state_meter_r(0),
      I1 => state_meter_r(1),
      I2 => arst_n,
      I3 => state_meter_r(3),
      I4 => state_meter_r(2),
      O => \meter_poi_pf[31]_i_1_n_0\
    );
\meter_poi_pf_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_pf[31]_i_1_n_0\,
      D => bram_din(0),
      Q => meter_poi_pf(0),
      R => '0'
    );
\meter_poi_pf_reg[10]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_pf[31]_i_1_n_0\,
      D => bram_din(10),
      Q => meter_poi_pf(10),
      R => '0'
    );
\meter_poi_pf_reg[11]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_pf[31]_i_1_n_0\,
      D => bram_din(11),
      Q => meter_poi_pf(11),
      R => '0'
    );
\meter_poi_pf_reg[12]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_pf[31]_i_1_n_0\,
      D => bram_din(12),
      Q => meter_poi_pf(12),
      R => '0'
    );
\meter_poi_pf_reg[13]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_pf[31]_i_1_n_0\,
      D => bram_din(13),
      Q => meter_poi_pf(13),
      R => '0'
    );
\meter_poi_pf_reg[14]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_pf[31]_i_1_n_0\,
      D => bram_din(14),
      Q => meter_poi_pf(14),
      R => '0'
    );
\meter_poi_pf_reg[15]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_pf[31]_i_1_n_0\,
      D => bram_din(15),
      Q => meter_poi_pf(15),
      R => '0'
    );
\meter_poi_pf_reg[16]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_pf[31]_i_1_n_0\,
      D => bram_din(16),
      Q => meter_poi_pf(16),
      R => '0'
    );
\meter_poi_pf_reg[17]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_pf[31]_i_1_n_0\,
      D => bram_din(17),
      Q => meter_poi_pf(17),
      R => '0'
    );
\meter_poi_pf_reg[18]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_pf[31]_i_1_n_0\,
      D => bram_din(18),
      Q => meter_poi_pf(18),
      R => '0'
    );
\meter_poi_pf_reg[19]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_pf[31]_i_1_n_0\,
      D => bram_din(19),
      Q => meter_poi_pf(19),
      R => '0'
    );
\meter_poi_pf_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_pf[31]_i_1_n_0\,
      D => bram_din(1),
      Q => meter_poi_pf(1),
      R => '0'
    );
\meter_poi_pf_reg[20]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_pf[31]_i_1_n_0\,
      D => bram_din(20),
      Q => meter_poi_pf(20),
      R => '0'
    );
\meter_poi_pf_reg[21]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_pf[31]_i_1_n_0\,
      D => bram_din(21),
      Q => meter_poi_pf(21),
      R => '0'
    );
\meter_poi_pf_reg[22]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_pf[31]_i_1_n_0\,
      D => bram_din(22),
      Q => meter_poi_pf(22),
      R => '0'
    );
\meter_poi_pf_reg[23]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_pf[31]_i_1_n_0\,
      D => bram_din(23),
      Q => meter_poi_pf(23),
      R => '0'
    );
\meter_poi_pf_reg[24]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_pf[31]_i_1_n_0\,
      D => bram_din(24),
      Q => meter_poi_pf(24),
      R => '0'
    );
\meter_poi_pf_reg[25]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_pf[31]_i_1_n_0\,
      D => bram_din(25),
      Q => meter_poi_pf(25),
      R => '0'
    );
\meter_poi_pf_reg[26]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_pf[31]_i_1_n_0\,
      D => bram_din(26),
      Q => meter_poi_pf(26),
      R => '0'
    );
\meter_poi_pf_reg[27]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_pf[31]_i_1_n_0\,
      D => bram_din(27),
      Q => meter_poi_pf(27),
      R => '0'
    );
\meter_poi_pf_reg[28]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_pf[31]_i_1_n_0\,
      D => bram_din(28),
      Q => meter_poi_pf(28),
      R => '0'
    );
\meter_poi_pf_reg[29]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_pf[31]_i_1_n_0\,
      D => bram_din(29),
      Q => meter_poi_pf(29),
      R => '0'
    );
\meter_poi_pf_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_pf[31]_i_1_n_0\,
      D => bram_din(2),
      Q => meter_poi_pf(2),
      R => '0'
    );
\meter_poi_pf_reg[30]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_pf[31]_i_1_n_0\,
      D => bram_din(30),
      Q => meter_poi_pf(30),
      R => '0'
    );
\meter_poi_pf_reg[31]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_pf[31]_i_1_n_0\,
      D => bram_din(31),
      Q => meter_poi_pf(31),
      R => '0'
    );
\meter_poi_pf_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_pf[31]_i_1_n_0\,
      D => bram_din(3),
      Q => meter_poi_pf(3),
      R => '0'
    );
\meter_poi_pf_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_pf[31]_i_1_n_0\,
      D => bram_din(4),
      Q => meter_poi_pf(4),
      R => '0'
    );
\meter_poi_pf_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_pf[31]_i_1_n_0\,
      D => bram_din(5),
      Q => meter_poi_pf(5),
      R => '0'
    );
\meter_poi_pf_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_pf[31]_i_1_n_0\,
      D => bram_din(6),
      Q => meter_poi_pf(6),
      R => '0'
    );
\meter_poi_pf_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_pf[31]_i_1_n_0\,
      D => bram_din(7),
      Q => meter_poi_pf(7),
      R => '0'
    );
\meter_poi_pf_reg[8]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_pf[31]_i_1_n_0\,
      D => bram_din(8),
      Q => meter_poi_pf(8),
      R => '0'
    );
\meter_poi_pf_reg[9]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_pf[31]_i_1_n_0\,
      D => bram_din(9),
      Q => meter_poi_pf(9),
      R => '0'
    );
\meter_poi_vab[31]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"08000000"
    )
        port map (
      I0 => arst_n,
      I1 => state_meter_r(3),
      I2 => state_meter_r(2),
      I3 => state_meter_r(0),
      I4 => state_meter_r(1),
      O => \meter_poi_vab[31]_i_1_n_0\
    );
\meter_poi_vab_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_vab[31]_i_1_n_0\,
      D => bram_din(0),
      Q => meter_poi_vab(0),
      R => '0'
    );
\meter_poi_vab_reg[10]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_vab[31]_i_1_n_0\,
      D => bram_din(10),
      Q => meter_poi_vab(10),
      R => '0'
    );
\meter_poi_vab_reg[11]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_vab[31]_i_1_n_0\,
      D => bram_din(11),
      Q => meter_poi_vab(11),
      R => '0'
    );
\meter_poi_vab_reg[12]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_vab[31]_i_1_n_0\,
      D => bram_din(12),
      Q => meter_poi_vab(12),
      R => '0'
    );
\meter_poi_vab_reg[13]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_vab[31]_i_1_n_0\,
      D => bram_din(13),
      Q => meter_poi_vab(13),
      R => '0'
    );
\meter_poi_vab_reg[14]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_vab[31]_i_1_n_0\,
      D => bram_din(14),
      Q => meter_poi_vab(14),
      R => '0'
    );
\meter_poi_vab_reg[15]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_vab[31]_i_1_n_0\,
      D => bram_din(15),
      Q => meter_poi_vab(15),
      R => '0'
    );
\meter_poi_vab_reg[16]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_vab[31]_i_1_n_0\,
      D => bram_din(16),
      Q => meter_poi_vab(16),
      R => '0'
    );
\meter_poi_vab_reg[17]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_vab[31]_i_1_n_0\,
      D => bram_din(17),
      Q => meter_poi_vab(17),
      R => '0'
    );
\meter_poi_vab_reg[18]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_vab[31]_i_1_n_0\,
      D => bram_din(18),
      Q => meter_poi_vab(18),
      R => '0'
    );
\meter_poi_vab_reg[19]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_vab[31]_i_1_n_0\,
      D => bram_din(19),
      Q => meter_poi_vab(19),
      R => '0'
    );
\meter_poi_vab_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_vab[31]_i_1_n_0\,
      D => bram_din(1),
      Q => meter_poi_vab(1),
      R => '0'
    );
\meter_poi_vab_reg[20]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_vab[31]_i_1_n_0\,
      D => bram_din(20),
      Q => meter_poi_vab(20),
      R => '0'
    );
\meter_poi_vab_reg[21]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_vab[31]_i_1_n_0\,
      D => bram_din(21),
      Q => meter_poi_vab(21),
      R => '0'
    );
\meter_poi_vab_reg[22]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_vab[31]_i_1_n_0\,
      D => bram_din(22),
      Q => meter_poi_vab(22),
      R => '0'
    );
\meter_poi_vab_reg[23]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_vab[31]_i_1_n_0\,
      D => bram_din(23),
      Q => meter_poi_vab(23),
      R => '0'
    );
\meter_poi_vab_reg[24]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_vab[31]_i_1_n_0\,
      D => bram_din(24),
      Q => meter_poi_vab(24),
      R => '0'
    );
\meter_poi_vab_reg[25]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_vab[31]_i_1_n_0\,
      D => bram_din(25),
      Q => meter_poi_vab(25),
      R => '0'
    );
\meter_poi_vab_reg[26]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_vab[31]_i_1_n_0\,
      D => bram_din(26),
      Q => meter_poi_vab(26),
      R => '0'
    );
\meter_poi_vab_reg[27]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_vab[31]_i_1_n_0\,
      D => bram_din(27),
      Q => meter_poi_vab(27),
      R => '0'
    );
\meter_poi_vab_reg[28]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_vab[31]_i_1_n_0\,
      D => bram_din(28),
      Q => meter_poi_vab(28),
      R => '0'
    );
\meter_poi_vab_reg[29]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_vab[31]_i_1_n_0\,
      D => bram_din(29),
      Q => meter_poi_vab(29),
      R => '0'
    );
\meter_poi_vab_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_vab[31]_i_1_n_0\,
      D => bram_din(2),
      Q => meter_poi_vab(2),
      R => '0'
    );
\meter_poi_vab_reg[30]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_vab[31]_i_1_n_0\,
      D => bram_din(30),
      Q => meter_poi_vab(30),
      R => '0'
    );
\meter_poi_vab_reg[31]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_vab[31]_i_1_n_0\,
      D => bram_din(31),
      Q => meter_poi_vab(31),
      R => '0'
    );
\meter_poi_vab_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_vab[31]_i_1_n_0\,
      D => bram_din(3),
      Q => meter_poi_vab(3),
      R => '0'
    );
\meter_poi_vab_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_vab[31]_i_1_n_0\,
      D => bram_din(4),
      Q => meter_poi_vab(4),
      R => '0'
    );
\meter_poi_vab_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_vab[31]_i_1_n_0\,
      D => bram_din(5),
      Q => meter_poi_vab(5),
      R => '0'
    );
\meter_poi_vab_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_vab[31]_i_1_n_0\,
      D => bram_din(6),
      Q => meter_poi_vab(6),
      R => '0'
    );
\meter_poi_vab_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_vab[31]_i_1_n_0\,
      D => bram_din(7),
      Q => meter_poi_vab(7),
      R => '0'
    );
\meter_poi_vab_reg[8]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_vab[31]_i_1_n_0\,
      D => bram_din(8),
      Q => meter_poi_vab(8),
      R => '0'
    );
\meter_poi_vab_reg[9]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_vab[31]_i_1_n_0\,
      D => bram_din(9),
      Q => meter_poi_vab(9),
      R => '0'
    );
\meter_poi_vbc[31]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"10000000"
    )
        port map (
      I0 => state_meter_r(1),
      I1 => state_meter_r(0),
      I2 => arst_n,
      I3 => state_meter_r(2),
      I4 => state_meter_r(3),
      O => \meter_poi_vbc[31]_i_1_n_0\
    );
\meter_poi_vbc_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_vbc[31]_i_1_n_0\,
      D => bram_din(0),
      Q => meter_poi_vbc(0),
      R => '0'
    );
\meter_poi_vbc_reg[10]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_vbc[31]_i_1_n_0\,
      D => bram_din(10),
      Q => meter_poi_vbc(10),
      R => '0'
    );
\meter_poi_vbc_reg[11]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_vbc[31]_i_1_n_0\,
      D => bram_din(11),
      Q => meter_poi_vbc(11),
      R => '0'
    );
\meter_poi_vbc_reg[12]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_vbc[31]_i_1_n_0\,
      D => bram_din(12),
      Q => meter_poi_vbc(12),
      R => '0'
    );
\meter_poi_vbc_reg[13]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_vbc[31]_i_1_n_0\,
      D => bram_din(13),
      Q => meter_poi_vbc(13),
      R => '0'
    );
\meter_poi_vbc_reg[14]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_vbc[31]_i_1_n_0\,
      D => bram_din(14),
      Q => meter_poi_vbc(14),
      R => '0'
    );
\meter_poi_vbc_reg[15]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_vbc[31]_i_1_n_0\,
      D => bram_din(15),
      Q => meter_poi_vbc(15),
      R => '0'
    );
\meter_poi_vbc_reg[16]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_vbc[31]_i_1_n_0\,
      D => bram_din(16),
      Q => meter_poi_vbc(16),
      R => '0'
    );
\meter_poi_vbc_reg[17]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_vbc[31]_i_1_n_0\,
      D => bram_din(17),
      Q => meter_poi_vbc(17),
      R => '0'
    );
\meter_poi_vbc_reg[18]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_vbc[31]_i_1_n_0\,
      D => bram_din(18),
      Q => meter_poi_vbc(18),
      R => '0'
    );
\meter_poi_vbc_reg[19]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_vbc[31]_i_1_n_0\,
      D => bram_din(19),
      Q => meter_poi_vbc(19),
      R => '0'
    );
\meter_poi_vbc_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_vbc[31]_i_1_n_0\,
      D => bram_din(1),
      Q => meter_poi_vbc(1),
      R => '0'
    );
\meter_poi_vbc_reg[20]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_vbc[31]_i_1_n_0\,
      D => bram_din(20),
      Q => meter_poi_vbc(20),
      R => '0'
    );
\meter_poi_vbc_reg[21]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_vbc[31]_i_1_n_0\,
      D => bram_din(21),
      Q => meter_poi_vbc(21),
      R => '0'
    );
\meter_poi_vbc_reg[22]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_vbc[31]_i_1_n_0\,
      D => bram_din(22),
      Q => meter_poi_vbc(22),
      R => '0'
    );
\meter_poi_vbc_reg[23]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_vbc[31]_i_1_n_0\,
      D => bram_din(23),
      Q => meter_poi_vbc(23),
      R => '0'
    );
\meter_poi_vbc_reg[24]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_vbc[31]_i_1_n_0\,
      D => bram_din(24),
      Q => meter_poi_vbc(24),
      R => '0'
    );
\meter_poi_vbc_reg[25]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_vbc[31]_i_1_n_0\,
      D => bram_din(25),
      Q => meter_poi_vbc(25),
      R => '0'
    );
\meter_poi_vbc_reg[26]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_vbc[31]_i_1_n_0\,
      D => bram_din(26),
      Q => meter_poi_vbc(26),
      R => '0'
    );
\meter_poi_vbc_reg[27]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_vbc[31]_i_1_n_0\,
      D => bram_din(27),
      Q => meter_poi_vbc(27),
      R => '0'
    );
\meter_poi_vbc_reg[28]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_vbc[31]_i_1_n_0\,
      D => bram_din(28),
      Q => meter_poi_vbc(28),
      R => '0'
    );
\meter_poi_vbc_reg[29]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_vbc[31]_i_1_n_0\,
      D => bram_din(29),
      Q => meter_poi_vbc(29),
      R => '0'
    );
\meter_poi_vbc_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_vbc[31]_i_1_n_0\,
      D => bram_din(2),
      Q => meter_poi_vbc(2),
      R => '0'
    );
\meter_poi_vbc_reg[30]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_vbc[31]_i_1_n_0\,
      D => bram_din(30),
      Q => meter_poi_vbc(30),
      R => '0'
    );
\meter_poi_vbc_reg[31]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_vbc[31]_i_1_n_0\,
      D => bram_din(31),
      Q => meter_poi_vbc(31),
      R => '0'
    );
\meter_poi_vbc_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_vbc[31]_i_1_n_0\,
      D => bram_din(3),
      Q => meter_poi_vbc(3),
      R => '0'
    );
\meter_poi_vbc_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_vbc[31]_i_1_n_0\,
      D => bram_din(4),
      Q => meter_poi_vbc(4),
      R => '0'
    );
\meter_poi_vbc_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_vbc[31]_i_1_n_0\,
      D => bram_din(5),
      Q => meter_poi_vbc(5),
      R => '0'
    );
\meter_poi_vbc_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_vbc[31]_i_1_n_0\,
      D => bram_din(6),
      Q => meter_poi_vbc(6),
      R => '0'
    );
\meter_poi_vbc_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_vbc[31]_i_1_n_0\,
      D => bram_din(7),
      Q => meter_poi_vbc(7),
      R => '0'
    );
\meter_poi_vbc_reg[8]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_vbc[31]_i_1_n_0\,
      D => bram_din(8),
      Q => meter_poi_vbc(8),
      R => '0'
    );
\meter_poi_vbc_reg[9]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_vbc[31]_i_1_n_0\,
      D => bram_din(9),
      Q => meter_poi_vbc(9),
      R => '0'
    );
\meter_poi_vca[31]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"08000000"
    )
        port map (
      I0 => arst_n,
      I1 => state_meter_r(0),
      I2 => state_meter_r(1),
      I3 => state_meter_r(2),
      I4 => state_meter_r(3),
      O => \meter_poi_vca[31]_i_1_n_0\
    );
\meter_poi_vca_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_vca[31]_i_1_n_0\,
      D => bram_din(0),
      Q => meter_poi_vca(0),
      R => '0'
    );
\meter_poi_vca_reg[10]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_vca[31]_i_1_n_0\,
      D => bram_din(10),
      Q => meter_poi_vca(10),
      R => '0'
    );
\meter_poi_vca_reg[11]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_vca[31]_i_1_n_0\,
      D => bram_din(11),
      Q => meter_poi_vca(11),
      R => '0'
    );
\meter_poi_vca_reg[12]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_vca[31]_i_1_n_0\,
      D => bram_din(12),
      Q => meter_poi_vca(12),
      R => '0'
    );
\meter_poi_vca_reg[13]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_vca[31]_i_1_n_0\,
      D => bram_din(13),
      Q => meter_poi_vca(13),
      R => '0'
    );
\meter_poi_vca_reg[14]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_vca[31]_i_1_n_0\,
      D => bram_din(14),
      Q => meter_poi_vca(14),
      R => '0'
    );
\meter_poi_vca_reg[15]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_vca[31]_i_1_n_0\,
      D => bram_din(15),
      Q => meter_poi_vca(15),
      R => '0'
    );
\meter_poi_vca_reg[16]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_vca[31]_i_1_n_0\,
      D => bram_din(16),
      Q => meter_poi_vca(16),
      R => '0'
    );
\meter_poi_vca_reg[17]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_vca[31]_i_1_n_0\,
      D => bram_din(17),
      Q => meter_poi_vca(17),
      R => '0'
    );
\meter_poi_vca_reg[18]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_vca[31]_i_1_n_0\,
      D => bram_din(18),
      Q => meter_poi_vca(18),
      R => '0'
    );
\meter_poi_vca_reg[19]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_vca[31]_i_1_n_0\,
      D => bram_din(19),
      Q => meter_poi_vca(19),
      R => '0'
    );
\meter_poi_vca_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_vca[31]_i_1_n_0\,
      D => bram_din(1),
      Q => meter_poi_vca(1),
      R => '0'
    );
\meter_poi_vca_reg[20]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_vca[31]_i_1_n_0\,
      D => bram_din(20),
      Q => meter_poi_vca(20),
      R => '0'
    );
\meter_poi_vca_reg[21]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_vca[31]_i_1_n_0\,
      D => bram_din(21),
      Q => meter_poi_vca(21),
      R => '0'
    );
\meter_poi_vca_reg[22]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_vca[31]_i_1_n_0\,
      D => bram_din(22),
      Q => meter_poi_vca(22),
      R => '0'
    );
\meter_poi_vca_reg[23]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_vca[31]_i_1_n_0\,
      D => bram_din(23),
      Q => meter_poi_vca(23),
      R => '0'
    );
\meter_poi_vca_reg[24]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_vca[31]_i_1_n_0\,
      D => bram_din(24),
      Q => meter_poi_vca(24),
      R => '0'
    );
\meter_poi_vca_reg[25]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_vca[31]_i_1_n_0\,
      D => bram_din(25),
      Q => meter_poi_vca(25),
      R => '0'
    );
\meter_poi_vca_reg[26]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_vca[31]_i_1_n_0\,
      D => bram_din(26),
      Q => meter_poi_vca(26),
      R => '0'
    );
\meter_poi_vca_reg[27]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_vca[31]_i_1_n_0\,
      D => bram_din(27),
      Q => meter_poi_vca(27),
      R => '0'
    );
\meter_poi_vca_reg[28]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_vca[31]_i_1_n_0\,
      D => bram_din(28),
      Q => meter_poi_vca(28),
      R => '0'
    );
\meter_poi_vca_reg[29]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_vca[31]_i_1_n_0\,
      D => bram_din(29),
      Q => meter_poi_vca(29),
      R => '0'
    );
\meter_poi_vca_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_vca[31]_i_1_n_0\,
      D => bram_din(2),
      Q => meter_poi_vca(2),
      R => '0'
    );
\meter_poi_vca_reg[30]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_vca[31]_i_1_n_0\,
      D => bram_din(30),
      Q => meter_poi_vca(30),
      R => '0'
    );
\meter_poi_vca_reg[31]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_vca[31]_i_1_n_0\,
      D => bram_din(31),
      Q => meter_poi_vca(31),
      R => '0'
    );
\meter_poi_vca_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_vca[31]_i_1_n_0\,
      D => bram_din(3),
      Q => meter_poi_vca(3),
      R => '0'
    );
\meter_poi_vca_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_vca[31]_i_1_n_0\,
      D => bram_din(4),
      Q => meter_poi_vca(4),
      R => '0'
    );
\meter_poi_vca_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_vca[31]_i_1_n_0\,
      D => bram_din(5),
      Q => meter_poi_vca(5),
      R => '0'
    );
\meter_poi_vca_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_vca[31]_i_1_n_0\,
      D => bram_din(6),
      Q => meter_poi_vca(6),
      R => '0'
    );
\meter_poi_vca_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_vca[31]_i_1_n_0\,
      D => bram_din(7),
      Q => meter_poi_vca(7),
      R => '0'
    );
\meter_poi_vca_reg[8]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_vca[31]_i_1_n_0\,
      D => bram_din(8),
      Q => meter_poi_vca(8),
      R => '0'
    );
\meter_poi_vca_reg[9]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \meter_poi_vca[31]_i_1_n_0\,
      D => bram_din(9),
      Q => meter_poi_vca(9),
      R => '0'
    );
meter_rdata_sig_i_1: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00000004"
    )
        port map (
      I0 => pv_bram_rdataflg,
      I1 => meter_bram_rdataflg,
      I2 => bess_bram_rdataflg,
      I3 => usrparam_bram_rdataflg,
      I4 => state,
      O => meter_rdata_sig_i_1_n_0
    );
meter_rdata_sig_reg: unisim.vcomponents.FDCE
     port map (
      C => clkin,
      CE => '1',
      CLR => \bram_addr_10bit[9]_i_2_n_0\,
      D => meter_rdata_sig_i_1_n_0,
      Q => meter_rdata_sig_reg_n_0
    );
meter_rdata_vld_i_1: unisim.vcomponents.LUT5
    generic map(
      INIT => X"7FFF4000"
    )
        port map (
      I0 => state_meter_r(0),
      I1 => state_meter_r(1),
      I2 => state_meter_r(2),
      I3 => state_meter_r(3),
      I4 => \^meter_rdata_vld\,
      O => meter_rdata_vld_i_1_n_0
    );
meter_rdata_vld_reg: unisim.vcomponents.FDCE
     port map (
      C => clkin,
      CE => '1',
      CLR => \bram_addr_10bit[9]_i_2_n_0\,
      D => meter_rdata_vld_i_1_n_0,
      Q => \^meter_rdata_vld\
    );
pspl_wcmd_bsyreg_reg: unisim.vcomponents.FDCE
     port map (
      C => clkin,
      CE => '1',
      CLR => \bram_addr_10bit[9]_i_2_n_0\,
      D => pspl_wcmd_bsy,
      Q => pspl_wcmd_bsyreg
    );
\pv_bram_addr[0]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"00F6"
    )
        port map (
      I0 => state_pv_r(2),
      I1 => state_pv_r(0),
      I2 => state_pv_r(1),
      I3 => \pv_bram_addr_reg_n_0_[0]\,
      O => pv_bram_addr(0)
    );
\pv_bram_addr[1]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00BEBE00"
    )
        port map (
      I0 => state_pv_r(1),
      I1 => state_pv_r(0),
      I2 => state_pv_r(2),
      I3 => \pv_bram_addr_reg_n_0_[0]\,
      I4 => \pv_bram_addr_reg_n_0_[1]\,
      O => pv_bram_addr(1)
    );
\pv_bram_addr[2]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"2A80"
    )
        port map (
      I0 => \pv_bram_addr[9]_i_4_n_0\,
      I1 => \pv_bram_addr_reg_n_0_[1]\,
      I2 => \pv_bram_addr_reg_n_0_[0]\,
      I3 => \pv_bram_addr_reg_n_0_[2]\,
      O => pv_bram_addr(2)
    );
\pv_bram_addr[3]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"1001F11F1001E00E"
    )
        port map (
      I0 => state_pv_r(1),
      I1 => state_pv_r(0),
      I2 => \pv_bram_addr[3]_i_2_n_0\,
      I3 => \pv_bram_addr_reg_n_0_[3]\,
      I4 => state_pv_r(2),
      I5 => pv_rdata_sig_reg_n_0,
      O => pv_bram_addr(3)
    );
\pv_bram_addr[3]_i_2\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"7F"
    )
        port map (
      I0 => \pv_bram_addr_reg_n_0_[1]\,
      I1 => \pv_bram_addr_reg_n_0_[0]\,
      I2 => \pv_bram_addr_reg_n_0_[2]\,
      O => \pv_bram_addr[3]_i_2_n_0\
    );
\pv_bram_addr[4]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"7FFF000080000000"
    )
        port map (
      I0 => \pv_bram_addr_reg_n_0_[2]\,
      I1 => \pv_bram_addr_reg_n_0_[0]\,
      I2 => \pv_bram_addr_reg_n_0_[1]\,
      I3 => \pv_bram_addr_reg_n_0_[3]\,
      I4 => \pv_bram_addr[9]_i_4_n_0\,
      I5 => \pv_bram_addr_reg_n_0_[4]\,
      O => pv_bram_addr(4)
    );
\pv_bram_addr[5]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"1001F11F1001E00E"
    )
        port map (
      I0 => state_pv_r(1),
      I1 => state_pv_r(0),
      I2 => \pv_bram_addr[5]_i_2_n_0\,
      I3 => \pv_bram_addr_reg_n_0_[5]\,
      I4 => state_pv_r(2),
      I5 => pv_rdata_sig_reg_n_0,
      O => pv_bram_addr(5)
    );
\pv_bram_addr[5]_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"7FFFFFFF"
    )
        port map (
      I0 => \pv_bram_addr_reg_n_0_[3]\,
      I1 => \pv_bram_addr_reg_n_0_[1]\,
      I2 => \pv_bram_addr_reg_n_0_[0]\,
      I3 => \pv_bram_addr_reg_n_0_[2]\,
      I4 => \pv_bram_addr_reg_n_0_[4]\,
      O => \pv_bram_addr[5]_i_2_n_0\
    );
\pv_bram_addr[6]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"5514AA28"
    )
        port map (
      I0 => \pv_bram_addr[9]_i_3_n_0\,
      I1 => state_pv_r(2),
      I2 => state_pv_r(0),
      I3 => state_pv_r(1),
      I4 => \pv_bram_addr_reg_n_0_[6]\,
      O => pv_bram_addr(6)
    );
\pv_bram_addr[7]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"7080"
    )
        port map (
      I0 => \pv_bram_addr[9]_i_3_n_0\,
      I1 => \pv_bram_addr_reg_n_0_[6]\,
      I2 => \pv_bram_addr[9]_i_4_n_0\,
      I3 => \pv_bram_addr_reg_n_0_[7]\,
      O => pv_bram_addr(7)
    );
\pv_bram_addr[8]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"7F008000"
    )
        port map (
      I0 => \pv_bram_addr_reg_n_0_[6]\,
      I1 => \pv_bram_addr[9]_i_3_n_0\,
      I2 => \pv_bram_addr_reg_n_0_[7]\,
      I3 => \pv_bram_addr[9]_i_4_n_0\,
      I4 => \pv_bram_addr_reg_n_0_[8]\,
      O => pv_bram_addr(8)
    );
\pv_bram_addr[9]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"07"
    )
        port map (
      I0 => state_pv_r(1),
      I1 => state_pv_r(2),
      I2 => state_pv_r(3),
      O => \pv_bram_addr[9]_i_1_n_0\
    );
\pv_bram_addr[9]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"7FFF000080000000"
    )
        port map (
      I0 => \pv_bram_addr_reg_n_0_[7]\,
      I1 => \pv_bram_addr[9]_i_3_n_0\,
      I2 => \pv_bram_addr_reg_n_0_[6]\,
      I3 => \pv_bram_addr_reg_n_0_[8]\,
      I4 => \pv_bram_addr[9]_i_4_n_0\,
      I5 => \pv_bram_addr_reg_n_0_[9]\,
      O => pv_bram_addr(9)
    );
\pv_bram_addr[9]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"8000000000000000"
    )
        port map (
      I0 => \pv_bram_addr_reg_n_0_[5]\,
      I1 => \pv_bram_addr_reg_n_0_[4]\,
      I2 => \pv_bram_addr_reg_n_0_[2]\,
      I3 => \pv_bram_addr_reg_n_0_[0]\,
      I4 => \pv_bram_addr_reg_n_0_[1]\,
      I5 => \pv_bram_addr_reg_n_0_[3]\,
      O => \pv_bram_addr[9]_i_3_n_0\
    );
\pv_bram_addr[9]_i_4\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"00BE"
    )
        port map (
      I0 => state_pv_r(1),
      I1 => state_pv_r(0),
      I2 => state_pv_r(2),
      I3 => state_pv_r(3),
      O => \pv_bram_addr[9]_i_4_n_0\
    );
\pv_bram_addr_reg[0]\: unisim.vcomponents.FDCE
     port map (
      C => clkin,
      CE => \pv_bram_addr[9]_i_1_n_0\,
      CLR => \bram_addr_10bit[9]_i_2_n_0\,
      D => pv_bram_addr(0),
      Q => \pv_bram_addr_reg_n_0_[0]\
    );
\pv_bram_addr_reg[1]\: unisim.vcomponents.FDCE
     port map (
      C => clkin,
      CE => \pv_bram_addr[9]_i_1_n_0\,
      CLR => \bram_addr_10bit[9]_i_2_n_0\,
      D => pv_bram_addr(1),
      Q => \pv_bram_addr_reg_n_0_[1]\
    );
\pv_bram_addr_reg[2]\: unisim.vcomponents.FDCE
     port map (
      C => clkin,
      CE => \pv_bram_addr[9]_i_1_n_0\,
      CLR => \bram_addr_10bit[9]_i_2_n_0\,
      D => pv_bram_addr(2),
      Q => \pv_bram_addr_reg_n_0_[2]\
    );
\pv_bram_addr_reg[3]\: unisim.vcomponents.FDCE
     port map (
      C => clkin,
      CE => \pv_bram_addr[9]_i_1_n_0\,
      CLR => \bram_addr_10bit[9]_i_2_n_0\,
      D => pv_bram_addr(3),
      Q => \pv_bram_addr_reg_n_0_[3]\
    );
\pv_bram_addr_reg[4]\: unisim.vcomponents.FDCE
     port map (
      C => clkin,
      CE => \pv_bram_addr[9]_i_1_n_0\,
      CLR => \bram_addr_10bit[9]_i_2_n_0\,
      D => pv_bram_addr(4),
      Q => \pv_bram_addr_reg_n_0_[4]\
    );
\pv_bram_addr_reg[5]\: unisim.vcomponents.FDCE
     port map (
      C => clkin,
      CE => \pv_bram_addr[9]_i_1_n_0\,
      CLR => \bram_addr_10bit[9]_i_2_n_0\,
      D => pv_bram_addr(5),
      Q => \pv_bram_addr_reg_n_0_[5]\
    );
\pv_bram_addr_reg[6]\: unisim.vcomponents.FDCE
     port map (
      C => clkin,
      CE => \pv_bram_addr[9]_i_1_n_0\,
      CLR => \bram_addr_10bit[9]_i_2_n_0\,
      D => pv_bram_addr(6),
      Q => \pv_bram_addr_reg_n_0_[6]\
    );
\pv_bram_addr_reg[7]\: unisim.vcomponents.FDCE
     port map (
      C => clkin,
      CE => \pv_bram_addr[9]_i_1_n_0\,
      CLR => \bram_addr_10bit[9]_i_2_n_0\,
      D => pv_bram_addr(7),
      Q => \pv_bram_addr_reg_n_0_[7]\
    );
\pv_bram_addr_reg[8]\: unisim.vcomponents.FDCE
     port map (
      C => clkin,
      CE => \pv_bram_addr[9]_i_1_n_0\,
      CLR => \bram_addr_10bit[9]_i_2_n_0\,
      D => pv_bram_addr(8),
      Q => \pv_bram_addr_reg_n_0_[8]\
    );
\pv_bram_addr_reg[9]\: unisim.vcomponents.FDCE
     port map (
      C => clkin,
      CE => \pv_bram_addr[9]_i_1_n_0\,
      CLR => \bram_addr_10bit[9]_i_2_n_0\,
      D => pv_bram_addr(9),
      Q => \pv_bram_addr_reg_n_0_[9]\
    );
pv_bram_enb_i_1: unisim.vcomponents.LUT4
    generic map(
      INIT => X"BFBE"
    )
        port map (
      I0 => state_pv_r(1),
      I1 => state_pv_r(2),
      I2 => state_pv_r(0),
      I3 => pv_rdata_sig_reg_n_0,
      O => pv_bram_enb
    );
pv_bram_enb_reg: unisim.vcomponents.FDCE
     port map (
      C => clkin,
      CE => \pv_bram_addr[9]_i_1_n_0\,
      CLR => \bram_addr_10bit[9]_i_2_n_0\,
      D => pv_bram_enb,
      Q => pv_bram_enb_reg_n_0
    );
\pv_fault_r_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \pv_status_r[7]_i_1_n_0\,
      D => bram_din(8),
      Q => pv_fault_r(0),
      R => '0'
    );
\pv_fault_r_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \pv_status_r[7]_i_1_n_0\,
      D => bram_din(9),
      Q => pv_fault_r(1),
      R => '0'
    );
\pv_fault_r_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \pv_status_r[7]_i_1_n_0\,
      D => bram_din(10),
      Q => pv_fault_r(2),
      R => '0'
    );
\pv_fault_r_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \pv_status_r[7]_i_1_n_0\,
      D => bram_din(11),
      Q => pv_fault_r(3),
      R => '0'
    );
\pv_fault_r_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \pv_status_r[7]_i_1_n_0\,
      D => bram_din(12),
      Q => pv_fault_r(4),
      R => '0'
    );
\pv_fault_r_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \pv_status_r[7]_i_1_n_0\,
      D => bram_din(13),
      Q => pv_fault_r(5),
      R => '0'
    );
\pv_fault_r_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \pv_status_r[7]_i_1_n_0\,
      D => bram_din(14),
      Q => pv_fault_r(6),
      R => '0'
    );
\pv_fault_r_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \pv_status_r[7]_i_1_n_0\,
      D => bram_din(15),
      Q => pv_fault_r(7),
      R => '0'
    );
\pv_p_w_ltch_reg[0]\: unisim.vcomponents.FDCE
     port map (
      C => clkin,
      CE => pv_pvld_w,
      CLR => \bram_addr_10bit[9]_i_2_n_0\,
      D => pv_p_w(0),
      Q => pv_p_w_ltch(0)
    );
\pv_p_w_ltch_reg[10]\: unisim.vcomponents.FDCE
     port map (
      C => clkin,
      CE => pv_pvld_w,
      CLR => \bram_addr_10bit[9]_i_2_n_0\,
      D => pv_p_w(10),
      Q => pv_p_w_ltch(10)
    );
\pv_p_w_ltch_reg[11]\: unisim.vcomponents.FDCE
     port map (
      C => clkin,
      CE => pv_pvld_w,
      CLR => \bram_addr_10bit[9]_i_2_n_0\,
      D => pv_p_w(11),
      Q => pv_p_w_ltch(11)
    );
\pv_p_w_ltch_reg[12]\: unisim.vcomponents.FDCE
     port map (
      C => clkin,
      CE => pv_pvld_w,
      CLR => \bram_addr_10bit[9]_i_2_n_0\,
      D => pv_p_w(12),
      Q => pv_p_w_ltch(12)
    );
\pv_p_w_ltch_reg[13]\: unisim.vcomponents.FDCE
     port map (
      C => clkin,
      CE => pv_pvld_w,
      CLR => \bram_addr_10bit[9]_i_2_n_0\,
      D => pv_p_w(13),
      Q => pv_p_w_ltch(13)
    );
\pv_p_w_ltch_reg[14]\: unisim.vcomponents.FDCE
     port map (
      C => clkin,
      CE => pv_pvld_w,
      CLR => \bram_addr_10bit[9]_i_2_n_0\,
      D => pv_p_w(14),
      Q => pv_p_w_ltch(14)
    );
\pv_p_w_ltch_reg[15]\: unisim.vcomponents.FDCE
     port map (
      C => clkin,
      CE => pv_pvld_w,
      CLR => \bram_addr_10bit[9]_i_2_n_0\,
      D => pv_p_w(15),
      Q => pv_p_w_ltch(15)
    );
\pv_p_w_ltch_reg[16]\: unisim.vcomponents.FDCE
     port map (
      C => clkin,
      CE => pv_pvld_w,
      CLR => \bram_addr_10bit[9]_i_2_n_0\,
      D => pv_p_w(16),
      Q => pv_p_w_ltch(16)
    );
\pv_p_w_ltch_reg[17]\: unisim.vcomponents.FDCE
     port map (
      C => clkin,
      CE => pv_pvld_w,
      CLR => \bram_addr_10bit[9]_i_2_n_0\,
      D => pv_p_w(17),
      Q => pv_p_w_ltch(17)
    );
\pv_p_w_ltch_reg[18]\: unisim.vcomponents.FDCE
     port map (
      C => clkin,
      CE => pv_pvld_w,
      CLR => \bram_addr_10bit[9]_i_2_n_0\,
      D => pv_p_w(18),
      Q => pv_p_w_ltch(18)
    );
\pv_p_w_ltch_reg[19]\: unisim.vcomponents.FDCE
     port map (
      C => clkin,
      CE => pv_pvld_w,
      CLR => \bram_addr_10bit[9]_i_2_n_0\,
      D => pv_p_w(19),
      Q => pv_p_w_ltch(19)
    );
\pv_p_w_ltch_reg[1]\: unisim.vcomponents.FDCE
     port map (
      C => clkin,
      CE => pv_pvld_w,
      CLR => \bram_addr_10bit[9]_i_2_n_0\,
      D => pv_p_w(1),
      Q => pv_p_w_ltch(1)
    );
\pv_p_w_ltch_reg[20]\: unisim.vcomponents.FDCE
     port map (
      C => clkin,
      CE => pv_pvld_w,
      CLR => \bram_addr_10bit[9]_i_2_n_0\,
      D => pv_p_w(20),
      Q => pv_p_w_ltch(20)
    );
\pv_p_w_ltch_reg[21]\: unisim.vcomponents.FDCE
     port map (
      C => clkin,
      CE => pv_pvld_w,
      CLR => \bram_addr_10bit[9]_i_2_n_0\,
      D => pv_p_w(21),
      Q => pv_p_w_ltch(21)
    );
\pv_p_w_ltch_reg[22]\: unisim.vcomponents.FDCE
     port map (
      C => clkin,
      CE => pv_pvld_w,
      CLR => \bram_addr_10bit[9]_i_2_n_0\,
      D => pv_p_w(22),
      Q => pv_p_w_ltch(22)
    );
\pv_p_w_ltch_reg[23]\: unisim.vcomponents.FDCE
     port map (
      C => clkin,
      CE => pv_pvld_w,
      CLR => \bram_addr_10bit[9]_i_2_n_0\,
      D => pv_p_w(23),
      Q => pv_p_w_ltch(23)
    );
\pv_p_w_ltch_reg[24]\: unisim.vcomponents.FDCE
     port map (
      C => clkin,
      CE => pv_pvld_w,
      CLR => \bram_addr_10bit[9]_i_2_n_0\,
      D => pv_p_w(24),
      Q => pv_p_w_ltch(24)
    );
\pv_p_w_ltch_reg[25]\: unisim.vcomponents.FDCE
     port map (
      C => clkin,
      CE => pv_pvld_w,
      CLR => \bram_addr_10bit[9]_i_2_n_0\,
      D => pv_p_w(25),
      Q => pv_p_w_ltch(25)
    );
\pv_p_w_ltch_reg[26]\: unisim.vcomponents.FDCE
     port map (
      C => clkin,
      CE => pv_pvld_w,
      CLR => \bram_addr_10bit[9]_i_2_n_0\,
      D => pv_p_w(26),
      Q => pv_p_w_ltch(26)
    );
\pv_p_w_ltch_reg[27]\: unisim.vcomponents.FDCE
     port map (
      C => clkin,
      CE => pv_pvld_w,
      CLR => \bram_addr_10bit[9]_i_2_n_0\,
      D => pv_p_w(27),
      Q => pv_p_w_ltch(27)
    );
\pv_p_w_ltch_reg[28]\: unisim.vcomponents.FDCE
     port map (
      C => clkin,
      CE => pv_pvld_w,
      CLR => \bram_addr_10bit[9]_i_2_n_0\,
      D => pv_p_w(28),
      Q => pv_p_w_ltch(28)
    );
\pv_p_w_ltch_reg[29]\: unisim.vcomponents.FDCE
     port map (
      C => clkin,
      CE => pv_pvld_w,
      CLR => \bram_addr_10bit[9]_i_2_n_0\,
      D => pv_p_w(29),
      Q => pv_p_w_ltch(29)
    );
\pv_p_w_ltch_reg[2]\: unisim.vcomponents.FDCE
     port map (
      C => clkin,
      CE => pv_pvld_w,
      CLR => \bram_addr_10bit[9]_i_2_n_0\,
      D => pv_p_w(2),
      Q => pv_p_w_ltch(2)
    );
\pv_p_w_ltch_reg[30]\: unisim.vcomponents.FDCE
     port map (
      C => clkin,
      CE => pv_pvld_w,
      CLR => \bram_addr_10bit[9]_i_2_n_0\,
      D => pv_p_w(30),
      Q => pv_p_w_ltch(30)
    );
\pv_p_w_ltch_reg[31]\: unisim.vcomponents.FDCE
     port map (
      C => clkin,
      CE => pv_pvld_w,
      CLR => \bram_addr_10bit[9]_i_2_n_0\,
      D => pv_p_w(31),
      Q => pv_p_w_ltch(31)
    );
\pv_p_w_ltch_reg[3]\: unisim.vcomponents.FDCE
     port map (
      C => clkin,
      CE => pv_pvld_w,
      CLR => \bram_addr_10bit[9]_i_2_n_0\,
      D => pv_p_w(3),
      Q => pv_p_w_ltch(3)
    );
\pv_p_w_ltch_reg[4]\: unisim.vcomponents.FDCE
     port map (
      C => clkin,
      CE => pv_pvld_w,
      CLR => \bram_addr_10bit[9]_i_2_n_0\,
      D => pv_p_w(4),
      Q => pv_p_w_ltch(4)
    );
\pv_p_w_ltch_reg[5]\: unisim.vcomponents.FDCE
     port map (
      C => clkin,
      CE => pv_pvld_w,
      CLR => \bram_addr_10bit[9]_i_2_n_0\,
      D => pv_p_w(5),
      Q => pv_p_w_ltch(5)
    );
\pv_p_w_ltch_reg[6]\: unisim.vcomponents.FDCE
     port map (
      C => clkin,
      CE => pv_pvld_w,
      CLR => \bram_addr_10bit[9]_i_2_n_0\,
      D => pv_p_w(6),
      Q => pv_p_w_ltch(6)
    );
\pv_p_w_ltch_reg[7]\: unisim.vcomponents.FDCE
     port map (
      C => clkin,
      CE => pv_pvld_w,
      CLR => \bram_addr_10bit[9]_i_2_n_0\,
      D => pv_p_w(7),
      Q => pv_p_w_ltch(7)
    );
\pv_p_w_ltch_reg[8]\: unisim.vcomponents.FDCE
     port map (
      C => clkin,
      CE => pv_pvld_w,
      CLR => \bram_addr_10bit[9]_i_2_n_0\,
      D => pv_p_w(8),
      Q => pv_p_w_ltch(8)
    );
\pv_p_w_ltch_reg[9]\: unisim.vcomponents.FDCE
     port map (
      C => clkin,
      CE => pv_pvld_w,
      CLR => \bram_addr_10bit[9]_i_2_n_0\,
      D => pv_p_w(9),
      Q => pv_p_w_ltch(9)
    );
pv_pvld_wltch_i_1: unisim.vcomponents.LUT3
    generic map(
      INIT => X"BA"
    )
        port map (
      I0 => pv_pvld_w,
      I1 => wcmd_sig_lastcmd(14),
      I2 => pv_pvld_wltch,
      O => pv_pvld_wltch_i_1_n_0
    );
pv_pvld_wltch_reg: unisim.vcomponents.FDCE
     port map (
      C => clkin,
      CE => '1',
      CLR => \bram_addr_10bit[9]_i_2_n_0\,
      D => pv_pvld_wltch_i_1_n_0,
      Q => pv_pvld_wltch
    );
pv_rdata_sig_i_1: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00000004"
    )
        port map (
      I0 => bess_bram_rdataflg,
      I1 => pv_bram_rdataflg,
      I2 => meter_bram_rdataflg,
      I3 => usrparam_bram_rdataflg,
      I4 => state,
      O => pv_rdata_sig_i_1_n_0
    );
pv_rdata_sig_reg: unisim.vcomponents.FDCE
     port map (
      C => clkin,
      CE => '1',
      CLR => \bram_addr_10bit[9]_i_2_n_0\,
      D => pv_rdata_sig_i_1_n_0,
      Q => pv_rdata_sig_reg_n_0
    );
pv_rdata_vld_i_1: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FEFF0080"
    )
        port map (
      I0 => state_pv_r(1),
      I1 => state_pv_r(0),
      I2 => state_pv_r(2),
      I3 => state_pv_r(3),
      I4 => \^pv_rdata_vld\,
      O => pv_rdata_vld_i_1_n_0
    );
pv_rdata_vld_reg: unisim.vcomponents.FDCE
     port map (
      C => clkin,
      CE => '1',
      CLR => \bram_addr_10bit[9]_i_2_n_0\,
      D => pv_rdata_vld_i_1_n_0,
      Q => \^pv_rdata_vld\
    );
\pv_status_r[7]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"02000000"
    )
        port map (
      I0 => arst_n,
      I1 => state_pv_r(3),
      I2 => state_pv_r(2),
      I3 => state_pv_r(0),
      I4 => state_pv_r(1),
      O => \pv_status_r[7]_i_1_n_0\
    );
\pv_status_r_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \pv_status_r[7]_i_1_n_0\,
      D => bram_din(0),
      Q => pv_status_r(0),
      R => '0'
    );
\pv_status_r_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \pv_status_r[7]_i_1_n_0\,
      D => bram_din(1),
      Q => pv_status_r(1),
      R => '0'
    );
\pv_status_r_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \pv_status_r[7]_i_1_n_0\,
      D => bram_din(2),
      Q => pv_status_r(2),
      R => '0'
    );
\pv_status_r_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \pv_status_r[7]_i_1_n_0\,
      D => bram_din(3),
      Q => pv_status_r(3),
      R => '0'
    );
\pv_status_r_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \pv_status_r[7]_i_1_n_0\,
      D => bram_din(4),
      Q => pv_status_r(4),
      R => '0'
    );
\pv_status_r_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \pv_status_r[7]_i_1_n_0\,
      D => bram_din(5),
      Q => pv_status_r(5),
      R => '0'
    );
\pv_status_r_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \pv_status_r[7]_i_1_n_0\,
      D => bram_din(6),
      Q => pv_status_r(6),
      R => '0'
    );
\pv_status_r_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \pv_status_r[7]_i_1_n_0\,
      D => bram_din(7),
      Q => pv_status_r(7),
      R => '0'
    );
\pv_var_r[31]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00004000"
    )
        port map (
      I0 => state_pv_r(0),
      I1 => state_pv_r(1),
      I2 => arst_n,
      I3 => state_pv_r(2),
      I4 => state_pv_r(3),
      O => \pv_var_r[31]_i_1_n_0\
    );
\pv_var_r_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \pv_var_r[31]_i_1_n_0\,
      D => bram_din(0),
      Q => pv_var_r(0),
      R => '0'
    );
\pv_var_r_reg[10]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \pv_var_r[31]_i_1_n_0\,
      D => bram_din(10),
      Q => pv_var_r(10),
      R => '0'
    );
\pv_var_r_reg[11]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \pv_var_r[31]_i_1_n_0\,
      D => bram_din(11),
      Q => pv_var_r(11),
      R => '0'
    );
\pv_var_r_reg[12]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \pv_var_r[31]_i_1_n_0\,
      D => bram_din(12),
      Q => pv_var_r(12),
      R => '0'
    );
\pv_var_r_reg[13]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \pv_var_r[31]_i_1_n_0\,
      D => bram_din(13),
      Q => pv_var_r(13),
      R => '0'
    );
\pv_var_r_reg[14]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \pv_var_r[31]_i_1_n_0\,
      D => bram_din(14),
      Q => pv_var_r(14),
      R => '0'
    );
\pv_var_r_reg[15]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \pv_var_r[31]_i_1_n_0\,
      D => bram_din(15),
      Q => pv_var_r(15),
      R => '0'
    );
\pv_var_r_reg[16]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \pv_var_r[31]_i_1_n_0\,
      D => bram_din(16),
      Q => pv_var_r(16),
      R => '0'
    );
\pv_var_r_reg[17]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \pv_var_r[31]_i_1_n_0\,
      D => bram_din(17),
      Q => pv_var_r(17),
      R => '0'
    );
\pv_var_r_reg[18]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \pv_var_r[31]_i_1_n_0\,
      D => bram_din(18),
      Q => pv_var_r(18),
      R => '0'
    );
\pv_var_r_reg[19]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \pv_var_r[31]_i_1_n_0\,
      D => bram_din(19),
      Q => pv_var_r(19),
      R => '0'
    );
\pv_var_r_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \pv_var_r[31]_i_1_n_0\,
      D => bram_din(1),
      Q => pv_var_r(1),
      R => '0'
    );
\pv_var_r_reg[20]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \pv_var_r[31]_i_1_n_0\,
      D => bram_din(20),
      Q => pv_var_r(20),
      R => '0'
    );
\pv_var_r_reg[21]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \pv_var_r[31]_i_1_n_0\,
      D => bram_din(21),
      Q => pv_var_r(21),
      R => '0'
    );
\pv_var_r_reg[22]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \pv_var_r[31]_i_1_n_0\,
      D => bram_din(22),
      Q => pv_var_r(22),
      R => '0'
    );
\pv_var_r_reg[23]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \pv_var_r[31]_i_1_n_0\,
      D => bram_din(23),
      Q => pv_var_r(23),
      R => '0'
    );
\pv_var_r_reg[24]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \pv_var_r[31]_i_1_n_0\,
      D => bram_din(24),
      Q => pv_var_r(24),
      R => '0'
    );
\pv_var_r_reg[25]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \pv_var_r[31]_i_1_n_0\,
      D => bram_din(25),
      Q => pv_var_r(25),
      R => '0'
    );
\pv_var_r_reg[26]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \pv_var_r[31]_i_1_n_0\,
      D => bram_din(26),
      Q => pv_var_r(26),
      R => '0'
    );
\pv_var_r_reg[27]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \pv_var_r[31]_i_1_n_0\,
      D => bram_din(27),
      Q => pv_var_r(27),
      R => '0'
    );
\pv_var_r_reg[28]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \pv_var_r[31]_i_1_n_0\,
      D => bram_din(28),
      Q => pv_var_r(28),
      R => '0'
    );
\pv_var_r_reg[29]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \pv_var_r[31]_i_1_n_0\,
      D => bram_din(29),
      Q => pv_var_r(29),
      R => '0'
    );
\pv_var_r_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \pv_var_r[31]_i_1_n_0\,
      D => bram_din(2),
      Q => pv_var_r(2),
      R => '0'
    );
\pv_var_r_reg[30]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \pv_var_r[31]_i_1_n_0\,
      D => bram_din(30),
      Q => pv_var_r(30),
      R => '0'
    );
\pv_var_r_reg[31]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \pv_var_r[31]_i_1_n_0\,
      D => bram_din(31),
      Q => pv_var_r(31),
      R => '0'
    );
\pv_var_r_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \pv_var_r[31]_i_1_n_0\,
      D => bram_din(3),
      Q => pv_var_r(3),
      R => '0'
    );
\pv_var_r_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \pv_var_r[31]_i_1_n_0\,
      D => bram_din(4),
      Q => pv_var_r(4),
      R => '0'
    );
\pv_var_r_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \pv_var_r[31]_i_1_n_0\,
      D => bram_din(5),
      Q => pv_var_r(5),
      R => '0'
    );
\pv_var_r_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \pv_var_r[31]_i_1_n_0\,
      D => bram_din(6),
      Q => pv_var_r(6),
      R => '0'
    );
\pv_var_r_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \pv_var_r[31]_i_1_n_0\,
      D => bram_din(7),
      Q => pv_var_r(7),
      R => '0'
    );
\pv_var_r_reg[8]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \pv_var_r[31]_i_1_n_0\,
      D => bram_din(8),
      Q => pv_var_r(8),
      R => '0'
    );
\pv_var_r_reg[9]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \pv_var_r[31]_i_1_n_0\,
      D => bram_din(9),
      Q => pv_var_r(9),
      R => '0'
    );
\pv_watt_r[31]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00004000"
    )
        port map (
      I0 => state_pv_r(1),
      I1 => state_pv_r(0),
      I2 => arst_n,
      I3 => state_pv_r(2),
      I4 => state_pv_r(3),
      O => \pv_watt_r[31]_i_1_n_0\
    );
\pv_watt_r_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \pv_watt_r[31]_i_1_n_0\,
      D => bram_din(0),
      Q => pv_watt_r(0),
      R => '0'
    );
\pv_watt_r_reg[10]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \pv_watt_r[31]_i_1_n_0\,
      D => bram_din(10),
      Q => pv_watt_r(10),
      R => '0'
    );
\pv_watt_r_reg[11]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \pv_watt_r[31]_i_1_n_0\,
      D => bram_din(11),
      Q => pv_watt_r(11),
      R => '0'
    );
\pv_watt_r_reg[12]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \pv_watt_r[31]_i_1_n_0\,
      D => bram_din(12),
      Q => pv_watt_r(12),
      R => '0'
    );
\pv_watt_r_reg[13]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \pv_watt_r[31]_i_1_n_0\,
      D => bram_din(13),
      Q => pv_watt_r(13),
      R => '0'
    );
\pv_watt_r_reg[14]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \pv_watt_r[31]_i_1_n_0\,
      D => bram_din(14),
      Q => pv_watt_r(14),
      R => '0'
    );
\pv_watt_r_reg[15]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \pv_watt_r[31]_i_1_n_0\,
      D => bram_din(15),
      Q => pv_watt_r(15),
      R => '0'
    );
\pv_watt_r_reg[16]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \pv_watt_r[31]_i_1_n_0\,
      D => bram_din(16),
      Q => pv_watt_r(16),
      R => '0'
    );
\pv_watt_r_reg[17]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \pv_watt_r[31]_i_1_n_0\,
      D => bram_din(17),
      Q => pv_watt_r(17),
      R => '0'
    );
\pv_watt_r_reg[18]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \pv_watt_r[31]_i_1_n_0\,
      D => bram_din(18),
      Q => pv_watt_r(18),
      R => '0'
    );
\pv_watt_r_reg[19]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \pv_watt_r[31]_i_1_n_0\,
      D => bram_din(19),
      Q => pv_watt_r(19),
      R => '0'
    );
\pv_watt_r_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \pv_watt_r[31]_i_1_n_0\,
      D => bram_din(1),
      Q => pv_watt_r(1),
      R => '0'
    );
\pv_watt_r_reg[20]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \pv_watt_r[31]_i_1_n_0\,
      D => bram_din(20),
      Q => pv_watt_r(20),
      R => '0'
    );
\pv_watt_r_reg[21]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \pv_watt_r[31]_i_1_n_0\,
      D => bram_din(21),
      Q => pv_watt_r(21),
      R => '0'
    );
\pv_watt_r_reg[22]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \pv_watt_r[31]_i_1_n_0\,
      D => bram_din(22),
      Q => pv_watt_r(22),
      R => '0'
    );
\pv_watt_r_reg[23]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \pv_watt_r[31]_i_1_n_0\,
      D => bram_din(23),
      Q => pv_watt_r(23),
      R => '0'
    );
\pv_watt_r_reg[24]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \pv_watt_r[31]_i_1_n_0\,
      D => bram_din(24),
      Q => pv_watt_r(24),
      R => '0'
    );
\pv_watt_r_reg[25]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \pv_watt_r[31]_i_1_n_0\,
      D => bram_din(25),
      Q => pv_watt_r(25),
      R => '0'
    );
\pv_watt_r_reg[26]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \pv_watt_r[31]_i_1_n_0\,
      D => bram_din(26),
      Q => pv_watt_r(26),
      R => '0'
    );
\pv_watt_r_reg[27]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \pv_watt_r[31]_i_1_n_0\,
      D => bram_din(27),
      Q => pv_watt_r(27),
      R => '0'
    );
\pv_watt_r_reg[28]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \pv_watt_r[31]_i_1_n_0\,
      D => bram_din(28),
      Q => pv_watt_r(28),
      R => '0'
    );
\pv_watt_r_reg[29]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \pv_watt_r[31]_i_1_n_0\,
      D => bram_din(29),
      Q => pv_watt_r(29),
      R => '0'
    );
\pv_watt_r_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \pv_watt_r[31]_i_1_n_0\,
      D => bram_din(2),
      Q => pv_watt_r(2),
      R => '0'
    );
\pv_watt_r_reg[30]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \pv_watt_r[31]_i_1_n_0\,
      D => bram_din(30),
      Q => pv_watt_r(30),
      R => '0'
    );
\pv_watt_r_reg[31]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \pv_watt_r[31]_i_1_n_0\,
      D => bram_din(31),
      Q => pv_watt_r(31),
      R => '0'
    );
\pv_watt_r_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \pv_watt_r[31]_i_1_n_0\,
      D => bram_din(3),
      Q => pv_watt_r(3),
      R => '0'
    );
\pv_watt_r_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \pv_watt_r[31]_i_1_n_0\,
      D => bram_din(4),
      Q => pv_watt_r(4),
      R => '0'
    );
\pv_watt_r_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \pv_watt_r[31]_i_1_n_0\,
      D => bram_din(5),
      Q => pv_watt_r(5),
      R => '0'
    );
\pv_watt_r_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \pv_watt_r[31]_i_1_n_0\,
      D => bram_din(6),
      Q => pv_watt_r(6),
      R => '0'
    );
\pv_watt_r_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \pv_watt_r[31]_i_1_n_0\,
      D => bram_din(7),
      Q => pv_watt_r(7),
      R => '0'
    );
\pv_watt_r_reg[8]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \pv_watt_r[31]_i_1_n_0\,
      D => bram_din(8),
      Q => pv_watt_r(8),
      R => '0'
    );
\pv_watt_r_reg[9]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \pv_watt_r[31]_i_1_n_0\,
      D => bram_din(9),
      Q => pv_watt_r(9),
      R => '0'
    );
\pv_wattsp_r[31]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00000008"
    )
        port map (
      I0 => arst_n,
      I1 => state_pv_r(2),
      I2 => state_pv_r(3),
      I3 => state_pv_r(0),
      I4 => state_pv_r(1),
      O => \pv_wattsp_r[31]_i_1_n_0\
    );
\pv_wattsp_r_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \pv_wattsp_r[31]_i_1_n_0\,
      D => bram_din(0),
      Q => pv_wattsp_r(0),
      R => '0'
    );
\pv_wattsp_r_reg[10]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \pv_wattsp_r[31]_i_1_n_0\,
      D => bram_din(10),
      Q => pv_wattsp_r(10),
      R => '0'
    );
\pv_wattsp_r_reg[11]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \pv_wattsp_r[31]_i_1_n_0\,
      D => bram_din(11),
      Q => pv_wattsp_r(11),
      R => '0'
    );
\pv_wattsp_r_reg[12]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \pv_wattsp_r[31]_i_1_n_0\,
      D => bram_din(12),
      Q => pv_wattsp_r(12),
      R => '0'
    );
\pv_wattsp_r_reg[13]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \pv_wattsp_r[31]_i_1_n_0\,
      D => bram_din(13),
      Q => pv_wattsp_r(13),
      R => '0'
    );
\pv_wattsp_r_reg[14]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \pv_wattsp_r[31]_i_1_n_0\,
      D => bram_din(14),
      Q => pv_wattsp_r(14),
      R => '0'
    );
\pv_wattsp_r_reg[15]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \pv_wattsp_r[31]_i_1_n_0\,
      D => bram_din(15),
      Q => pv_wattsp_r(15),
      R => '0'
    );
\pv_wattsp_r_reg[16]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \pv_wattsp_r[31]_i_1_n_0\,
      D => bram_din(16),
      Q => pv_wattsp_r(16),
      R => '0'
    );
\pv_wattsp_r_reg[17]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \pv_wattsp_r[31]_i_1_n_0\,
      D => bram_din(17),
      Q => pv_wattsp_r(17),
      R => '0'
    );
\pv_wattsp_r_reg[18]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \pv_wattsp_r[31]_i_1_n_0\,
      D => bram_din(18),
      Q => pv_wattsp_r(18),
      R => '0'
    );
\pv_wattsp_r_reg[19]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \pv_wattsp_r[31]_i_1_n_0\,
      D => bram_din(19),
      Q => pv_wattsp_r(19),
      R => '0'
    );
\pv_wattsp_r_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \pv_wattsp_r[31]_i_1_n_0\,
      D => bram_din(1),
      Q => pv_wattsp_r(1),
      R => '0'
    );
\pv_wattsp_r_reg[20]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \pv_wattsp_r[31]_i_1_n_0\,
      D => bram_din(20),
      Q => pv_wattsp_r(20),
      R => '0'
    );
\pv_wattsp_r_reg[21]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \pv_wattsp_r[31]_i_1_n_0\,
      D => bram_din(21),
      Q => pv_wattsp_r(21),
      R => '0'
    );
\pv_wattsp_r_reg[22]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \pv_wattsp_r[31]_i_1_n_0\,
      D => bram_din(22),
      Q => pv_wattsp_r(22),
      R => '0'
    );
\pv_wattsp_r_reg[23]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \pv_wattsp_r[31]_i_1_n_0\,
      D => bram_din(23),
      Q => pv_wattsp_r(23),
      R => '0'
    );
\pv_wattsp_r_reg[24]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \pv_wattsp_r[31]_i_1_n_0\,
      D => bram_din(24),
      Q => pv_wattsp_r(24),
      R => '0'
    );
\pv_wattsp_r_reg[25]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \pv_wattsp_r[31]_i_1_n_0\,
      D => bram_din(25),
      Q => pv_wattsp_r(25),
      R => '0'
    );
\pv_wattsp_r_reg[26]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \pv_wattsp_r[31]_i_1_n_0\,
      D => bram_din(26),
      Q => pv_wattsp_r(26),
      R => '0'
    );
\pv_wattsp_r_reg[27]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \pv_wattsp_r[31]_i_1_n_0\,
      D => bram_din(27),
      Q => pv_wattsp_r(27),
      R => '0'
    );
\pv_wattsp_r_reg[28]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \pv_wattsp_r[31]_i_1_n_0\,
      D => bram_din(28),
      Q => pv_wattsp_r(28),
      R => '0'
    );
\pv_wattsp_r_reg[29]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \pv_wattsp_r[31]_i_1_n_0\,
      D => bram_din(29),
      Q => pv_wattsp_r(29),
      R => '0'
    );
\pv_wattsp_r_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \pv_wattsp_r[31]_i_1_n_0\,
      D => bram_din(2),
      Q => pv_wattsp_r(2),
      R => '0'
    );
\pv_wattsp_r_reg[30]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \pv_wattsp_r[31]_i_1_n_0\,
      D => bram_din(30),
      Q => pv_wattsp_r(30),
      R => '0'
    );
\pv_wattsp_r_reg[31]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \pv_wattsp_r[31]_i_1_n_0\,
      D => bram_din(31),
      Q => pv_wattsp_r(31),
      R => '0'
    );
\pv_wattsp_r_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \pv_wattsp_r[31]_i_1_n_0\,
      D => bram_din(3),
      Q => pv_wattsp_r(3),
      R => '0'
    );
\pv_wattsp_r_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \pv_wattsp_r[31]_i_1_n_0\,
      D => bram_din(4),
      Q => pv_wattsp_r(4),
      R => '0'
    );
\pv_wattsp_r_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \pv_wattsp_r[31]_i_1_n_0\,
      D => bram_din(5),
      Q => pv_wattsp_r(5),
      R => '0'
    );
\pv_wattsp_r_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \pv_wattsp_r[31]_i_1_n_0\,
      D => bram_din(6),
      Q => pv_wattsp_r(6),
      R => '0'
    );
\pv_wattsp_r_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \pv_wattsp_r[31]_i_1_n_0\,
      D => bram_din(7),
      Q => pv_wattsp_r(7),
      R => '0'
    );
\pv_wattsp_r_reg[8]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \pv_wattsp_r[31]_i_1_n_0\,
      D => bram_din(8),
      Q => pv_wattsp_r(8),
      R => '0'
    );
\pv_wattsp_r_reg[9]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \pv_wattsp_r[31]_i_1_n_0\,
      D => bram_din(9),
      Q => pv_wattsp_r(9),
      R => '0'
    );
\pv_yield_r[31]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"08000000"
    )
        port map (
      I0 => arst_n,
      I1 => state_pv_r(2),
      I2 => state_pv_r(3),
      I3 => state_pv_r(0),
      I4 => state_pv_r(1),
      O => \pv_yield_r[31]_i_1_n_0\
    );
\pv_yield_r_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \pv_yield_r[31]_i_1_n_0\,
      D => bram_din(0),
      Q => pv_yield_r(0),
      R => '0'
    );
\pv_yield_r_reg[10]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \pv_yield_r[31]_i_1_n_0\,
      D => bram_din(10),
      Q => pv_yield_r(10),
      R => '0'
    );
\pv_yield_r_reg[11]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \pv_yield_r[31]_i_1_n_0\,
      D => bram_din(11),
      Q => pv_yield_r(11),
      R => '0'
    );
\pv_yield_r_reg[12]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \pv_yield_r[31]_i_1_n_0\,
      D => bram_din(12),
      Q => pv_yield_r(12),
      R => '0'
    );
\pv_yield_r_reg[13]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \pv_yield_r[31]_i_1_n_0\,
      D => bram_din(13),
      Q => pv_yield_r(13),
      R => '0'
    );
\pv_yield_r_reg[14]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \pv_yield_r[31]_i_1_n_0\,
      D => bram_din(14),
      Q => pv_yield_r(14),
      R => '0'
    );
\pv_yield_r_reg[15]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \pv_yield_r[31]_i_1_n_0\,
      D => bram_din(15),
      Q => pv_yield_r(15),
      R => '0'
    );
\pv_yield_r_reg[16]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \pv_yield_r[31]_i_1_n_0\,
      D => bram_din(16),
      Q => pv_yield_r(16),
      R => '0'
    );
\pv_yield_r_reg[17]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \pv_yield_r[31]_i_1_n_0\,
      D => bram_din(17),
      Q => pv_yield_r(17),
      R => '0'
    );
\pv_yield_r_reg[18]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \pv_yield_r[31]_i_1_n_0\,
      D => bram_din(18),
      Q => pv_yield_r(18),
      R => '0'
    );
\pv_yield_r_reg[19]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \pv_yield_r[31]_i_1_n_0\,
      D => bram_din(19),
      Q => pv_yield_r(19),
      R => '0'
    );
\pv_yield_r_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \pv_yield_r[31]_i_1_n_0\,
      D => bram_din(1),
      Q => pv_yield_r(1),
      R => '0'
    );
\pv_yield_r_reg[20]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \pv_yield_r[31]_i_1_n_0\,
      D => bram_din(20),
      Q => pv_yield_r(20),
      R => '0'
    );
\pv_yield_r_reg[21]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \pv_yield_r[31]_i_1_n_0\,
      D => bram_din(21),
      Q => pv_yield_r(21),
      R => '0'
    );
\pv_yield_r_reg[22]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \pv_yield_r[31]_i_1_n_0\,
      D => bram_din(22),
      Q => pv_yield_r(22),
      R => '0'
    );
\pv_yield_r_reg[23]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \pv_yield_r[31]_i_1_n_0\,
      D => bram_din(23),
      Q => pv_yield_r(23),
      R => '0'
    );
\pv_yield_r_reg[24]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \pv_yield_r[31]_i_1_n_0\,
      D => bram_din(24),
      Q => pv_yield_r(24),
      R => '0'
    );
\pv_yield_r_reg[25]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \pv_yield_r[31]_i_1_n_0\,
      D => bram_din(25),
      Q => pv_yield_r(25),
      R => '0'
    );
\pv_yield_r_reg[26]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \pv_yield_r[31]_i_1_n_0\,
      D => bram_din(26),
      Q => pv_yield_r(26),
      R => '0'
    );
\pv_yield_r_reg[27]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \pv_yield_r[31]_i_1_n_0\,
      D => bram_din(27),
      Q => pv_yield_r(27),
      R => '0'
    );
\pv_yield_r_reg[28]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \pv_yield_r[31]_i_1_n_0\,
      D => bram_din(28),
      Q => pv_yield_r(28),
      R => '0'
    );
\pv_yield_r_reg[29]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \pv_yield_r[31]_i_1_n_0\,
      D => bram_din(29),
      Q => pv_yield_r(29),
      R => '0'
    );
\pv_yield_r_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \pv_yield_r[31]_i_1_n_0\,
      D => bram_din(2),
      Q => pv_yield_r(2),
      R => '0'
    );
\pv_yield_r_reg[30]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \pv_yield_r[31]_i_1_n_0\,
      D => bram_din(30),
      Q => pv_yield_r(30),
      R => '0'
    );
\pv_yield_r_reg[31]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \pv_yield_r[31]_i_1_n_0\,
      D => bram_din(31),
      Q => pv_yield_r(31),
      R => '0'
    );
\pv_yield_r_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \pv_yield_r[31]_i_1_n_0\,
      D => bram_din(3),
      Q => pv_yield_r(3),
      R => '0'
    );
\pv_yield_r_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \pv_yield_r[31]_i_1_n_0\,
      D => bram_din(4),
      Q => pv_yield_r(4),
      R => '0'
    );
\pv_yield_r_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \pv_yield_r[31]_i_1_n_0\,
      D => bram_din(5),
      Q => pv_yield_r(5),
      R => '0'
    );
\pv_yield_r_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \pv_yield_r[31]_i_1_n_0\,
      D => bram_din(6),
      Q => pv_yield_r(6),
      R => '0'
    );
\pv_yield_r_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \pv_yield_r[31]_i_1_n_0\,
      D => bram_din(7),
      Q => pv_yield_r(7),
      R => '0'
    );
\pv_yield_r_reg[8]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \pv_yield_r[31]_i_1_n_0\,
      D => bram_din(8),
      Q => pv_yield_r(8),
      R => '0'
    );
\pv_yield_r_reg[9]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \pv_yield_r[31]_i_1_n_0\,
      D => bram_din(9),
      Q => pv_yield_r(9),
      R => '0'
    );
\state_wcmd[0]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"5455005454545454"
    )
        port map (
      I0 => state_wcmd(0),
      I1 => pv_pvld_wltch,
      I2 => bess_pvld_wltch,
      I3 => pspl_wcmd_bsy,
      I4 => pspl_wcmd_bsyreg,
      I5 => \state_wcmd[0]_i_2_n_0\,
      O => \p_0_in__0\(0)
    );
\state_wcmd[0]_i_2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FFFE"
    )
        port map (
      I0 => \wcmd_sig_hld_reg_n_0_[29]\,
      I1 => \wcmd_sig_hld_reg_n_0_[22]\,
      I2 => \wcmd_sig_hld_reg_n_0_[14]\,
      I3 => \wcmd_sig_hld_reg_n_0_[30]\,
      O => \state_wcmd[0]_i_2_n_0\
    );
\state_wcmd[1]_i_1\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => state_wcmd(1),
      O => \state_wcmd[1]_i_1_n_0\
    );
\state_wcmd_reg[0]\: unisim.vcomponents.FDCE
     port map (
      C => clkin,
      CE => \state_wcmd[1]_i_1_n_0\,
      CLR => \bram_addr_10bit[9]_i_2_n_0\,
      D => \p_0_in__0\(0),
      Q => state_wcmd(0)
    );
\state_wcmd_reg[1]\: unisim.vcomponents.FDCE
     port map (
      C => clkin,
      CE => \state_wcmd[1]_i_1_n_0\,
      CLR => \bram_addr_10bit[9]_i_2_n_0\,
      D => '0',
      Q => state_wcmd(1)
    );
\usr_bess_kd[31]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0004000000000000"
    )
        port map (
      I0 => state_usrparam_r(2),
      I1 => state_usrparam_r(0),
      I2 => state_usrparam_r(1),
      I3 => state_usrparam_r(4),
      I4 => state_usrparam_r(3),
      I5 => arst_n,
      O => \usr_bess_kd[31]_i_1_n_0\
    );
\usr_bess_kd_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_bess_kd[31]_i_1_n_0\,
      D => bram_din(0),
      Q => usr_bess_kd(0),
      R => '0'
    );
\usr_bess_kd_reg[10]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_bess_kd[31]_i_1_n_0\,
      D => bram_din(10),
      Q => usr_bess_kd(10),
      R => '0'
    );
\usr_bess_kd_reg[11]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_bess_kd[31]_i_1_n_0\,
      D => bram_din(11),
      Q => usr_bess_kd(11),
      R => '0'
    );
\usr_bess_kd_reg[12]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_bess_kd[31]_i_1_n_0\,
      D => bram_din(12),
      Q => usr_bess_kd(12),
      R => '0'
    );
\usr_bess_kd_reg[13]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_bess_kd[31]_i_1_n_0\,
      D => bram_din(13),
      Q => usr_bess_kd(13),
      R => '0'
    );
\usr_bess_kd_reg[14]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_bess_kd[31]_i_1_n_0\,
      D => bram_din(14),
      Q => usr_bess_kd(14),
      R => '0'
    );
\usr_bess_kd_reg[15]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_bess_kd[31]_i_1_n_0\,
      D => bram_din(15),
      Q => usr_bess_kd(15),
      R => '0'
    );
\usr_bess_kd_reg[16]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_bess_kd[31]_i_1_n_0\,
      D => bram_din(16),
      Q => usr_bess_kd(16),
      R => '0'
    );
\usr_bess_kd_reg[17]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_bess_kd[31]_i_1_n_0\,
      D => bram_din(17),
      Q => usr_bess_kd(17),
      R => '0'
    );
\usr_bess_kd_reg[18]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_bess_kd[31]_i_1_n_0\,
      D => bram_din(18),
      Q => usr_bess_kd(18),
      R => '0'
    );
\usr_bess_kd_reg[19]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_bess_kd[31]_i_1_n_0\,
      D => bram_din(19),
      Q => usr_bess_kd(19),
      R => '0'
    );
\usr_bess_kd_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_bess_kd[31]_i_1_n_0\,
      D => bram_din(1),
      Q => usr_bess_kd(1),
      R => '0'
    );
\usr_bess_kd_reg[20]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_bess_kd[31]_i_1_n_0\,
      D => bram_din(20),
      Q => usr_bess_kd(20),
      R => '0'
    );
\usr_bess_kd_reg[21]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_bess_kd[31]_i_1_n_0\,
      D => bram_din(21),
      Q => usr_bess_kd(21),
      R => '0'
    );
\usr_bess_kd_reg[22]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_bess_kd[31]_i_1_n_0\,
      D => bram_din(22),
      Q => usr_bess_kd(22),
      R => '0'
    );
\usr_bess_kd_reg[23]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_bess_kd[31]_i_1_n_0\,
      D => bram_din(23),
      Q => usr_bess_kd(23),
      R => '0'
    );
\usr_bess_kd_reg[24]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_bess_kd[31]_i_1_n_0\,
      D => bram_din(24),
      Q => usr_bess_kd(24),
      R => '0'
    );
\usr_bess_kd_reg[25]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_bess_kd[31]_i_1_n_0\,
      D => bram_din(25),
      Q => usr_bess_kd(25),
      R => '0'
    );
\usr_bess_kd_reg[26]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_bess_kd[31]_i_1_n_0\,
      D => bram_din(26),
      Q => usr_bess_kd(26),
      R => '0'
    );
\usr_bess_kd_reg[27]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_bess_kd[31]_i_1_n_0\,
      D => bram_din(27),
      Q => usr_bess_kd(27),
      R => '0'
    );
\usr_bess_kd_reg[28]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_bess_kd[31]_i_1_n_0\,
      D => bram_din(28),
      Q => usr_bess_kd(28),
      R => '0'
    );
\usr_bess_kd_reg[29]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_bess_kd[31]_i_1_n_0\,
      D => bram_din(29),
      Q => usr_bess_kd(29),
      R => '0'
    );
\usr_bess_kd_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_bess_kd[31]_i_1_n_0\,
      D => bram_din(2),
      Q => usr_bess_kd(2),
      R => '0'
    );
\usr_bess_kd_reg[30]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_bess_kd[31]_i_1_n_0\,
      D => bram_din(30),
      Q => usr_bess_kd(30),
      R => '0'
    );
\usr_bess_kd_reg[31]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_bess_kd[31]_i_1_n_0\,
      D => bram_din(31),
      Q => usr_bess_kd(31),
      R => '0'
    );
\usr_bess_kd_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_bess_kd[31]_i_1_n_0\,
      D => bram_din(3),
      Q => usr_bess_kd(3),
      R => '0'
    );
\usr_bess_kd_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_bess_kd[31]_i_1_n_0\,
      D => bram_din(4),
      Q => usr_bess_kd(4),
      R => '0'
    );
\usr_bess_kd_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_bess_kd[31]_i_1_n_0\,
      D => bram_din(5),
      Q => usr_bess_kd(5),
      R => '0'
    );
\usr_bess_kd_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_bess_kd[31]_i_1_n_0\,
      D => bram_din(6),
      Q => usr_bess_kd(6),
      R => '0'
    );
\usr_bess_kd_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_bess_kd[31]_i_1_n_0\,
      D => bram_din(7),
      Q => usr_bess_kd(7),
      R => '0'
    );
\usr_bess_kd_reg[8]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_bess_kd[31]_i_1_n_0\,
      D => bram_din(8),
      Q => usr_bess_kd(8),
      R => '0'
    );
\usr_bess_kd_reg[9]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_bess_kd[31]_i_1_n_0\,
      D => bram_din(9),
      Q => usr_bess_kd(9),
      R => '0'
    );
\usr_bess_ki[31]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0001000000000000"
    )
        port map (
      I0 => state_usrparam_r(2),
      I1 => state_usrparam_r(0),
      I2 => state_usrparam_r(1),
      I3 => state_usrparam_r(4),
      I4 => state_usrparam_r(3),
      I5 => arst_n,
      O => \usr_bess_ki[31]_i_1_n_0\
    );
\usr_bess_ki_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_bess_ki[31]_i_1_n_0\,
      D => bram_din(0),
      Q => usr_bess_ki(0),
      R => '0'
    );
\usr_bess_ki_reg[10]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_bess_ki[31]_i_1_n_0\,
      D => bram_din(10),
      Q => usr_bess_ki(10),
      R => '0'
    );
\usr_bess_ki_reg[11]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_bess_ki[31]_i_1_n_0\,
      D => bram_din(11),
      Q => usr_bess_ki(11),
      R => '0'
    );
\usr_bess_ki_reg[12]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_bess_ki[31]_i_1_n_0\,
      D => bram_din(12),
      Q => usr_bess_ki(12),
      R => '0'
    );
\usr_bess_ki_reg[13]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_bess_ki[31]_i_1_n_0\,
      D => bram_din(13),
      Q => usr_bess_ki(13),
      R => '0'
    );
\usr_bess_ki_reg[14]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_bess_ki[31]_i_1_n_0\,
      D => bram_din(14),
      Q => usr_bess_ki(14),
      R => '0'
    );
\usr_bess_ki_reg[15]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_bess_ki[31]_i_1_n_0\,
      D => bram_din(15),
      Q => usr_bess_ki(15),
      R => '0'
    );
\usr_bess_ki_reg[16]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_bess_ki[31]_i_1_n_0\,
      D => bram_din(16),
      Q => usr_bess_ki(16),
      R => '0'
    );
\usr_bess_ki_reg[17]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_bess_ki[31]_i_1_n_0\,
      D => bram_din(17),
      Q => usr_bess_ki(17),
      R => '0'
    );
\usr_bess_ki_reg[18]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_bess_ki[31]_i_1_n_0\,
      D => bram_din(18),
      Q => usr_bess_ki(18),
      R => '0'
    );
\usr_bess_ki_reg[19]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_bess_ki[31]_i_1_n_0\,
      D => bram_din(19),
      Q => usr_bess_ki(19),
      R => '0'
    );
\usr_bess_ki_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_bess_ki[31]_i_1_n_0\,
      D => bram_din(1),
      Q => usr_bess_ki(1),
      R => '0'
    );
\usr_bess_ki_reg[20]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_bess_ki[31]_i_1_n_0\,
      D => bram_din(20),
      Q => usr_bess_ki(20),
      R => '0'
    );
\usr_bess_ki_reg[21]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_bess_ki[31]_i_1_n_0\,
      D => bram_din(21),
      Q => usr_bess_ki(21),
      R => '0'
    );
\usr_bess_ki_reg[22]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_bess_ki[31]_i_1_n_0\,
      D => bram_din(22),
      Q => usr_bess_ki(22),
      R => '0'
    );
\usr_bess_ki_reg[23]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_bess_ki[31]_i_1_n_0\,
      D => bram_din(23),
      Q => usr_bess_ki(23),
      R => '0'
    );
\usr_bess_ki_reg[24]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_bess_ki[31]_i_1_n_0\,
      D => bram_din(24),
      Q => usr_bess_ki(24),
      R => '0'
    );
\usr_bess_ki_reg[25]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_bess_ki[31]_i_1_n_0\,
      D => bram_din(25),
      Q => usr_bess_ki(25),
      R => '0'
    );
\usr_bess_ki_reg[26]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_bess_ki[31]_i_1_n_0\,
      D => bram_din(26),
      Q => usr_bess_ki(26),
      R => '0'
    );
\usr_bess_ki_reg[27]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_bess_ki[31]_i_1_n_0\,
      D => bram_din(27),
      Q => usr_bess_ki(27),
      R => '0'
    );
\usr_bess_ki_reg[28]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_bess_ki[31]_i_1_n_0\,
      D => bram_din(28),
      Q => usr_bess_ki(28),
      R => '0'
    );
\usr_bess_ki_reg[29]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_bess_ki[31]_i_1_n_0\,
      D => bram_din(29),
      Q => usr_bess_ki(29),
      R => '0'
    );
\usr_bess_ki_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_bess_ki[31]_i_1_n_0\,
      D => bram_din(2),
      Q => usr_bess_ki(2),
      R => '0'
    );
\usr_bess_ki_reg[30]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_bess_ki[31]_i_1_n_0\,
      D => bram_din(30),
      Q => usr_bess_ki(30),
      R => '0'
    );
\usr_bess_ki_reg[31]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_bess_ki[31]_i_1_n_0\,
      D => bram_din(31),
      Q => usr_bess_ki(31),
      R => '0'
    );
\usr_bess_ki_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_bess_ki[31]_i_1_n_0\,
      D => bram_din(3),
      Q => usr_bess_ki(3),
      R => '0'
    );
\usr_bess_ki_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_bess_ki[31]_i_1_n_0\,
      D => bram_din(4),
      Q => usr_bess_ki(4),
      R => '0'
    );
\usr_bess_ki_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_bess_ki[31]_i_1_n_0\,
      D => bram_din(5),
      Q => usr_bess_ki(5),
      R => '0'
    );
\usr_bess_ki_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_bess_ki[31]_i_1_n_0\,
      D => bram_din(6),
      Q => usr_bess_ki(6),
      R => '0'
    );
\usr_bess_ki_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_bess_ki[31]_i_1_n_0\,
      D => bram_din(7),
      Q => usr_bess_ki(7),
      R => '0'
    );
\usr_bess_ki_reg[8]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_bess_ki[31]_i_1_n_0\,
      D => bram_din(8),
      Q => usr_bess_ki(8),
      R => '0'
    );
\usr_bess_ki_reg[9]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_bess_ki[31]_i_1_n_0\,
      D => bram_din(9),
      Q => usr_bess_ki(9),
      R => '0'
    );
\usr_bess_kp[31]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0020000000000000"
    )
        port map (
      I0 => state_usrparam_r(1),
      I1 => state_usrparam_r(4),
      I2 => arst_n,
      I3 => state_usrparam_r(3),
      I4 => state_usrparam_r(2),
      I5 => state_usrparam_r(0),
      O => \usr_bess_kp[31]_i_1_n_0\
    );
\usr_bess_kp_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_bess_kp[31]_i_1_n_0\,
      D => bram_din(0),
      Q => usr_bess_kp(0),
      R => '0'
    );
\usr_bess_kp_reg[10]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_bess_kp[31]_i_1_n_0\,
      D => bram_din(10),
      Q => usr_bess_kp(10),
      R => '0'
    );
\usr_bess_kp_reg[11]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_bess_kp[31]_i_1_n_0\,
      D => bram_din(11),
      Q => usr_bess_kp(11),
      R => '0'
    );
\usr_bess_kp_reg[12]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_bess_kp[31]_i_1_n_0\,
      D => bram_din(12),
      Q => usr_bess_kp(12),
      R => '0'
    );
\usr_bess_kp_reg[13]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_bess_kp[31]_i_1_n_0\,
      D => bram_din(13),
      Q => usr_bess_kp(13),
      R => '0'
    );
\usr_bess_kp_reg[14]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_bess_kp[31]_i_1_n_0\,
      D => bram_din(14),
      Q => usr_bess_kp(14),
      R => '0'
    );
\usr_bess_kp_reg[15]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_bess_kp[31]_i_1_n_0\,
      D => bram_din(15),
      Q => usr_bess_kp(15),
      R => '0'
    );
\usr_bess_kp_reg[16]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_bess_kp[31]_i_1_n_0\,
      D => bram_din(16),
      Q => usr_bess_kp(16),
      R => '0'
    );
\usr_bess_kp_reg[17]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_bess_kp[31]_i_1_n_0\,
      D => bram_din(17),
      Q => usr_bess_kp(17),
      R => '0'
    );
\usr_bess_kp_reg[18]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_bess_kp[31]_i_1_n_0\,
      D => bram_din(18),
      Q => usr_bess_kp(18),
      R => '0'
    );
\usr_bess_kp_reg[19]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_bess_kp[31]_i_1_n_0\,
      D => bram_din(19),
      Q => usr_bess_kp(19),
      R => '0'
    );
\usr_bess_kp_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_bess_kp[31]_i_1_n_0\,
      D => bram_din(1),
      Q => usr_bess_kp(1),
      R => '0'
    );
\usr_bess_kp_reg[20]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_bess_kp[31]_i_1_n_0\,
      D => bram_din(20),
      Q => usr_bess_kp(20),
      R => '0'
    );
\usr_bess_kp_reg[21]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_bess_kp[31]_i_1_n_0\,
      D => bram_din(21),
      Q => usr_bess_kp(21),
      R => '0'
    );
\usr_bess_kp_reg[22]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_bess_kp[31]_i_1_n_0\,
      D => bram_din(22),
      Q => usr_bess_kp(22),
      R => '0'
    );
\usr_bess_kp_reg[23]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_bess_kp[31]_i_1_n_0\,
      D => bram_din(23),
      Q => usr_bess_kp(23),
      R => '0'
    );
\usr_bess_kp_reg[24]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_bess_kp[31]_i_1_n_0\,
      D => bram_din(24),
      Q => usr_bess_kp(24),
      R => '0'
    );
\usr_bess_kp_reg[25]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_bess_kp[31]_i_1_n_0\,
      D => bram_din(25),
      Q => usr_bess_kp(25),
      R => '0'
    );
\usr_bess_kp_reg[26]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_bess_kp[31]_i_1_n_0\,
      D => bram_din(26),
      Q => usr_bess_kp(26),
      R => '0'
    );
\usr_bess_kp_reg[27]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_bess_kp[31]_i_1_n_0\,
      D => bram_din(27),
      Q => usr_bess_kp(27),
      R => '0'
    );
\usr_bess_kp_reg[28]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_bess_kp[31]_i_1_n_0\,
      D => bram_din(28),
      Q => usr_bess_kp(28),
      R => '0'
    );
\usr_bess_kp_reg[29]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_bess_kp[31]_i_1_n_0\,
      D => bram_din(29),
      Q => usr_bess_kp(29),
      R => '0'
    );
\usr_bess_kp_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_bess_kp[31]_i_1_n_0\,
      D => bram_din(2),
      Q => usr_bess_kp(2),
      R => '0'
    );
\usr_bess_kp_reg[30]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_bess_kp[31]_i_1_n_0\,
      D => bram_din(30),
      Q => usr_bess_kp(30),
      R => '0'
    );
\usr_bess_kp_reg[31]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_bess_kp[31]_i_1_n_0\,
      D => bram_din(31),
      Q => usr_bess_kp(31),
      R => '0'
    );
\usr_bess_kp_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_bess_kp[31]_i_1_n_0\,
      D => bram_din(3),
      Q => usr_bess_kp(3),
      R => '0'
    );
\usr_bess_kp_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_bess_kp[31]_i_1_n_0\,
      D => bram_din(4),
      Q => usr_bess_kp(4),
      R => '0'
    );
\usr_bess_kp_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_bess_kp[31]_i_1_n_0\,
      D => bram_din(5),
      Q => usr_bess_kp(5),
      R => '0'
    );
\usr_bess_kp_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_bess_kp[31]_i_1_n_0\,
      D => bram_din(6),
      Q => usr_bess_kp(6),
      R => '0'
    );
\usr_bess_kp_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_bess_kp[31]_i_1_n_0\,
      D => bram_din(7),
      Q => usr_bess_kp(7),
      R => '0'
    );
\usr_bess_kp_reg[8]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_bess_kp[31]_i_1_n_0\,
      D => bram_din(8),
      Q => usr_bess_kp(8),
      R => '0'
    );
\usr_bess_kp_reg[9]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_bess_kp[31]_i_1_n_0\,
      D => bram_din(9),
      Q => usr_bess_kp(9),
      R => '0'
    );
\usr_bess_maxsoc[31]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"1000000000000000"
    )
        port map (
      I0 => state_usrparam_r(1),
      I1 => state_usrparam_r(4),
      I2 => state_usrparam_r(3),
      I3 => arst_n,
      I4 => state_usrparam_r(2),
      I5 => state_usrparam_r(0),
      O => \usr_bess_maxsoc[31]_i_1_n_0\
    );
\usr_bess_maxsoc_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_bess_maxsoc[31]_i_1_n_0\,
      D => bram_din(0),
      Q => usr_bess_maxsoc(0),
      R => '0'
    );
\usr_bess_maxsoc_reg[10]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_bess_maxsoc[31]_i_1_n_0\,
      D => bram_din(10),
      Q => usr_bess_maxsoc(10),
      R => '0'
    );
\usr_bess_maxsoc_reg[11]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_bess_maxsoc[31]_i_1_n_0\,
      D => bram_din(11),
      Q => usr_bess_maxsoc(11),
      R => '0'
    );
\usr_bess_maxsoc_reg[12]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_bess_maxsoc[31]_i_1_n_0\,
      D => bram_din(12),
      Q => usr_bess_maxsoc(12),
      R => '0'
    );
\usr_bess_maxsoc_reg[13]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_bess_maxsoc[31]_i_1_n_0\,
      D => bram_din(13),
      Q => usr_bess_maxsoc(13),
      R => '0'
    );
\usr_bess_maxsoc_reg[14]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_bess_maxsoc[31]_i_1_n_0\,
      D => bram_din(14),
      Q => usr_bess_maxsoc(14),
      R => '0'
    );
\usr_bess_maxsoc_reg[15]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_bess_maxsoc[31]_i_1_n_0\,
      D => bram_din(15),
      Q => usr_bess_maxsoc(15),
      R => '0'
    );
\usr_bess_maxsoc_reg[16]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_bess_maxsoc[31]_i_1_n_0\,
      D => bram_din(16),
      Q => usr_bess_maxsoc(16),
      R => '0'
    );
\usr_bess_maxsoc_reg[17]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_bess_maxsoc[31]_i_1_n_0\,
      D => bram_din(17),
      Q => usr_bess_maxsoc(17),
      R => '0'
    );
\usr_bess_maxsoc_reg[18]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_bess_maxsoc[31]_i_1_n_0\,
      D => bram_din(18),
      Q => usr_bess_maxsoc(18),
      R => '0'
    );
\usr_bess_maxsoc_reg[19]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_bess_maxsoc[31]_i_1_n_0\,
      D => bram_din(19),
      Q => usr_bess_maxsoc(19),
      R => '0'
    );
\usr_bess_maxsoc_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_bess_maxsoc[31]_i_1_n_0\,
      D => bram_din(1),
      Q => usr_bess_maxsoc(1),
      R => '0'
    );
\usr_bess_maxsoc_reg[20]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_bess_maxsoc[31]_i_1_n_0\,
      D => bram_din(20),
      Q => usr_bess_maxsoc(20),
      R => '0'
    );
\usr_bess_maxsoc_reg[21]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_bess_maxsoc[31]_i_1_n_0\,
      D => bram_din(21),
      Q => usr_bess_maxsoc(21),
      R => '0'
    );
\usr_bess_maxsoc_reg[22]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_bess_maxsoc[31]_i_1_n_0\,
      D => bram_din(22),
      Q => usr_bess_maxsoc(22),
      R => '0'
    );
\usr_bess_maxsoc_reg[23]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_bess_maxsoc[31]_i_1_n_0\,
      D => bram_din(23),
      Q => usr_bess_maxsoc(23),
      R => '0'
    );
\usr_bess_maxsoc_reg[24]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_bess_maxsoc[31]_i_1_n_0\,
      D => bram_din(24),
      Q => usr_bess_maxsoc(24),
      R => '0'
    );
\usr_bess_maxsoc_reg[25]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_bess_maxsoc[31]_i_1_n_0\,
      D => bram_din(25),
      Q => usr_bess_maxsoc(25),
      R => '0'
    );
\usr_bess_maxsoc_reg[26]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_bess_maxsoc[31]_i_1_n_0\,
      D => bram_din(26),
      Q => usr_bess_maxsoc(26),
      R => '0'
    );
\usr_bess_maxsoc_reg[27]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_bess_maxsoc[31]_i_1_n_0\,
      D => bram_din(27),
      Q => usr_bess_maxsoc(27),
      R => '0'
    );
\usr_bess_maxsoc_reg[28]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_bess_maxsoc[31]_i_1_n_0\,
      D => bram_din(28),
      Q => usr_bess_maxsoc(28),
      R => '0'
    );
\usr_bess_maxsoc_reg[29]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_bess_maxsoc[31]_i_1_n_0\,
      D => bram_din(29),
      Q => usr_bess_maxsoc(29),
      R => '0'
    );
\usr_bess_maxsoc_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_bess_maxsoc[31]_i_1_n_0\,
      D => bram_din(2),
      Q => usr_bess_maxsoc(2),
      R => '0'
    );
\usr_bess_maxsoc_reg[30]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_bess_maxsoc[31]_i_1_n_0\,
      D => bram_din(30),
      Q => usr_bess_maxsoc(30),
      R => '0'
    );
\usr_bess_maxsoc_reg[31]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_bess_maxsoc[31]_i_1_n_0\,
      D => bram_din(31),
      Q => usr_bess_maxsoc(31),
      R => '0'
    );
\usr_bess_maxsoc_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_bess_maxsoc[31]_i_1_n_0\,
      D => bram_din(3),
      Q => usr_bess_maxsoc(3),
      R => '0'
    );
\usr_bess_maxsoc_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_bess_maxsoc[31]_i_1_n_0\,
      D => bram_din(4),
      Q => usr_bess_maxsoc(4),
      R => '0'
    );
\usr_bess_maxsoc_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_bess_maxsoc[31]_i_1_n_0\,
      D => bram_din(5),
      Q => usr_bess_maxsoc(5),
      R => '0'
    );
\usr_bess_maxsoc_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_bess_maxsoc[31]_i_1_n_0\,
      D => bram_din(6),
      Q => usr_bess_maxsoc(6),
      R => '0'
    );
\usr_bess_maxsoc_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_bess_maxsoc[31]_i_1_n_0\,
      D => bram_din(7),
      Q => usr_bess_maxsoc(7),
      R => '0'
    );
\usr_bess_maxsoc_reg[8]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_bess_maxsoc[31]_i_1_n_0\,
      D => bram_din(8),
      Q => usr_bess_maxsoc(8),
      R => '0'
    );
\usr_bess_maxsoc_reg[9]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_bess_maxsoc[31]_i_1_n_0\,
      D => bram_din(9),
      Q => usr_bess_maxsoc(9),
      R => '0'
    );
\usr_bess_minsoc[31]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000200000000000"
    )
        port map (
      I0 => state_usrparam_r(1),
      I1 => state_usrparam_r(4),
      I2 => state_usrparam_r(3),
      I3 => arst_n,
      I4 => state_usrparam_r(0),
      I5 => state_usrparam_r(2),
      O => \usr_bess_minsoc[31]_i_1_n_0\
    );
\usr_bess_minsoc_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_bess_minsoc[31]_i_1_n_0\,
      D => bram_din(0),
      Q => usr_bess_minsoc(0),
      R => '0'
    );
\usr_bess_minsoc_reg[10]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_bess_minsoc[31]_i_1_n_0\,
      D => bram_din(10),
      Q => usr_bess_minsoc(10),
      R => '0'
    );
\usr_bess_minsoc_reg[11]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_bess_minsoc[31]_i_1_n_0\,
      D => bram_din(11),
      Q => usr_bess_minsoc(11),
      R => '0'
    );
\usr_bess_minsoc_reg[12]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_bess_minsoc[31]_i_1_n_0\,
      D => bram_din(12),
      Q => usr_bess_minsoc(12),
      R => '0'
    );
\usr_bess_minsoc_reg[13]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_bess_minsoc[31]_i_1_n_0\,
      D => bram_din(13),
      Q => usr_bess_minsoc(13),
      R => '0'
    );
\usr_bess_minsoc_reg[14]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_bess_minsoc[31]_i_1_n_0\,
      D => bram_din(14),
      Q => usr_bess_minsoc(14),
      R => '0'
    );
\usr_bess_minsoc_reg[15]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_bess_minsoc[31]_i_1_n_0\,
      D => bram_din(15),
      Q => usr_bess_minsoc(15),
      R => '0'
    );
\usr_bess_minsoc_reg[16]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_bess_minsoc[31]_i_1_n_0\,
      D => bram_din(16),
      Q => usr_bess_minsoc(16),
      R => '0'
    );
\usr_bess_minsoc_reg[17]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_bess_minsoc[31]_i_1_n_0\,
      D => bram_din(17),
      Q => usr_bess_minsoc(17),
      R => '0'
    );
\usr_bess_minsoc_reg[18]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_bess_minsoc[31]_i_1_n_0\,
      D => bram_din(18),
      Q => usr_bess_minsoc(18),
      R => '0'
    );
\usr_bess_minsoc_reg[19]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_bess_minsoc[31]_i_1_n_0\,
      D => bram_din(19),
      Q => usr_bess_minsoc(19),
      R => '0'
    );
\usr_bess_minsoc_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_bess_minsoc[31]_i_1_n_0\,
      D => bram_din(1),
      Q => usr_bess_minsoc(1),
      R => '0'
    );
\usr_bess_minsoc_reg[20]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_bess_minsoc[31]_i_1_n_0\,
      D => bram_din(20),
      Q => usr_bess_minsoc(20),
      R => '0'
    );
\usr_bess_minsoc_reg[21]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_bess_minsoc[31]_i_1_n_0\,
      D => bram_din(21),
      Q => usr_bess_minsoc(21),
      R => '0'
    );
\usr_bess_minsoc_reg[22]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_bess_minsoc[31]_i_1_n_0\,
      D => bram_din(22),
      Q => usr_bess_minsoc(22),
      R => '0'
    );
\usr_bess_minsoc_reg[23]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_bess_minsoc[31]_i_1_n_0\,
      D => bram_din(23),
      Q => usr_bess_minsoc(23),
      R => '0'
    );
\usr_bess_minsoc_reg[24]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_bess_minsoc[31]_i_1_n_0\,
      D => bram_din(24),
      Q => usr_bess_minsoc(24),
      R => '0'
    );
\usr_bess_minsoc_reg[25]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_bess_minsoc[31]_i_1_n_0\,
      D => bram_din(25),
      Q => usr_bess_minsoc(25),
      R => '0'
    );
\usr_bess_minsoc_reg[26]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_bess_minsoc[31]_i_1_n_0\,
      D => bram_din(26),
      Q => usr_bess_minsoc(26),
      R => '0'
    );
\usr_bess_minsoc_reg[27]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_bess_minsoc[31]_i_1_n_0\,
      D => bram_din(27),
      Q => usr_bess_minsoc(27),
      R => '0'
    );
\usr_bess_minsoc_reg[28]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_bess_minsoc[31]_i_1_n_0\,
      D => bram_din(28),
      Q => usr_bess_minsoc(28),
      R => '0'
    );
\usr_bess_minsoc_reg[29]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_bess_minsoc[31]_i_1_n_0\,
      D => bram_din(29),
      Q => usr_bess_minsoc(29),
      R => '0'
    );
\usr_bess_minsoc_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_bess_minsoc[31]_i_1_n_0\,
      D => bram_din(2),
      Q => usr_bess_minsoc(2),
      R => '0'
    );
\usr_bess_minsoc_reg[30]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_bess_minsoc[31]_i_1_n_0\,
      D => bram_din(30),
      Q => usr_bess_minsoc(30),
      R => '0'
    );
\usr_bess_minsoc_reg[31]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_bess_minsoc[31]_i_1_n_0\,
      D => bram_din(31),
      Q => usr_bess_minsoc(31),
      R => '0'
    );
\usr_bess_minsoc_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_bess_minsoc[31]_i_1_n_0\,
      D => bram_din(3),
      Q => usr_bess_minsoc(3),
      R => '0'
    );
\usr_bess_minsoc_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_bess_minsoc[31]_i_1_n_0\,
      D => bram_din(4),
      Q => usr_bess_minsoc(4),
      R => '0'
    );
\usr_bess_minsoc_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_bess_minsoc[31]_i_1_n_0\,
      D => bram_din(5),
      Q => usr_bess_minsoc(5),
      R => '0'
    );
\usr_bess_minsoc_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_bess_minsoc[31]_i_1_n_0\,
      D => bram_din(6),
      Q => usr_bess_minsoc(6),
      R => '0'
    );
\usr_bess_minsoc_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_bess_minsoc[31]_i_1_n_0\,
      D => bram_din(7),
      Q => usr_bess_minsoc(7),
      R => '0'
    );
\usr_bess_minsoc_reg[8]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_bess_minsoc[31]_i_1_n_0\,
      D => bram_din(8),
      Q => usr_bess_minsoc(8),
      R => '0'
    );
\usr_bess_minsoc_reg[9]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_bess_minsoc[31]_i_1_n_0\,
      D => bram_din(9),
      Q => usr_bess_minsoc(9),
      R => '0'
    );
\usr_besschrg_lmt[31]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0010000000000000"
    )
        port map (
      I0 => state_usrparam_r(1),
      I1 => state_usrparam_r(4),
      I2 => arst_n,
      I3 => state_usrparam_r(3),
      I4 => state_usrparam_r(2),
      I5 => state_usrparam_r(0),
      O => \usr_besschrg_lmt[31]_i_1_n_0\
    );
\usr_besschrg_lmt_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_besschrg_lmt[31]_i_1_n_0\,
      D => bram_din(0),
      Q => usr_besschrg_lmt(0),
      R => '0'
    );
\usr_besschrg_lmt_reg[10]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_besschrg_lmt[31]_i_1_n_0\,
      D => bram_din(10),
      Q => usr_besschrg_lmt(10),
      R => '0'
    );
\usr_besschrg_lmt_reg[11]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_besschrg_lmt[31]_i_1_n_0\,
      D => bram_din(11),
      Q => usr_besschrg_lmt(11),
      R => '0'
    );
\usr_besschrg_lmt_reg[12]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_besschrg_lmt[31]_i_1_n_0\,
      D => bram_din(12),
      Q => usr_besschrg_lmt(12),
      R => '0'
    );
\usr_besschrg_lmt_reg[13]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_besschrg_lmt[31]_i_1_n_0\,
      D => bram_din(13),
      Q => usr_besschrg_lmt(13),
      R => '0'
    );
\usr_besschrg_lmt_reg[14]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_besschrg_lmt[31]_i_1_n_0\,
      D => bram_din(14),
      Q => usr_besschrg_lmt(14),
      R => '0'
    );
\usr_besschrg_lmt_reg[15]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_besschrg_lmt[31]_i_1_n_0\,
      D => bram_din(15),
      Q => usr_besschrg_lmt(15),
      R => '0'
    );
\usr_besschrg_lmt_reg[16]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_besschrg_lmt[31]_i_1_n_0\,
      D => bram_din(16),
      Q => usr_besschrg_lmt(16),
      R => '0'
    );
\usr_besschrg_lmt_reg[17]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_besschrg_lmt[31]_i_1_n_0\,
      D => bram_din(17),
      Q => usr_besschrg_lmt(17),
      R => '0'
    );
\usr_besschrg_lmt_reg[18]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_besschrg_lmt[31]_i_1_n_0\,
      D => bram_din(18),
      Q => usr_besschrg_lmt(18),
      R => '0'
    );
\usr_besschrg_lmt_reg[19]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_besschrg_lmt[31]_i_1_n_0\,
      D => bram_din(19),
      Q => usr_besschrg_lmt(19),
      R => '0'
    );
\usr_besschrg_lmt_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_besschrg_lmt[31]_i_1_n_0\,
      D => bram_din(1),
      Q => usr_besschrg_lmt(1),
      R => '0'
    );
\usr_besschrg_lmt_reg[20]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_besschrg_lmt[31]_i_1_n_0\,
      D => bram_din(20),
      Q => usr_besschrg_lmt(20),
      R => '0'
    );
\usr_besschrg_lmt_reg[21]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_besschrg_lmt[31]_i_1_n_0\,
      D => bram_din(21),
      Q => usr_besschrg_lmt(21),
      R => '0'
    );
\usr_besschrg_lmt_reg[22]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_besschrg_lmt[31]_i_1_n_0\,
      D => bram_din(22),
      Q => usr_besschrg_lmt(22),
      R => '0'
    );
\usr_besschrg_lmt_reg[23]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_besschrg_lmt[31]_i_1_n_0\,
      D => bram_din(23),
      Q => usr_besschrg_lmt(23),
      R => '0'
    );
\usr_besschrg_lmt_reg[24]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_besschrg_lmt[31]_i_1_n_0\,
      D => bram_din(24),
      Q => usr_besschrg_lmt(24),
      R => '0'
    );
\usr_besschrg_lmt_reg[25]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_besschrg_lmt[31]_i_1_n_0\,
      D => bram_din(25),
      Q => usr_besschrg_lmt(25),
      R => '0'
    );
\usr_besschrg_lmt_reg[26]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_besschrg_lmt[31]_i_1_n_0\,
      D => bram_din(26),
      Q => usr_besschrg_lmt(26),
      R => '0'
    );
\usr_besschrg_lmt_reg[27]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_besschrg_lmt[31]_i_1_n_0\,
      D => bram_din(27),
      Q => usr_besschrg_lmt(27),
      R => '0'
    );
\usr_besschrg_lmt_reg[28]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_besschrg_lmt[31]_i_1_n_0\,
      D => bram_din(28),
      Q => usr_besschrg_lmt(28),
      R => '0'
    );
\usr_besschrg_lmt_reg[29]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_besschrg_lmt[31]_i_1_n_0\,
      D => bram_din(29),
      Q => usr_besschrg_lmt(29),
      R => '0'
    );
\usr_besschrg_lmt_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_besschrg_lmt[31]_i_1_n_0\,
      D => bram_din(2),
      Q => usr_besschrg_lmt(2),
      R => '0'
    );
\usr_besschrg_lmt_reg[30]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_besschrg_lmt[31]_i_1_n_0\,
      D => bram_din(30),
      Q => usr_besschrg_lmt(30),
      R => '0'
    );
\usr_besschrg_lmt_reg[31]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_besschrg_lmt[31]_i_1_n_0\,
      D => bram_din(31),
      Q => usr_besschrg_lmt(31),
      R => '0'
    );
\usr_besschrg_lmt_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_besschrg_lmt[31]_i_1_n_0\,
      D => bram_din(3),
      Q => usr_besschrg_lmt(3),
      R => '0'
    );
\usr_besschrg_lmt_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_besschrg_lmt[31]_i_1_n_0\,
      D => bram_din(4),
      Q => usr_besschrg_lmt(4),
      R => '0'
    );
\usr_besschrg_lmt_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_besschrg_lmt[31]_i_1_n_0\,
      D => bram_din(5),
      Q => usr_besschrg_lmt(5),
      R => '0'
    );
\usr_besschrg_lmt_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_besschrg_lmt[31]_i_1_n_0\,
      D => bram_din(6),
      Q => usr_besschrg_lmt(6),
      R => '0'
    );
\usr_besschrg_lmt_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_besschrg_lmt[31]_i_1_n_0\,
      D => bram_din(7),
      Q => usr_besschrg_lmt(7),
      R => '0'
    );
\usr_besschrg_lmt_reg[8]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_besschrg_lmt[31]_i_1_n_0\,
      D => bram_din(8),
      Q => usr_besschrg_lmt(8),
      R => '0'
    );
\usr_besschrg_lmt_reg[9]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_besschrg_lmt[31]_i_1_n_0\,
      D => bram_din(9),
      Q => usr_besschrg_lmt(9),
      R => '0'
    );
\usr_bessdsch_lmt[31]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000002000000000"
    )
        port map (
      I0 => state_usrparam_r(1),
      I1 => state_usrparam_r(4),
      I2 => state_usrparam_r(2),
      I3 => state_usrparam_r(0),
      I4 => state_usrparam_r(3),
      I5 => arst_n,
      O => \usr_bessdsch_lmt[31]_i_1_n_0\
    );
\usr_bessdsch_lmt_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_bessdsch_lmt[31]_i_1_n_0\,
      D => bram_din(0),
      Q => usr_bessdsch_lmt(0),
      R => '0'
    );
\usr_bessdsch_lmt_reg[10]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_bessdsch_lmt[31]_i_1_n_0\,
      D => bram_din(10),
      Q => usr_bessdsch_lmt(10),
      R => '0'
    );
\usr_bessdsch_lmt_reg[11]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_bessdsch_lmt[31]_i_1_n_0\,
      D => bram_din(11),
      Q => usr_bessdsch_lmt(11),
      R => '0'
    );
\usr_bessdsch_lmt_reg[12]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_bessdsch_lmt[31]_i_1_n_0\,
      D => bram_din(12),
      Q => usr_bessdsch_lmt(12),
      R => '0'
    );
\usr_bessdsch_lmt_reg[13]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_bessdsch_lmt[31]_i_1_n_0\,
      D => bram_din(13),
      Q => usr_bessdsch_lmt(13),
      R => '0'
    );
\usr_bessdsch_lmt_reg[14]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_bessdsch_lmt[31]_i_1_n_0\,
      D => bram_din(14),
      Q => usr_bessdsch_lmt(14),
      R => '0'
    );
\usr_bessdsch_lmt_reg[15]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_bessdsch_lmt[31]_i_1_n_0\,
      D => bram_din(15),
      Q => usr_bessdsch_lmt(15),
      R => '0'
    );
\usr_bessdsch_lmt_reg[16]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_bessdsch_lmt[31]_i_1_n_0\,
      D => bram_din(16),
      Q => usr_bessdsch_lmt(16),
      R => '0'
    );
\usr_bessdsch_lmt_reg[17]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_bessdsch_lmt[31]_i_1_n_0\,
      D => bram_din(17),
      Q => usr_bessdsch_lmt(17),
      R => '0'
    );
\usr_bessdsch_lmt_reg[18]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_bessdsch_lmt[31]_i_1_n_0\,
      D => bram_din(18),
      Q => usr_bessdsch_lmt(18),
      R => '0'
    );
\usr_bessdsch_lmt_reg[19]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_bessdsch_lmt[31]_i_1_n_0\,
      D => bram_din(19),
      Q => usr_bessdsch_lmt(19),
      R => '0'
    );
\usr_bessdsch_lmt_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_bessdsch_lmt[31]_i_1_n_0\,
      D => bram_din(1),
      Q => usr_bessdsch_lmt(1),
      R => '0'
    );
\usr_bessdsch_lmt_reg[20]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_bessdsch_lmt[31]_i_1_n_0\,
      D => bram_din(20),
      Q => usr_bessdsch_lmt(20),
      R => '0'
    );
\usr_bessdsch_lmt_reg[21]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_bessdsch_lmt[31]_i_1_n_0\,
      D => bram_din(21),
      Q => usr_bessdsch_lmt(21),
      R => '0'
    );
\usr_bessdsch_lmt_reg[22]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_bessdsch_lmt[31]_i_1_n_0\,
      D => bram_din(22),
      Q => usr_bessdsch_lmt(22),
      R => '0'
    );
\usr_bessdsch_lmt_reg[23]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_bessdsch_lmt[31]_i_1_n_0\,
      D => bram_din(23),
      Q => usr_bessdsch_lmt(23),
      R => '0'
    );
\usr_bessdsch_lmt_reg[24]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_bessdsch_lmt[31]_i_1_n_0\,
      D => bram_din(24),
      Q => usr_bessdsch_lmt(24),
      R => '0'
    );
\usr_bessdsch_lmt_reg[25]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_bessdsch_lmt[31]_i_1_n_0\,
      D => bram_din(25),
      Q => usr_bessdsch_lmt(25),
      R => '0'
    );
\usr_bessdsch_lmt_reg[26]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_bessdsch_lmt[31]_i_1_n_0\,
      D => bram_din(26),
      Q => usr_bessdsch_lmt(26),
      R => '0'
    );
\usr_bessdsch_lmt_reg[27]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_bessdsch_lmt[31]_i_1_n_0\,
      D => bram_din(27),
      Q => usr_bessdsch_lmt(27),
      R => '0'
    );
\usr_bessdsch_lmt_reg[28]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_bessdsch_lmt[31]_i_1_n_0\,
      D => bram_din(28),
      Q => usr_bessdsch_lmt(28),
      R => '0'
    );
\usr_bessdsch_lmt_reg[29]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_bessdsch_lmt[31]_i_1_n_0\,
      D => bram_din(29),
      Q => usr_bessdsch_lmt(29),
      R => '0'
    );
\usr_bessdsch_lmt_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_bessdsch_lmt[31]_i_1_n_0\,
      D => bram_din(2),
      Q => usr_bessdsch_lmt(2),
      R => '0'
    );
\usr_bessdsch_lmt_reg[30]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_bessdsch_lmt[31]_i_1_n_0\,
      D => bram_din(30),
      Q => usr_bessdsch_lmt(30),
      R => '0'
    );
\usr_bessdsch_lmt_reg[31]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_bessdsch_lmt[31]_i_1_n_0\,
      D => bram_din(31),
      Q => usr_bessdsch_lmt(31),
      R => '0'
    );
\usr_bessdsch_lmt_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_bessdsch_lmt[31]_i_1_n_0\,
      D => bram_din(3),
      Q => usr_bessdsch_lmt(3),
      R => '0'
    );
\usr_bessdsch_lmt_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_bessdsch_lmt[31]_i_1_n_0\,
      D => bram_din(4),
      Q => usr_bessdsch_lmt(4),
      R => '0'
    );
\usr_bessdsch_lmt_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_bessdsch_lmt[31]_i_1_n_0\,
      D => bram_din(5),
      Q => usr_bessdsch_lmt(5),
      R => '0'
    );
\usr_bessdsch_lmt_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_bessdsch_lmt[31]_i_1_n_0\,
      D => bram_din(6),
      Q => usr_bessdsch_lmt(6),
      R => '0'
    );
\usr_bessdsch_lmt_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_bessdsch_lmt[31]_i_1_n_0\,
      D => bram_din(7),
      Q => usr_bessdsch_lmt(7),
      R => '0'
    );
\usr_bessdsch_lmt_reg[8]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_bessdsch_lmt[31]_i_1_n_0\,
      D => bram_din(8),
      Q => usr_bessdsch_lmt(8),
      R => '0'
    );
\usr_bessdsch_lmt_reg[9]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_bessdsch_lmt[31]_i_1_n_0\,
      D => bram_din(9),
      Q => usr_bessdsch_lmt(9),
      R => '0'
    );
\usr_cmd_reg[0]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000000000040"
    )
        port map (
      I0 => state_usrparam_r(1),
      I1 => state_usrparam_r(4),
      I2 => arst_n,
      I3 => state_usrparam_r(0),
      I4 => state_usrparam_r(2),
      I5 => state_usrparam_r(3),
      O => \usr_cmd_reg[0]_i_1_n_0\
    );
\usr_cmd_reg_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_cmd_reg[0]_i_1_n_0\,
      D => bram_din(0),
      Q => Q(0),
      R => '0'
    );
\usr_cmd_reg_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_cmd_reg[0]_i_1_n_0\,
      D => bram_din(1),
      Q => Q(1),
      R => '0'
    );
\usr_cmd_reg_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_cmd_reg[0]_i_1_n_0\,
      D => bram_din(2),
      Q => Q(2),
      R => '0'
    );
\usr_exp_lmt[31]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000001000000000"
    )
        port map (
      I0 => state_usrparam_r(1),
      I1 => state_usrparam_r(4),
      I2 => state_usrparam_r(2),
      I3 => state_usrparam_r(0),
      I4 => state_usrparam_r(3),
      I5 => arst_n,
      O => \usr_exp_lmt[31]_i_1_n_0\
    );
\usr_exp_lmt_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_exp_lmt[31]_i_1_n_0\,
      D => bram_din(0),
      Q => usr_exp_lmt(0),
      R => '0'
    );
\usr_exp_lmt_reg[10]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_exp_lmt[31]_i_1_n_0\,
      D => bram_din(10),
      Q => usr_exp_lmt(10),
      R => '0'
    );
\usr_exp_lmt_reg[11]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_exp_lmt[31]_i_1_n_0\,
      D => bram_din(11),
      Q => usr_exp_lmt(11),
      R => '0'
    );
\usr_exp_lmt_reg[12]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_exp_lmt[31]_i_1_n_0\,
      D => bram_din(12),
      Q => usr_exp_lmt(12),
      R => '0'
    );
\usr_exp_lmt_reg[13]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_exp_lmt[31]_i_1_n_0\,
      D => bram_din(13),
      Q => usr_exp_lmt(13),
      R => '0'
    );
\usr_exp_lmt_reg[14]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_exp_lmt[31]_i_1_n_0\,
      D => bram_din(14),
      Q => usr_exp_lmt(14),
      R => '0'
    );
\usr_exp_lmt_reg[15]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_exp_lmt[31]_i_1_n_0\,
      D => bram_din(15),
      Q => usr_exp_lmt(15),
      R => '0'
    );
\usr_exp_lmt_reg[16]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_exp_lmt[31]_i_1_n_0\,
      D => bram_din(16),
      Q => usr_exp_lmt(16),
      R => '0'
    );
\usr_exp_lmt_reg[17]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_exp_lmt[31]_i_1_n_0\,
      D => bram_din(17),
      Q => usr_exp_lmt(17),
      R => '0'
    );
\usr_exp_lmt_reg[18]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_exp_lmt[31]_i_1_n_0\,
      D => bram_din(18),
      Q => usr_exp_lmt(18),
      R => '0'
    );
\usr_exp_lmt_reg[19]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_exp_lmt[31]_i_1_n_0\,
      D => bram_din(19),
      Q => usr_exp_lmt(19),
      R => '0'
    );
\usr_exp_lmt_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_exp_lmt[31]_i_1_n_0\,
      D => bram_din(1),
      Q => usr_exp_lmt(1),
      R => '0'
    );
\usr_exp_lmt_reg[20]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_exp_lmt[31]_i_1_n_0\,
      D => bram_din(20),
      Q => usr_exp_lmt(20),
      R => '0'
    );
\usr_exp_lmt_reg[21]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_exp_lmt[31]_i_1_n_0\,
      D => bram_din(21),
      Q => usr_exp_lmt(21),
      R => '0'
    );
\usr_exp_lmt_reg[22]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_exp_lmt[31]_i_1_n_0\,
      D => bram_din(22),
      Q => usr_exp_lmt(22),
      R => '0'
    );
\usr_exp_lmt_reg[23]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_exp_lmt[31]_i_1_n_0\,
      D => bram_din(23),
      Q => usr_exp_lmt(23),
      R => '0'
    );
\usr_exp_lmt_reg[24]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_exp_lmt[31]_i_1_n_0\,
      D => bram_din(24),
      Q => usr_exp_lmt(24),
      R => '0'
    );
\usr_exp_lmt_reg[25]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_exp_lmt[31]_i_1_n_0\,
      D => bram_din(25),
      Q => usr_exp_lmt(25),
      R => '0'
    );
\usr_exp_lmt_reg[26]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_exp_lmt[31]_i_1_n_0\,
      D => bram_din(26),
      Q => usr_exp_lmt(26),
      R => '0'
    );
\usr_exp_lmt_reg[27]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_exp_lmt[31]_i_1_n_0\,
      D => bram_din(27),
      Q => usr_exp_lmt(27),
      R => '0'
    );
\usr_exp_lmt_reg[28]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_exp_lmt[31]_i_1_n_0\,
      D => bram_din(28),
      Q => usr_exp_lmt(28),
      R => '0'
    );
\usr_exp_lmt_reg[29]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_exp_lmt[31]_i_1_n_0\,
      D => bram_din(29),
      Q => usr_exp_lmt(29),
      R => '0'
    );
\usr_exp_lmt_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_exp_lmt[31]_i_1_n_0\,
      D => bram_din(2),
      Q => usr_exp_lmt(2),
      R => '0'
    );
\usr_exp_lmt_reg[30]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_exp_lmt[31]_i_1_n_0\,
      D => bram_din(30),
      Q => usr_exp_lmt(30),
      R => '0'
    );
\usr_exp_lmt_reg[31]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_exp_lmt[31]_i_1_n_0\,
      D => bram_din(31),
      Q => usr_exp_lmt(31),
      R => '0'
    );
\usr_exp_lmt_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_exp_lmt[31]_i_1_n_0\,
      D => bram_din(3),
      Q => usr_exp_lmt(3),
      R => '0'
    );
\usr_exp_lmt_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_exp_lmt[31]_i_1_n_0\,
      D => bram_din(4),
      Q => usr_exp_lmt(4),
      R => '0'
    );
\usr_exp_lmt_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_exp_lmt[31]_i_1_n_0\,
      D => bram_din(5),
      Q => usr_exp_lmt(5),
      R => '0'
    );
\usr_exp_lmt_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_exp_lmt[31]_i_1_n_0\,
      D => bram_din(6),
      Q => usr_exp_lmt(6),
      R => '0'
    );
\usr_exp_lmt_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_exp_lmt[31]_i_1_n_0\,
      D => bram_din(7),
      Q => usr_exp_lmt(7),
      R => '0'
    );
\usr_exp_lmt_reg[8]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_exp_lmt[31]_i_1_n_0\,
      D => bram_din(8),
      Q => usr_exp_lmt(8),
      R => '0'
    );
\usr_exp_lmt_reg[9]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_exp_lmt[31]_i_1_n_0\,
      D => bram_din(9),
      Q => usr_exp_lmt(9),
      R => '0'
    );
\usr_imp_lmt[31]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000000002000"
    )
        port map (
      I0 => state_usrparam_r(1),
      I1 => state_usrparam_r(4),
      I2 => state_usrparam_r(0),
      I3 => arst_n,
      I4 => state_usrparam_r(3),
      I5 => state_usrparam_r(2),
      O => \usr_imp_lmt[31]_i_1_n_0\
    );
\usr_imp_lmt_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_imp_lmt[31]_i_1_n_0\,
      D => bram_din(0),
      Q => usr_imp_lmt(0),
      R => '0'
    );
\usr_imp_lmt_reg[10]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_imp_lmt[31]_i_1_n_0\,
      D => bram_din(10),
      Q => usr_imp_lmt(10),
      R => '0'
    );
\usr_imp_lmt_reg[11]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_imp_lmt[31]_i_1_n_0\,
      D => bram_din(11),
      Q => usr_imp_lmt(11),
      R => '0'
    );
\usr_imp_lmt_reg[12]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_imp_lmt[31]_i_1_n_0\,
      D => bram_din(12),
      Q => usr_imp_lmt(12),
      R => '0'
    );
\usr_imp_lmt_reg[13]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_imp_lmt[31]_i_1_n_0\,
      D => bram_din(13),
      Q => usr_imp_lmt(13),
      R => '0'
    );
\usr_imp_lmt_reg[14]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_imp_lmt[31]_i_1_n_0\,
      D => bram_din(14),
      Q => usr_imp_lmt(14),
      R => '0'
    );
\usr_imp_lmt_reg[15]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_imp_lmt[31]_i_1_n_0\,
      D => bram_din(15),
      Q => usr_imp_lmt(15),
      R => '0'
    );
\usr_imp_lmt_reg[16]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_imp_lmt[31]_i_1_n_0\,
      D => bram_din(16),
      Q => usr_imp_lmt(16),
      R => '0'
    );
\usr_imp_lmt_reg[17]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_imp_lmt[31]_i_1_n_0\,
      D => bram_din(17),
      Q => usr_imp_lmt(17),
      R => '0'
    );
\usr_imp_lmt_reg[18]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_imp_lmt[31]_i_1_n_0\,
      D => bram_din(18),
      Q => usr_imp_lmt(18),
      R => '0'
    );
\usr_imp_lmt_reg[19]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_imp_lmt[31]_i_1_n_0\,
      D => bram_din(19),
      Q => usr_imp_lmt(19),
      R => '0'
    );
\usr_imp_lmt_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_imp_lmt[31]_i_1_n_0\,
      D => bram_din(1),
      Q => usr_imp_lmt(1),
      R => '0'
    );
\usr_imp_lmt_reg[20]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_imp_lmt[31]_i_1_n_0\,
      D => bram_din(20),
      Q => usr_imp_lmt(20),
      R => '0'
    );
\usr_imp_lmt_reg[21]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_imp_lmt[31]_i_1_n_0\,
      D => bram_din(21),
      Q => usr_imp_lmt(21),
      R => '0'
    );
\usr_imp_lmt_reg[22]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_imp_lmt[31]_i_1_n_0\,
      D => bram_din(22),
      Q => usr_imp_lmt(22),
      R => '0'
    );
\usr_imp_lmt_reg[23]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_imp_lmt[31]_i_1_n_0\,
      D => bram_din(23),
      Q => usr_imp_lmt(23),
      R => '0'
    );
\usr_imp_lmt_reg[24]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_imp_lmt[31]_i_1_n_0\,
      D => bram_din(24),
      Q => usr_imp_lmt(24),
      R => '0'
    );
\usr_imp_lmt_reg[25]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_imp_lmt[31]_i_1_n_0\,
      D => bram_din(25),
      Q => usr_imp_lmt(25),
      R => '0'
    );
\usr_imp_lmt_reg[26]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_imp_lmt[31]_i_1_n_0\,
      D => bram_din(26),
      Q => usr_imp_lmt(26),
      R => '0'
    );
\usr_imp_lmt_reg[27]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_imp_lmt[31]_i_1_n_0\,
      D => bram_din(27),
      Q => usr_imp_lmt(27),
      R => '0'
    );
\usr_imp_lmt_reg[28]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_imp_lmt[31]_i_1_n_0\,
      D => bram_din(28),
      Q => usr_imp_lmt(28),
      R => '0'
    );
\usr_imp_lmt_reg[29]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_imp_lmt[31]_i_1_n_0\,
      D => bram_din(29),
      Q => usr_imp_lmt(29),
      R => '0'
    );
\usr_imp_lmt_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_imp_lmt[31]_i_1_n_0\,
      D => bram_din(2),
      Q => usr_imp_lmt(2),
      R => '0'
    );
\usr_imp_lmt_reg[30]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_imp_lmt[31]_i_1_n_0\,
      D => bram_din(30),
      Q => usr_imp_lmt(30),
      R => '0'
    );
\usr_imp_lmt_reg[31]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_imp_lmt[31]_i_1_n_0\,
      D => bram_din(31),
      Q => usr_imp_lmt(31),
      R => '0'
    );
\usr_imp_lmt_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_imp_lmt[31]_i_1_n_0\,
      D => bram_din(3),
      Q => usr_imp_lmt(3),
      R => '0'
    );
\usr_imp_lmt_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_imp_lmt[31]_i_1_n_0\,
      D => bram_din(4),
      Q => usr_imp_lmt(4),
      R => '0'
    );
\usr_imp_lmt_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_imp_lmt[31]_i_1_n_0\,
      D => bram_din(5),
      Q => usr_imp_lmt(5),
      R => '0'
    );
\usr_imp_lmt_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_imp_lmt[31]_i_1_n_0\,
      D => bram_din(6),
      Q => usr_imp_lmt(6),
      R => '0'
    );
\usr_imp_lmt_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_imp_lmt[31]_i_1_n_0\,
      D => bram_din(7),
      Q => usr_imp_lmt(7),
      R => '0'
    );
\usr_imp_lmt_reg[8]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_imp_lmt[31]_i_1_n_0\,
      D => bram_din(8),
      Q => usr_imp_lmt(8),
      R => '0'
    );
\usr_imp_lmt_reg[9]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_imp_lmt[31]_i_1_n_0\,
      D => bram_din(9),
      Q => usr_imp_lmt(9),
      R => '0'
    );
usr_param_vld_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFDF00000010"
    )
        port map (
      I0 => state_usrparam_r(0),
      I1 => state_usrparam_r(1),
      I2 => state_usrparam_r(4),
      I3 => state_usrparam_r(3),
      I4 => state_usrparam_r(2),
      I5 => \^usr_param_vld\,
      O => usr_param_vld_i_1_n_0
    );
usr_param_vld_reg: unisim.vcomponents.FDCE
     port map (
      C => clkin,
      CE => '1',
      CLR => \bram_addr_10bit[9]_i_2_n_0\,
      D => usr_param_vld_i_1_n_0,
      Q => \^usr_param_vld\
    );
\usr_pv_kd[31]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000100000000000"
    )
        port map (
      I0 => state_usrparam_r(1),
      I1 => state_usrparam_r(4),
      I2 => state_usrparam_r(3),
      I3 => arst_n,
      I4 => state_usrparam_r(0),
      I5 => state_usrparam_r(2),
      O => \usr_pv_kd[31]_i_1_n_0\
    );
\usr_pv_kd_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_pv_kd[31]_i_1_n_0\,
      D => bram_din(0),
      Q => usr_pv_kd(0),
      R => '0'
    );
\usr_pv_kd_reg[10]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_pv_kd[31]_i_1_n_0\,
      D => bram_din(10),
      Q => usr_pv_kd(10),
      R => '0'
    );
\usr_pv_kd_reg[11]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_pv_kd[31]_i_1_n_0\,
      D => bram_din(11),
      Q => usr_pv_kd(11),
      R => '0'
    );
\usr_pv_kd_reg[12]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_pv_kd[31]_i_1_n_0\,
      D => bram_din(12),
      Q => usr_pv_kd(12),
      R => '0'
    );
\usr_pv_kd_reg[13]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_pv_kd[31]_i_1_n_0\,
      D => bram_din(13),
      Q => usr_pv_kd(13),
      R => '0'
    );
\usr_pv_kd_reg[14]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_pv_kd[31]_i_1_n_0\,
      D => bram_din(14),
      Q => usr_pv_kd(14),
      R => '0'
    );
\usr_pv_kd_reg[15]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_pv_kd[31]_i_1_n_0\,
      D => bram_din(15),
      Q => usr_pv_kd(15),
      R => '0'
    );
\usr_pv_kd_reg[16]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_pv_kd[31]_i_1_n_0\,
      D => bram_din(16),
      Q => usr_pv_kd(16),
      R => '0'
    );
\usr_pv_kd_reg[17]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_pv_kd[31]_i_1_n_0\,
      D => bram_din(17),
      Q => usr_pv_kd(17),
      R => '0'
    );
\usr_pv_kd_reg[18]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_pv_kd[31]_i_1_n_0\,
      D => bram_din(18),
      Q => usr_pv_kd(18),
      R => '0'
    );
\usr_pv_kd_reg[19]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_pv_kd[31]_i_1_n_0\,
      D => bram_din(19),
      Q => usr_pv_kd(19),
      R => '0'
    );
\usr_pv_kd_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_pv_kd[31]_i_1_n_0\,
      D => bram_din(1),
      Q => usr_pv_kd(1),
      R => '0'
    );
\usr_pv_kd_reg[20]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_pv_kd[31]_i_1_n_0\,
      D => bram_din(20),
      Q => usr_pv_kd(20),
      R => '0'
    );
\usr_pv_kd_reg[21]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_pv_kd[31]_i_1_n_0\,
      D => bram_din(21),
      Q => usr_pv_kd(21),
      R => '0'
    );
\usr_pv_kd_reg[22]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_pv_kd[31]_i_1_n_0\,
      D => bram_din(22),
      Q => usr_pv_kd(22),
      R => '0'
    );
\usr_pv_kd_reg[23]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_pv_kd[31]_i_1_n_0\,
      D => bram_din(23),
      Q => usr_pv_kd(23),
      R => '0'
    );
\usr_pv_kd_reg[24]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_pv_kd[31]_i_1_n_0\,
      D => bram_din(24),
      Q => usr_pv_kd(24),
      R => '0'
    );
\usr_pv_kd_reg[25]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_pv_kd[31]_i_1_n_0\,
      D => bram_din(25),
      Q => usr_pv_kd(25),
      R => '0'
    );
\usr_pv_kd_reg[26]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_pv_kd[31]_i_1_n_0\,
      D => bram_din(26),
      Q => usr_pv_kd(26),
      R => '0'
    );
\usr_pv_kd_reg[27]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_pv_kd[31]_i_1_n_0\,
      D => bram_din(27),
      Q => usr_pv_kd(27),
      R => '0'
    );
\usr_pv_kd_reg[28]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_pv_kd[31]_i_1_n_0\,
      D => bram_din(28),
      Q => usr_pv_kd(28),
      R => '0'
    );
\usr_pv_kd_reg[29]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_pv_kd[31]_i_1_n_0\,
      D => bram_din(29),
      Q => usr_pv_kd(29),
      R => '0'
    );
\usr_pv_kd_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_pv_kd[31]_i_1_n_0\,
      D => bram_din(2),
      Q => usr_pv_kd(2),
      R => '0'
    );
\usr_pv_kd_reg[30]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_pv_kd[31]_i_1_n_0\,
      D => bram_din(30),
      Q => usr_pv_kd(30),
      R => '0'
    );
\usr_pv_kd_reg[31]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_pv_kd[31]_i_1_n_0\,
      D => bram_din(31),
      Q => usr_pv_kd(31),
      R => '0'
    );
\usr_pv_kd_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_pv_kd[31]_i_1_n_0\,
      D => bram_din(3),
      Q => usr_pv_kd(3),
      R => '0'
    );
\usr_pv_kd_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_pv_kd[31]_i_1_n_0\,
      D => bram_din(4),
      Q => usr_pv_kd(4),
      R => '0'
    );
\usr_pv_kd_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_pv_kd[31]_i_1_n_0\,
      D => bram_din(5),
      Q => usr_pv_kd(5),
      R => '0'
    );
\usr_pv_kd_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_pv_kd[31]_i_1_n_0\,
      D => bram_din(6),
      Q => usr_pv_kd(6),
      R => '0'
    );
\usr_pv_kd_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_pv_kd[31]_i_1_n_0\,
      D => bram_din(7),
      Q => usr_pv_kd(7),
      R => '0'
    );
\usr_pv_kd_reg[8]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_pv_kd[31]_i_1_n_0\,
      D => bram_din(8),
      Q => usr_pv_kd(8),
      R => '0'
    );
\usr_pv_kd_reg[9]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_pv_kd[31]_i_1_n_0\,
      D => bram_din(9),
      Q => usr_pv_kd(9),
      R => '0'
    );
\usr_pv_ki[31]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0040000000000000"
    )
        port map (
      I0 => state_usrparam_r(2),
      I1 => state_usrparam_r(0),
      I2 => state_usrparam_r(1),
      I3 => state_usrparam_r(4),
      I4 => state_usrparam_r(3),
      I5 => arst_n,
      O => \usr_pv_ki[31]_i_1_n_0\
    );
\usr_pv_ki_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_pv_ki[31]_i_1_n_0\,
      D => bram_din(0),
      Q => usr_pv_ki(0),
      R => '0'
    );
\usr_pv_ki_reg[10]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_pv_ki[31]_i_1_n_0\,
      D => bram_din(10),
      Q => usr_pv_ki(10),
      R => '0'
    );
\usr_pv_ki_reg[11]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_pv_ki[31]_i_1_n_0\,
      D => bram_din(11),
      Q => usr_pv_ki(11),
      R => '0'
    );
\usr_pv_ki_reg[12]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_pv_ki[31]_i_1_n_0\,
      D => bram_din(12),
      Q => usr_pv_ki(12),
      R => '0'
    );
\usr_pv_ki_reg[13]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_pv_ki[31]_i_1_n_0\,
      D => bram_din(13),
      Q => usr_pv_ki(13),
      R => '0'
    );
\usr_pv_ki_reg[14]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_pv_ki[31]_i_1_n_0\,
      D => bram_din(14),
      Q => usr_pv_ki(14),
      R => '0'
    );
\usr_pv_ki_reg[15]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_pv_ki[31]_i_1_n_0\,
      D => bram_din(15),
      Q => usr_pv_ki(15),
      R => '0'
    );
\usr_pv_ki_reg[16]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_pv_ki[31]_i_1_n_0\,
      D => bram_din(16),
      Q => usr_pv_ki(16),
      R => '0'
    );
\usr_pv_ki_reg[17]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_pv_ki[31]_i_1_n_0\,
      D => bram_din(17),
      Q => usr_pv_ki(17),
      R => '0'
    );
\usr_pv_ki_reg[18]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_pv_ki[31]_i_1_n_0\,
      D => bram_din(18),
      Q => usr_pv_ki(18),
      R => '0'
    );
\usr_pv_ki_reg[19]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_pv_ki[31]_i_1_n_0\,
      D => bram_din(19),
      Q => usr_pv_ki(19),
      R => '0'
    );
\usr_pv_ki_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_pv_ki[31]_i_1_n_0\,
      D => bram_din(1),
      Q => usr_pv_ki(1),
      R => '0'
    );
\usr_pv_ki_reg[20]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_pv_ki[31]_i_1_n_0\,
      D => bram_din(20),
      Q => usr_pv_ki(20),
      R => '0'
    );
\usr_pv_ki_reg[21]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_pv_ki[31]_i_1_n_0\,
      D => bram_din(21),
      Q => usr_pv_ki(21),
      R => '0'
    );
\usr_pv_ki_reg[22]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_pv_ki[31]_i_1_n_0\,
      D => bram_din(22),
      Q => usr_pv_ki(22),
      R => '0'
    );
\usr_pv_ki_reg[23]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_pv_ki[31]_i_1_n_0\,
      D => bram_din(23),
      Q => usr_pv_ki(23),
      R => '0'
    );
\usr_pv_ki_reg[24]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_pv_ki[31]_i_1_n_0\,
      D => bram_din(24),
      Q => usr_pv_ki(24),
      R => '0'
    );
\usr_pv_ki_reg[25]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_pv_ki[31]_i_1_n_0\,
      D => bram_din(25),
      Q => usr_pv_ki(25),
      R => '0'
    );
\usr_pv_ki_reg[26]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_pv_ki[31]_i_1_n_0\,
      D => bram_din(26),
      Q => usr_pv_ki(26),
      R => '0'
    );
\usr_pv_ki_reg[27]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_pv_ki[31]_i_1_n_0\,
      D => bram_din(27),
      Q => usr_pv_ki(27),
      R => '0'
    );
\usr_pv_ki_reg[28]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_pv_ki[31]_i_1_n_0\,
      D => bram_din(28),
      Q => usr_pv_ki(28),
      R => '0'
    );
\usr_pv_ki_reg[29]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_pv_ki[31]_i_1_n_0\,
      D => bram_din(29),
      Q => usr_pv_ki(29),
      R => '0'
    );
\usr_pv_ki_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_pv_ki[31]_i_1_n_0\,
      D => bram_din(2),
      Q => usr_pv_ki(2),
      R => '0'
    );
\usr_pv_ki_reg[30]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_pv_ki[31]_i_1_n_0\,
      D => bram_din(30),
      Q => usr_pv_ki(30),
      R => '0'
    );
\usr_pv_ki_reg[31]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_pv_ki[31]_i_1_n_0\,
      D => bram_din(31),
      Q => usr_pv_ki(31),
      R => '0'
    );
\usr_pv_ki_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_pv_ki[31]_i_1_n_0\,
      D => bram_din(3),
      Q => usr_pv_ki(3),
      R => '0'
    );
\usr_pv_ki_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_pv_ki[31]_i_1_n_0\,
      D => bram_din(4),
      Q => usr_pv_ki(4),
      R => '0'
    );
\usr_pv_ki_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_pv_ki[31]_i_1_n_0\,
      D => bram_din(5),
      Q => usr_pv_ki(5),
      R => '0'
    );
\usr_pv_ki_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_pv_ki[31]_i_1_n_0\,
      D => bram_din(6),
      Q => usr_pv_ki(6),
      R => '0'
    );
\usr_pv_ki_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_pv_ki[31]_i_1_n_0\,
      D => bram_din(7),
      Q => usr_pv_ki(7),
      R => '0'
    );
\usr_pv_ki_reg[8]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_pv_ki[31]_i_1_n_0\,
      D => bram_din(8),
      Q => usr_pv_ki(8),
      R => '0'
    );
\usr_pv_ki_reg[9]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_pv_ki[31]_i_1_n_0\,
      D => bram_din(9),
      Q => usr_pv_ki(9),
      R => '0'
    );
\usr_pv_kp[31]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0010000000000000"
    )
        port map (
      I0 => state_usrparam_r(2),
      I1 => state_usrparam_r(0),
      I2 => state_usrparam_r(1),
      I3 => state_usrparam_r(4),
      I4 => state_usrparam_r(3),
      I5 => arst_n,
      O => \usr_pv_kp[31]_i_1_n_0\
    );
\usr_pv_kp_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_pv_kp[31]_i_1_n_0\,
      D => bram_din(0),
      Q => usr_pv_kp(0),
      R => '0'
    );
\usr_pv_kp_reg[10]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_pv_kp[31]_i_1_n_0\,
      D => bram_din(10),
      Q => usr_pv_kp(10),
      R => '0'
    );
\usr_pv_kp_reg[11]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_pv_kp[31]_i_1_n_0\,
      D => bram_din(11),
      Q => usr_pv_kp(11),
      R => '0'
    );
\usr_pv_kp_reg[12]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_pv_kp[31]_i_1_n_0\,
      D => bram_din(12),
      Q => usr_pv_kp(12),
      R => '0'
    );
\usr_pv_kp_reg[13]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_pv_kp[31]_i_1_n_0\,
      D => bram_din(13),
      Q => usr_pv_kp(13),
      R => '0'
    );
\usr_pv_kp_reg[14]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_pv_kp[31]_i_1_n_0\,
      D => bram_din(14),
      Q => usr_pv_kp(14),
      R => '0'
    );
\usr_pv_kp_reg[15]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_pv_kp[31]_i_1_n_0\,
      D => bram_din(15),
      Q => usr_pv_kp(15),
      R => '0'
    );
\usr_pv_kp_reg[16]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_pv_kp[31]_i_1_n_0\,
      D => bram_din(16),
      Q => usr_pv_kp(16),
      R => '0'
    );
\usr_pv_kp_reg[17]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_pv_kp[31]_i_1_n_0\,
      D => bram_din(17),
      Q => usr_pv_kp(17),
      R => '0'
    );
\usr_pv_kp_reg[18]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_pv_kp[31]_i_1_n_0\,
      D => bram_din(18),
      Q => usr_pv_kp(18),
      R => '0'
    );
\usr_pv_kp_reg[19]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_pv_kp[31]_i_1_n_0\,
      D => bram_din(19),
      Q => usr_pv_kp(19),
      R => '0'
    );
\usr_pv_kp_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_pv_kp[31]_i_1_n_0\,
      D => bram_din(1),
      Q => usr_pv_kp(1),
      R => '0'
    );
\usr_pv_kp_reg[20]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_pv_kp[31]_i_1_n_0\,
      D => bram_din(20),
      Q => usr_pv_kp(20),
      R => '0'
    );
\usr_pv_kp_reg[21]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_pv_kp[31]_i_1_n_0\,
      D => bram_din(21),
      Q => usr_pv_kp(21),
      R => '0'
    );
\usr_pv_kp_reg[22]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_pv_kp[31]_i_1_n_0\,
      D => bram_din(22),
      Q => usr_pv_kp(22),
      R => '0'
    );
\usr_pv_kp_reg[23]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_pv_kp[31]_i_1_n_0\,
      D => bram_din(23),
      Q => usr_pv_kp(23),
      R => '0'
    );
\usr_pv_kp_reg[24]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_pv_kp[31]_i_1_n_0\,
      D => bram_din(24),
      Q => usr_pv_kp(24),
      R => '0'
    );
\usr_pv_kp_reg[25]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_pv_kp[31]_i_1_n_0\,
      D => bram_din(25),
      Q => usr_pv_kp(25),
      R => '0'
    );
\usr_pv_kp_reg[26]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_pv_kp[31]_i_1_n_0\,
      D => bram_din(26),
      Q => usr_pv_kp(26),
      R => '0'
    );
\usr_pv_kp_reg[27]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_pv_kp[31]_i_1_n_0\,
      D => bram_din(27),
      Q => usr_pv_kp(27),
      R => '0'
    );
\usr_pv_kp_reg[28]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_pv_kp[31]_i_1_n_0\,
      D => bram_din(28),
      Q => usr_pv_kp(28),
      R => '0'
    );
\usr_pv_kp_reg[29]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_pv_kp[31]_i_1_n_0\,
      D => bram_din(29),
      Q => usr_pv_kp(29),
      R => '0'
    );
\usr_pv_kp_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_pv_kp[31]_i_1_n_0\,
      D => bram_din(2),
      Q => usr_pv_kp(2),
      R => '0'
    );
\usr_pv_kp_reg[30]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_pv_kp[31]_i_1_n_0\,
      D => bram_din(30),
      Q => usr_pv_kp(30),
      R => '0'
    );
\usr_pv_kp_reg[31]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_pv_kp[31]_i_1_n_0\,
      D => bram_din(31),
      Q => usr_pv_kp(31),
      R => '0'
    );
\usr_pv_kp_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_pv_kp[31]_i_1_n_0\,
      D => bram_din(3),
      Q => usr_pv_kp(3),
      R => '0'
    );
\usr_pv_kp_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_pv_kp[31]_i_1_n_0\,
      D => bram_din(4),
      Q => usr_pv_kp(4),
      R => '0'
    );
\usr_pv_kp_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_pv_kp[31]_i_1_n_0\,
      D => bram_din(5),
      Q => usr_pv_kp(5),
      R => '0'
    );
\usr_pv_kp_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_pv_kp[31]_i_1_n_0\,
      D => bram_din(6),
      Q => usr_pv_kp(6),
      R => '0'
    );
\usr_pv_kp_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_pv_kp[31]_i_1_n_0\,
      D => bram_din(7),
      Q => usr_pv_kp(7),
      R => '0'
    );
\usr_pv_kp_reg[8]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_pv_kp[31]_i_1_n_0\,
      D => bram_din(8),
      Q => usr_pv_kp(8),
      R => '0'
    );
\usr_pv_kp_reg[9]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_pv_kp[31]_i_1_n_0\,
      D => bram_din(9),
      Q => usr_pv_kp(9),
      R => '0'
    );
\usr_pv_max[31]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"2000000000000000"
    )
        port map (
      I0 => state_usrparam_r(1),
      I1 => state_usrparam_r(4),
      I2 => state_usrparam_r(3),
      I3 => arst_n,
      I4 => state_usrparam_r(2),
      I5 => state_usrparam_r(0),
      O => \usr_pv_max[31]_i_1_n_0\
    );
\usr_pv_max_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_pv_max[31]_i_1_n_0\,
      D => bram_din(0),
      Q => usr_pv_max(0),
      R => '0'
    );
\usr_pv_max_reg[10]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_pv_max[31]_i_1_n_0\,
      D => bram_din(10),
      Q => usr_pv_max(10),
      R => '0'
    );
\usr_pv_max_reg[11]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_pv_max[31]_i_1_n_0\,
      D => bram_din(11),
      Q => usr_pv_max(11),
      R => '0'
    );
\usr_pv_max_reg[12]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_pv_max[31]_i_1_n_0\,
      D => bram_din(12),
      Q => usr_pv_max(12),
      R => '0'
    );
\usr_pv_max_reg[13]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_pv_max[31]_i_1_n_0\,
      D => bram_din(13),
      Q => usr_pv_max(13),
      R => '0'
    );
\usr_pv_max_reg[14]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_pv_max[31]_i_1_n_0\,
      D => bram_din(14),
      Q => usr_pv_max(14),
      R => '0'
    );
\usr_pv_max_reg[15]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_pv_max[31]_i_1_n_0\,
      D => bram_din(15),
      Q => usr_pv_max(15),
      R => '0'
    );
\usr_pv_max_reg[16]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_pv_max[31]_i_1_n_0\,
      D => bram_din(16),
      Q => usr_pv_max(16),
      R => '0'
    );
\usr_pv_max_reg[17]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_pv_max[31]_i_1_n_0\,
      D => bram_din(17),
      Q => usr_pv_max(17),
      R => '0'
    );
\usr_pv_max_reg[18]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_pv_max[31]_i_1_n_0\,
      D => bram_din(18),
      Q => usr_pv_max(18),
      R => '0'
    );
\usr_pv_max_reg[19]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_pv_max[31]_i_1_n_0\,
      D => bram_din(19),
      Q => usr_pv_max(19),
      R => '0'
    );
\usr_pv_max_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_pv_max[31]_i_1_n_0\,
      D => bram_din(1),
      Q => usr_pv_max(1),
      R => '0'
    );
\usr_pv_max_reg[20]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_pv_max[31]_i_1_n_0\,
      D => bram_din(20),
      Q => usr_pv_max(20),
      R => '0'
    );
\usr_pv_max_reg[21]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_pv_max[31]_i_1_n_0\,
      D => bram_din(21),
      Q => usr_pv_max(21),
      R => '0'
    );
\usr_pv_max_reg[22]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_pv_max[31]_i_1_n_0\,
      D => bram_din(22),
      Q => usr_pv_max(22),
      R => '0'
    );
\usr_pv_max_reg[23]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_pv_max[31]_i_1_n_0\,
      D => bram_din(23),
      Q => usr_pv_max(23),
      R => '0'
    );
\usr_pv_max_reg[24]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_pv_max[31]_i_1_n_0\,
      D => bram_din(24),
      Q => usr_pv_max(24),
      R => '0'
    );
\usr_pv_max_reg[25]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_pv_max[31]_i_1_n_0\,
      D => bram_din(25),
      Q => usr_pv_max(25),
      R => '0'
    );
\usr_pv_max_reg[26]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_pv_max[31]_i_1_n_0\,
      D => bram_din(26),
      Q => usr_pv_max(26),
      R => '0'
    );
\usr_pv_max_reg[27]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_pv_max[31]_i_1_n_0\,
      D => bram_din(27),
      Q => usr_pv_max(27),
      R => '0'
    );
\usr_pv_max_reg[28]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_pv_max[31]_i_1_n_0\,
      D => bram_din(28),
      Q => usr_pv_max(28),
      R => '0'
    );
\usr_pv_max_reg[29]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_pv_max[31]_i_1_n_0\,
      D => bram_din(29),
      Q => usr_pv_max(29),
      R => '0'
    );
\usr_pv_max_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_pv_max[31]_i_1_n_0\,
      D => bram_din(2),
      Q => usr_pv_max(2),
      R => '0'
    );
\usr_pv_max_reg[30]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_pv_max[31]_i_1_n_0\,
      D => bram_din(30),
      Q => usr_pv_max(30),
      R => '0'
    );
\usr_pv_max_reg[31]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_pv_max[31]_i_1_n_0\,
      D => bram_din(31),
      Q => usr_pv_max(31),
      R => '0'
    );
\usr_pv_max_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_pv_max[31]_i_1_n_0\,
      D => bram_din(3),
      Q => usr_pv_max(3),
      R => '0'
    );
\usr_pv_max_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_pv_max[31]_i_1_n_0\,
      D => bram_din(4),
      Q => usr_pv_max(4),
      R => '0'
    );
\usr_pv_max_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_pv_max[31]_i_1_n_0\,
      D => bram_din(5),
      Q => usr_pv_max(5),
      R => '0'
    );
\usr_pv_max_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_pv_max[31]_i_1_n_0\,
      D => bram_din(6),
      Q => usr_pv_max(6),
      R => '0'
    );
\usr_pv_max_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_pv_max[31]_i_1_n_0\,
      D => bram_din(7),
      Q => usr_pv_max(7),
      R => '0'
    );
\usr_pv_max_reg[8]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_pv_max[31]_i_1_n_0\,
      D => bram_din(8),
      Q => usr_pv_max(8),
      R => '0'
    );
\usr_pv_max_reg[9]\: unisim.vcomponents.FDRE
     port map (
      C => clkin,
      CE => \usr_pv_max[31]_i_1_n_0\,
      D => bram_din(9),
      Q => usr_pv_max(9),
      R => '0'
    );
\usrparam_bram_addr[0]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"0000BFFE"
    )
        port map (
      I0 => state_usrparam_r(0),
      I1 => state_usrparam_r(2),
      I2 => state_usrparam_r(3),
      I3 => state_usrparam_r(1),
      I4 => \usrparam_bram_addr_reg_n_0_[0]\,
      O => \usrparam_bram_addr[0]_i_1_n_0\
    );
\usrparam_bram_addr[1]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"14"
    )
        port map (
      I0 => \usrparam_bram_addr[9]_i_4_n_0\,
      I1 => \usrparam_bram_addr_reg_n_0_[0]\,
      I2 => \usrparam_bram_addr_reg_n_0_[1]\,
      O => \usrparam_bram_addr[1]_i_1_n_0\
    );
\usrparam_bram_addr[2]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"1540"
    )
        port map (
      I0 => \usrparam_bram_addr[9]_i_4_n_0\,
      I1 => \usrparam_bram_addr_reg_n_0_[1]\,
      I2 => \usrparam_bram_addr_reg_n_0_[0]\,
      I3 => \usrparam_bram_addr_reg_n_0_[2]\,
      O => \usrparam_bram_addr[2]_i_1_n_0\
    );
\usrparam_bram_addr[3]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"15554000"
    )
        port map (
      I0 => \usrparam_bram_addr[9]_i_4_n_0\,
      I1 => \usrparam_bram_addr_reg_n_0_[2]\,
      I2 => \usrparam_bram_addr_reg_n_0_[0]\,
      I3 => \usrparam_bram_addr_reg_n_0_[1]\,
      I4 => \usrparam_bram_addr_reg_n_0_[3]\,
      O => \usrparam_bram_addr[3]_i_1_n_0\
    );
\usrparam_bram_addr[4]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"1555555540000000"
    )
        port map (
      I0 => \usrparam_bram_addr[9]_i_4_n_0\,
      I1 => \usrparam_bram_addr_reg_n_0_[3]\,
      I2 => \usrparam_bram_addr_reg_n_0_[1]\,
      I3 => \usrparam_bram_addr_reg_n_0_[0]\,
      I4 => \usrparam_bram_addr_reg_n_0_[2]\,
      I5 => \usrparam_bram_addr_reg_n_0_[4]\,
      O => \usrparam_bram_addr[4]_i_1_n_0\
    );
\usrparam_bram_addr[5]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"12"
    )
        port map (
      I0 => \usrparam_bram_addr[5]_i_2_n_0\,
      I1 => \usrparam_bram_addr[9]_i_4_n_0\,
      I2 => \usrparam_bram_addr_reg_n_0_[5]\,
      O => \usrparam_bram_addr[5]_i_1_n_0\
    );
\usrparam_bram_addr[5]_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"80000000"
    )
        port map (
      I0 => \usrparam_bram_addr_reg_n_0_[4]\,
      I1 => \usrparam_bram_addr_reg_n_0_[3]\,
      I2 => \usrparam_bram_addr_reg_n_0_[1]\,
      I3 => \usrparam_bram_addr_reg_n_0_[0]\,
      I4 => \usrparam_bram_addr_reg_n_0_[2]\,
      O => \usrparam_bram_addr[5]_i_2_n_0\
    );
\usrparam_bram_addr[6]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"21"
    )
        port map (
      I0 => \usrparam_bram_addr[9]_i_3_n_0\,
      I1 => \usrparam_bram_addr[9]_i_4_n_0\,
      I2 => \usrparam_bram_addr_reg_n_0_[6]\,
      O => \usrparam_bram_addr[6]_i_1_n_0\
    );
\usrparam_bram_addr[7]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFF2212"
    )
        port map (
      I0 => \usrparam_bram_addr_reg_n_0_[7]\,
      I1 => \usrparam_bram_addr[9]_i_4_n_0\,
      I2 => \usrparam_bram_addr_reg_n_0_[6]\,
      I3 => \usrparam_bram_addr[9]_i_3_n_0\,
      I4 => \usrparam_bram_addr[7]_i_2_n_0\,
      O => \usrparam_bram_addr[7]_i_1_n_0\
    );
\usrparam_bram_addr[7]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFF800100000000"
    )
        port map (
      I0 => state_usrparam_r(1),
      I1 => state_usrparam_r(0),
      I2 => state_usrparam_r(3),
      I3 => state_usrparam_r(2),
      I4 => state_usrparam_r(4),
      I5 => usrparam_rdata_sig_reg_n_0,
      O => \usrparam_bram_addr[7]_i_2_n_0\
    );
\usrparam_bram_addr[8]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00DF0020"
    )
        port map (
      I0 => \usrparam_bram_addr_reg_n_0_[6]\,
      I1 => \usrparam_bram_addr[9]_i_3_n_0\,
      I2 => \usrparam_bram_addr_reg_n_0_[7]\,
      I3 => \usrparam_bram_addr[9]_i_4_n_0\,
      I4 => \usrparam_bram_addr_reg_n_0_[8]\,
      O => \usrparam_bram_addr[8]_i_1_n_0\
    );
\usrparam_bram_addr[9]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"070F0F0F"
    )
        port map (
      I0 => state_usrparam_r(3),
      I1 => state_usrparam_r(1),
      I2 => state_usrparam_r(4),
      I3 => state_usrparam_r(2),
      I4 => state_usrparam_r(0),
      O => \usrparam_bram_addr[9]_i_1_n_0\
    );
\usrparam_bram_addr[9]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000DFFF00002000"
    )
        port map (
      I0 => \usrparam_bram_addr_reg_n_0_[7]\,
      I1 => \usrparam_bram_addr[9]_i_3_n_0\,
      I2 => \usrparam_bram_addr_reg_n_0_[6]\,
      I3 => \usrparam_bram_addr_reg_n_0_[8]\,
      I4 => \usrparam_bram_addr[9]_i_4_n_0\,
      I5 => \usrparam_bram_addr_reg_n_0_[9]\,
      O => \usrparam_bram_addr[9]_i_2_n_0\
    );
\usrparam_bram_addr[9]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"7FFFFFFFFFFFFFFF"
    )
        port map (
      I0 => \usrparam_bram_addr_reg_n_0_[2]\,
      I1 => \usrparam_bram_addr_reg_n_0_[0]\,
      I2 => \usrparam_bram_addr_reg_n_0_[1]\,
      I3 => \usrparam_bram_addr_reg_n_0_[3]\,
      I4 => \usrparam_bram_addr_reg_n_0_[4]\,
      I5 => \usrparam_bram_addr_reg_n_0_[5]\,
      O => \usrparam_bram_addr[9]_i_3_n_0\
    );
\usrparam_bram_addr[9]_i_4\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00002001"
    )
        port map (
      I0 => state_usrparam_r(1),
      I1 => state_usrparam_r(4),
      I2 => state_usrparam_r(3),
      I3 => state_usrparam_r(2),
      I4 => state_usrparam_r(0),
      O => \usrparam_bram_addr[9]_i_4_n_0\
    );
\usrparam_bram_addr_reg[0]\: unisim.vcomponents.FDCE
     port map (
      C => clkin,
      CE => \usrparam_bram_addr[9]_i_1_n_0\,
      CLR => \bram_addr_10bit[9]_i_2_n_0\,
      D => \usrparam_bram_addr[0]_i_1_n_0\,
      Q => \usrparam_bram_addr_reg_n_0_[0]\
    );
\usrparam_bram_addr_reg[1]\: unisim.vcomponents.FDCE
     port map (
      C => clkin,
      CE => \usrparam_bram_addr[9]_i_1_n_0\,
      CLR => \bram_addr_10bit[9]_i_2_n_0\,
      D => \usrparam_bram_addr[1]_i_1_n_0\,
      Q => \usrparam_bram_addr_reg_n_0_[1]\
    );
\usrparam_bram_addr_reg[2]\: unisim.vcomponents.FDCE
     port map (
      C => clkin,
      CE => \usrparam_bram_addr[9]_i_1_n_0\,
      CLR => \bram_addr_10bit[9]_i_2_n_0\,
      D => \usrparam_bram_addr[2]_i_1_n_0\,
      Q => \usrparam_bram_addr_reg_n_0_[2]\
    );
\usrparam_bram_addr_reg[3]\: unisim.vcomponents.FDCE
     port map (
      C => clkin,
      CE => \usrparam_bram_addr[9]_i_1_n_0\,
      CLR => \bram_addr_10bit[9]_i_2_n_0\,
      D => \usrparam_bram_addr[3]_i_1_n_0\,
      Q => \usrparam_bram_addr_reg_n_0_[3]\
    );
\usrparam_bram_addr_reg[4]\: unisim.vcomponents.FDCE
     port map (
      C => clkin,
      CE => \usrparam_bram_addr[9]_i_1_n_0\,
      CLR => \bram_addr_10bit[9]_i_2_n_0\,
      D => \usrparam_bram_addr[4]_i_1_n_0\,
      Q => \usrparam_bram_addr_reg_n_0_[4]\
    );
\usrparam_bram_addr_reg[5]\: unisim.vcomponents.FDCE
     port map (
      C => clkin,
      CE => \usrparam_bram_addr[9]_i_1_n_0\,
      CLR => \bram_addr_10bit[9]_i_2_n_0\,
      D => \usrparam_bram_addr[5]_i_1_n_0\,
      Q => \usrparam_bram_addr_reg_n_0_[5]\
    );
\usrparam_bram_addr_reg[6]\: unisim.vcomponents.FDCE
     port map (
      C => clkin,
      CE => \usrparam_bram_addr[9]_i_1_n_0\,
      CLR => \bram_addr_10bit[9]_i_2_n_0\,
      D => \usrparam_bram_addr[6]_i_1_n_0\,
      Q => \usrparam_bram_addr_reg_n_0_[6]\
    );
\usrparam_bram_addr_reg[7]\: unisim.vcomponents.FDCE
     port map (
      C => clkin,
      CE => \usrparam_bram_addr[9]_i_1_n_0\,
      CLR => \bram_addr_10bit[9]_i_2_n_0\,
      D => \usrparam_bram_addr[7]_i_1_n_0\,
      Q => \usrparam_bram_addr_reg_n_0_[7]\
    );
\usrparam_bram_addr_reg[8]\: unisim.vcomponents.FDCE
     port map (
      C => clkin,
      CE => \usrparam_bram_addr[9]_i_1_n_0\,
      CLR => \bram_addr_10bit[9]_i_2_n_0\,
      D => \usrparam_bram_addr[8]_i_1_n_0\,
      Q => \usrparam_bram_addr_reg_n_0_[8]\
    );
\usrparam_bram_addr_reg[9]\: unisim.vcomponents.FDCE
     port map (
      C => clkin,
      CE => \usrparam_bram_addr[9]_i_1_n_0\,
      CLR => \bram_addr_10bit[9]_i_2_n_0\,
      D => \usrparam_bram_addr[9]_i_2_n_0\,
      Q => \usrparam_bram_addr_reg_n_0_[9]\
    );
usrparam_bram_enb_i_1: unisim.vcomponents.LUT5
    generic map(
      INIT => X"33FFFFFE"
    )
        port map (
      I0 => state_usrparam_r(0),
      I1 => state_usrparam_r(2),
      I2 => usrparam_rdata_sig_reg_n_0,
      I3 => state_usrparam_r(1),
      I4 => state_usrparam_r(3),
      O => usrparam_bram_enb
    );
usrparam_bram_enb_reg: unisim.vcomponents.FDCE
     port map (
      C => clkin,
      CE => \usrparam_bram_addr[9]_i_1_n_0\,
      CLR => \bram_addr_10bit[9]_i_2_n_0\,
      D => usrparam_bram_enb,
      Q => usrparam_bram_enb_reg_n_0
    );
usrparam_rdata_sig_i_1: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00000004"
    )
        port map (
      I0 => pv_bram_rdataflg,
      I1 => usrparam_bram_rdataflg,
      I2 => meter_bram_rdataflg,
      I3 => bess_bram_rdataflg,
      I4 => state,
      O => usrparam_rdata_sig_i_1_n_0
    );
usrparam_rdata_sig_reg: unisim.vcomponents.FDCE
     port map (
      C => clkin,
      CE => '1',
      CLR => \bram_addr_10bit[9]_i_2_n_0\,
      D => usrparam_rdata_sig_i_1_n_0,
      Q => usrparam_rdata_sig_reg_n_0
    );
\wcmd_sig[31]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"04"
    )
        port map (
      I0 => state_wcmd(1),
      I1 => state_wcmd(0),
      I2 => pspl_wcmd_bsy,
      O => \wcmd_sig[31]_i_1_n_0\
    );
\wcmd_sig[31]_i_2\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => \^wcmd_sig\(4),
      O => p_2_out(31)
    );
\wcmd_sig_hld[14]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"880F"
    )
        port map (
      I0 => \wcmd_sig_hld_reg_n_0_[14]\,
      I1 => wcmd_sig_lastcmd(14),
      I2 => \state_wcmd1__1\,
      I3 => state_wcmd(0),
      O => \wcmd_sig_hld[14]_i_1_n_0\
    );
\wcmd_sig_hld[22]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"880F"
    )
        port map (
      I0 => \wcmd_sig_hld_reg_n_0_[22]\,
      I1 => wcmd_sig_lastcmd(22),
      I2 => \state_wcmd1__1\,
      I3 => state_wcmd(0),
      O => \wcmd_sig_hld[22]_i_1_n_0\
    );
\wcmd_sig_hld[29]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0F000F0F0F000404"
    )
        port map (
      I0 => bess_pvld_wltch,
      I1 => pv_pvld_wltch,
      I2 => state_wcmd(1),
      I3 => \wcmd_sig_hld[29]_i_3_n_0\,
      I4 => state_wcmd(0),
      I5 => \state_wcmd1__1\,
      O => wcmd_sig_hld(29)
    );
\wcmd_sig_hld[29]_i_2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"880F"
    )
        port map (
      I0 => \wcmd_sig_hld_reg_n_0_[29]\,
      I1 => wcmd_sig_lastcmd(14),
      I2 => \state_wcmd1__1\,
      I3 => state_wcmd(0),
      O => \wcmd_sig_hld[29]_i_2_n_0\
    );
\wcmd_sig_hld[29]_i_3\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => pspl_wcmd_bsy,
      I1 => pspl_wcmd_bsyreg,
      O => \wcmd_sig_hld[29]_i_3_n_0\
    );
\wcmd_sig_hld[30]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0022002200FF00F0"
    )
        port map (
      I0 => pspl_wcmd_bsy,
      I1 => pspl_wcmd_bsyreg,
      I2 => \state_wcmd1__1\,
      I3 => state_wcmd(1),
      I4 => bess_pvld_wltch,
      I5 => state_wcmd(0),
      O => wcmd_sig_hld(22)
    );
\wcmd_sig_hld[30]_i_2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"880F"
    )
        port map (
      I0 => \wcmd_sig_hld_reg_n_0_[30]\,
      I1 => wcmd_sig_lastcmd(22),
      I2 => \state_wcmd1__1\,
      I3 => state_wcmd(0),
      O => \wcmd_sig_hld[30]_i_2_n_0\
    );
\wcmd_sig_hld_reg[14]\: unisim.vcomponents.FDCE
     port map (
      C => clkin,
      CE => wcmd_sig_hld(29),
      CLR => \bram_addr_10bit[9]_i_2_n_0\,
      D => \wcmd_sig_hld[14]_i_1_n_0\,
      Q => \wcmd_sig_hld_reg_n_0_[14]\
    );
\wcmd_sig_hld_reg[22]\: unisim.vcomponents.FDCE
     port map (
      C => clkin,
      CE => wcmd_sig_hld(22),
      CLR => \bram_addr_10bit[9]_i_2_n_0\,
      D => \wcmd_sig_hld[22]_i_1_n_0\,
      Q => \wcmd_sig_hld_reg_n_0_[22]\
    );
\wcmd_sig_hld_reg[29]\: unisim.vcomponents.FDCE
     port map (
      C => clkin,
      CE => wcmd_sig_hld(29),
      CLR => \bram_addr_10bit[9]_i_2_n_0\,
      D => \wcmd_sig_hld[29]_i_2_n_0\,
      Q => \wcmd_sig_hld_reg_n_0_[29]\
    );
\wcmd_sig_hld_reg[30]\: unisim.vcomponents.FDCE
     port map (
      C => clkin,
      CE => wcmd_sig_hld(22),
      CLR => \bram_addr_10bit[9]_i_2_n_0\,
      D => \wcmd_sig_hld[30]_i_2_n_0\,
      Q => \wcmd_sig_hld_reg_n_0_[30]\
    );
\wcmd_sig_lastcmd[14]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FF00FFFF00000010"
    )
        port map (
      I0 => \state_wcmd1__1\,
      I1 => bess_pvld_wltch,
      I2 => pv_pvld_wltch,
      I3 => state_wcmd(1),
      I4 => state_wcmd(0),
      I5 => wcmd_sig_lastcmd(14),
      O => \wcmd_sig_lastcmd[14]_i_1_n_0\
    );
\wcmd_sig_lastcmd[22]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"F0FF0004"
    )
        port map (
      I0 => \state_wcmd1__1\,
      I1 => bess_pvld_wltch,
      I2 => state_wcmd(1),
      I3 => state_wcmd(0),
      I4 => wcmd_sig_lastcmd(22),
      O => \wcmd_sig_lastcmd[22]_i_1_n_0\
    );
\wcmd_sig_lastcmd_reg[14]\: unisim.vcomponents.FDCE
     port map (
      C => clkin,
      CE => '1',
      CLR => \bram_addr_10bit[9]_i_2_n_0\,
      D => \wcmd_sig_lastcmd[14]_i_1_n_0\,
      Q => wcmd_sig_lastcmd(14)
    );
\wcmd_sig_lastcmd_reg[22]\: unisim.vcomponents.FDCE
     port map (
      C => clkin,
      CE => '1',
      CLR => \bram_addr_10bit[9]_i_2_n_0\,
      D => \wcmd_sig_lastcmd[22]_i_1_n_0\,
      Q => wcmd_sig_lastcmd(22)
    );
\wcmd_sig_reg[14]\: unisim.vcomponents.FDCE
     port map (
      C => clkin,
      CE => \wcmd_sig[31]_i_1_n_0\,
      CLR => \bram_addr_10bit[9]_i_2_n_0\,
      D => \wcmd_sig_hld_reg_n_0_[14]\,
      Q => \^wcmd_sig\(0)
    );
\wcmd_sig_reg[22]\: unisim.vcomponents.FDCE
     port map (
      C => clkin,
      CE => \wcmd_sig[31]_i_1_n_0\,
      CLR => \bram_addr_10bit[9]_i_2_n_0\,
      D => \wcmd_sig_hld_reg_n_0_[22]\,
      Q => \^wcmd_sig\(1)
    );
\wcmd_sig_reg[29]\: unisim.vcomponents.FDCE
     port map (
      C => clkin,
      CE => \wcmd_sig[31]_i_1_n_0\,
      CLR => \bram_addr_10bit[9]_i_2_n_0\,
      D => \wcmd_sig_hld_reg_n_0_[29]\,
      Q => \^wcmd_sig\(2)
    );
\wcmd_sig_reg[30]\: unisim.vcomponents.FDCE
     port map (
      C => clkin,
      CE => \wcmd_sig[31]_i_1_n_0\,
      CLR => \bram_addr_10bit[9]_i_2_n_0\,
      D => \wcmd_sig_hld_reg_n_0_[30]\,
      Q => \^wcmd_sig\(3)
    );
\wcmd_sig_reg[31]\: unisim.vcomponents.FDCE
     port map (
      C => clkin,
      CE => \wcmd_sig[31]_i_1_n_0\,
      CLR => \bram_addr_10bit[9]_i_2_n_0\,
      D => p_2_out(31),
      Q => \^wcmd_sig\(4)
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity zcu104_pspl_bramctrl_0_0 is
  port (
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
  attribute NotValidForBitStream : boolean;
  attribute NotValidForBitStream of zcu104_pspl_bramctrl_0_0 : entity is true;
  attribute CHECK_LICENSE_TYPE : string;
  attribute CHECK_LICENSE_TYPE of zcu104_pspl_bramctrl_0_0 : entity is "zcu104_pspl_bramctrl_0_0,pspl_bramctrl,{}";
  attribute DowngradeIPIdentifiedWarnings : string;
  attribute DowngradeIPIdentifiedWarnings of zcu104_pspl_bramctrl_0_0 : entity is "yes";
  attribute IP_DEFINITION_SOURCE : string;
  attribute IP_DEFINITION_SOURCE of zcu104_pspl_bramctrl_0_0 : entity is "module_ref";
  attribute X_CORE_INFO : string;
  attribute X_CORE_INFO of zcu104_pspl_bramctrl_0_0 : entity is "pspl_bramctrl,Vivado 2019.2";
end zcu104_pspl_bramctrl_0_0;

architecture STRUCTURE of zcu104_pspl_bramctrl_0_0 is
  signal \<const0>\ : STD_LOGIC;
  signal \<const1>\ : STD_LOGIC;
  signal \^bram_addr\ : STD_LOGIC_VECTOR ( 9 downto 0 );
  signal \^bramw_addr\ : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal \^bramw_web\ : STD_LOGIC_VECTOR ( 2 to 2 );
  signal \^wcmd_sig\ : STD_LOGIC_VECTOR ( 31 downto 14 );
  attribute X_INTERFACE_INFO : string;
  attribute X_INTERFACE_INFO of clkin : signal is "xilinx.com:signal:clock:1.0 clkin CLK";
  attribute X_INTERFACE_PARAMETER : string;
  attribute X_INTERFACE_PARAMETER of clkin : signal is "XIL_INTERFACENAME clkin, FREQ_HZ 100000000, PHASE 0.000, CLK_DOMAIN zcu104_zynq_ultra_ps_e_0_0_pl_clk0, INSERT_VIP 0";
begin
  bram_addr(31) <= \<const0>\;
  bram_addr(30) <= \<const0>\;
  bram_addr(29) <= \<const0>\;
  bram_addr(28) <= \<const0>\;
  bram_addr(27) <= \<const0>\;
  bram_addr(26) <= \<const0>\;
  bram_addr(25) <= \<const0>\;
  bram_addr(24) <= \<const0>\;
  bram_addr(23) <= \<const0>\;
  bram_addr(22) <= \<const0>\;
  bram_addr(21) <= \<const0>\;
  bram_addr(20) <= \<const0>\;
  bram_addr(19) <= \<const0>\;
  bram_addr(18) <= \<const0>\;
  bram_addr(17) <= \<const0>\;
  bram_addr(16) <= \<const0>\;
  bram_addr(15) <= \<const0>\;
  bram_addr(14) <= \<const0>\;
  bram_addr(13) <= \<const0>\;
  bram_addr(12) <= \<const0>\;
  bram_addr(11) <= \<const0>\;
  bram_addr(10) <= \<const0>\;
  bram_addr(9 downto 0) <= \^bram_addr\(9 downto 0);
  bram_web(3) <= \<const0>\;
  bram_web(2) <= \<const0>\;
  bram_web(1) <= \<const0>\;
  bram_web(0) <= \<const0>\;
  bramw_addr(31) <= \<const0>\;
  bramw_addr(30) <= \<const0>\;
  bramw_addr(29) <= \<const0>\;
  bramw_addr(28) <= \<const0>\;
  bramw_addr(27) <= \<const0>\;
  bramw_addr(26) <= \<const0>\;
  bramw_addr(25) <= \<const0>\;
  bramw_addr(24) <= \<const0>\;
  bramw_addr(23) <= \<const0>\;
  bramw_addr(22) <= \<const0>\;
  bramw_addr(21) <= \<const0>\;
  bramw_addr(20) <= \<const0>\;
  bramw_addr(19) <= \<const0>\;
  bramw_addr(18) <= \<const0>\;
  bramw_addr(17) <= \<const0>\;
  bramw_addr(16) <= \<const0>\;
  bramw_addr(15) <= \<const0>\;
  bramw_addr(14) <= \<const0>\;
  bramw_addr(13) <= \<const0>\;
  bramw_addr(12) <= \<const0>\;
  bramw_addr(11) <= \<const0>\;
  bramw_addr(10) <= \<const0>\;
  bramw_addr(9) <= \<const0>\;
  bramw_addr(8) <= \<const0>\;
  bramw_addr(7) <= \<const0>\;
  bramw_addr(6) <= \<const0>\;
  bramw_addr(5) <= \<const0>\;
  bramw_addr(4) <= \<const0>\;
  bramw_addr(3) <= \<const0>\;
  bramw_addr(2) <= \^bramw_addr\(1);
  bramw_addr(1 downto 0) <= \^bramw_addr\(1 downto 0);
  bramw_enb <= \<const1>\;
  bramw_web(3) <= \^bramw_web\(2);
  bramw_web(2) <= \^bramw_web\(2);
  bramw_web(1) <= \^bramw_web\(2);
  bramw_web(0) <= \^bramw_web\(2);
  wcmd_sig(31 downto 29) <= \^wcmd_sig\(31 downto 29);
  wcmd_sig(28) <= \<const0>\;
  wcmd_sig(27) <= \<const0>\;
  wcmd_sig(26) <= \<const0>\;
  wcmd_sig(25) <= \<const0>\;
  wcmd_sig(24) <= \<const0>\;
  wcmd_sig(23) <= \<const0>\;
  wcmd_sig(22) <= \^wcmd_sig\(22);
  wcmd_sig(21) <= \<const0>\;
  wcmd_sig(20) <= \<const0>\;
  wcmd_sig(19) <= \<const0>\;
  wcmd_sig(18) <= \<const0>\;
  wcmd_sig(17) <= \<const0>\;
  wcmd_sig(16) <= \<const0>\;
  wcmd_sig(15) <= \<const0>\;
  wcmd_sig(14) <= \^wcmd_sig\(14);
  wcmd_sig(13) <= \<const0>\;
  wcmd_sig(12) <= \<const0>\;
  wcmd_sig(11) <= \<const0>\;
  wcmd_sig(10) <= \<const0>\;
  wcmd_sig(9) <= \<const0>\;
  wcmd_sig(8) <= \<const0>\;
  wcmd_sig(7) <= \<const0>\;
  wcmd_sig(6) <= \<const0>\;
  wcmd_sig(5) <= \<const0>\;
  wcmd_sig(4) <= \<const0>\;
  wcmd_sig(3) <= \<const0>\;
  wcmd_sig(2) <= \<const0>\;
  wcmd_sig(1) <= \<const0>\;
  wcmd_sig(0) <= \<const0>\;
  bram_dout(0) <= 'Z';
  bram_dout(1) <= 'Z';
  bram_dout(2) <= 'Z';
  bram_dout(3) <= 'Z';
  bram_dout(4) <= 'Z';
  bram_dout(5) <= 'Z';
  bram_dout(6) <= 'Z';
  bram_dout(7) <= 'Z';
  bram_dout(8) <= 'Z';
  bram_dout(9) <= 'Z';
  bram_dout(10) <= 'Z';
  bram_dout(11) <= 'Z';
  bram_dout(12) <= 'Z';
  bram_dout(13) <= 'Z';
  bram_dout(14) <= 'Z';
  bram_dout(15) <= 'Z';
  bram_dout(16) <= 'Z';
  bram_dout(17) <= 'Z';
  bram_dout(18) <= 'Z';
  bram_dout(19) <= 'Z';
  bram_dout(20) <= 'Z';
  bram_dout(21) <= 'Z';
  bram_dout(22) <= 'Z';
  bram_dout(23) <= 'Z';
  bram_dout(24) <= 'Z';
  bram_dout(25) <= 'Z';
  bram_dout(26) <= 'Z';
  bram_dout(27) <= 'Z';
  bram_dout(28) <= 'Z';
  bram_dout(29) <= 'Z';
  bram_dout(30) <= 'Z';
  bram_dout(31) <= 'Z';
GND: unisim.vcomponents.GND
     port map (
      G => \<const0>\
    );
VCC: unisim.vcomponents.VCC
     port map (
      P => \<const1>\
    );
inst: entity work.zcu104_pspl_bramctrl_0_0_pspl_bramctrl
     port map (
      Q(2) => usr_pv_en,
      Q(1) => usr_bess_en,
      Q(0) => usr_exp_prio,
      arst_n => arst_n,
      bess_bram_rdataflg => bess_bram_rdataflg,
      bess_fault_r(7 downto 0) => bess_fault_r(7 downto 0),
      bess_islandmode_r => bess_islandmode_r,
      bess_maxchgpwr_r(31 downto 0) => bess_maxchgpwr_r(31 downto 0),
      bess_maxdschgpwr_r(31 downto 0) => bess_maxdschgpwr_r(31 downto 0),
      bess_p_w(31 downto 0) => bess_p_w(31 downto 0),
      bess_pvld_w => bess_pvld_w,
      bess_rdata_vld => bess_rdata_vld,
      bess_soc_r(31 downto 0) => bess_soc_r(31 downto 0),
      bess_status_r(6 downto 0) => bess_status_r(6 downto 0),
      bram_addr(9 downto 0) => \^bram_addr\(9 downto 0),
      bram_din(31 downto 0) => bram_din(31 downto 0),
      bram_enb => bram_enb,
      bramw_addr(1 downto 0) => \^bramw_addr\(1 downto 0),
      bramw_dout(31 downto 0) => bramw_dout(31 downto 0),
      bramw_web(0) => \^bramw_web\(2),
      clkin => clkin,
      meter_bram_rdataflg => meter_bram_rdataflg,
      meter_poi_3p(31 downto 0) => meter_poi_3p(31 downto 0),
      meter_poi_3q(31 downto 0) => meter_poi_3q(31 downto 0),
      meter_poi_3s(31 downto 0) => meter_poi_3s(31 downto 0),
      meter_poi_freq(31 downto 0) => meter_poi_freq(31 downto 0),
      meter_poi_ia(31 downto 0) => meter_poi_ia(31 downto 0),
      meter_poi_ib(31 downto 0) => meter_poi_ib(31 downto 0),
      meter_poi_ic(31 downto 0) => meter_poi_ic(31 downto 0),
      meter_poi_in(31 downto 0) => meter_poi_in(31 downto 0),
      meter_poi_pf(31 downto 0) => meter_poi_pf(31 downto 0),
      meter_poi_vab(31 downto 0) => meter_poi_vab(31 downto 0),
      meter_poi_vbc(31 downto 0) => meter_poi_vbc(31 downto 0),
      meter_poi_vca(31 downto 0) => meter_poi_vca(31 downto 0),
      meter_rdata_vld => meter_rdata_vld,
      pspl_wcmd_bsy => pspl_wcmd_bsy,
      pv_bram_rdataflg => pv_bram_rdataflg,
      pv_fault_r(7 downto 0) => pv_fault_r(7 downto 0),
      pv_p_w(31 downto 0) => pv_p_w(31 downto 0),
      pv_pvld_w => pv_pvld_w,
      pv_rdata_vld => pv_rdata_vld,
      pv_status_r(7 downto 0) => pv_status_r(7 downto 0),
      pv_var_r(31 downto 0) => pv_var_r(31 downto 0),
      pv_watt_r(31 downto 0) => pv_watt_r(31 downto 0),
      pv_wattsp_r(31 downto 0) => pv_wattsp_r(31 downto 0),
      pv_yield_r(31 downto 0) => pv_yield_r(31 downto 0),
      usr_bess_kd(31 downto 0) => usr_bess_kd(31 downto 0),
      usr_bess_ki(31 downto 0) => usr_bess_ki(31 downto 0),
      usr_bess_kp(31 downto 0) => usr_bess_kp(31 downto 0),
      usr_bess_maxsoc(31 downto 0) => usr_bess_maxsoc(31 downto 0),
      usr_bess_minsoc(31 downto 0) => usr_bess_minsoc(31 downto 0),
      usr_besschrg_lmt(31 downto 0) => usr_besschrg_lmt(31 downto 0),
      usr_bessdsch_lmt(31 downto 0) => usr_bessdsch_lmt(31 downto 0),
      usr_exp_lmt(31 downto 0) => usr_exp_lmt(31 downto 0),
      usr_imp_lmt(31 downto 0) => usr_imp_lmt(31 downto 0),
      usr_param_vld => usr_param_vld,
      usr_pv_kd(31 downto 0) => usr_pv_kd(31 downto 0),
      usr_pv_ki(31 downto 0) => usr_pv_ki(31 downto 0),
      usr_pv_kp(31 downto 0) => usr_pv_kp(31 downto 0),
      usr_pv_max(31 downto 0) => usr_pv_max(31 downto 0),
      usrparam_bram_rdataflg => usrparam_bram_rdataflg,
      wcmd_sig(4 downto 2) => \^wcmd_sig\(31 downto 29),
      wcmd_sig(1) => \^wcmd_sig\(22),
      wcmd_sig(0) => \^wcmd_sig\(14)
    );
end STRUCTURE;
