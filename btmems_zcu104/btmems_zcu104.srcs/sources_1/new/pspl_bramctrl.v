`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Syed Fahad Akhtar
// 
// Create Date: 04/17/2021 06:35:27 AM
// Design Name: 
// Module Name: pspl_bramctrl
// Project Name: EMS
// Target Devices: 
// Tool Versions: 
// Description: PS_PL BRAM Read/Write Module
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 1 - note that usr_param_vld is only a place holder and is not used anywhere outside of this module for now. If in future it is desired to have all the parameters 
// updated at the same time (to avoid any logic issues), first read bram data into a temporary bus and then transfer contents from temp bus to each user parameter 
// register when usr_param_vld is asserted 
// 2 - If there are too many write commands and if you run into timing issue due to long else if strucutre, just break it over two or more pipeline stages
// 3 - Note that if there is an unprocessed breaker open command (which is mapped to bit 0 of this address location), it wont be overwritten with 0 since 
//     write enable for lower most byte is set to 0.  
//////////////////////////////////////////////////////////////////////////////////

`include "defines.vh"

//Masking of write command status register to corresponding commands 
`define WCMD_STAT_TGL           0    //Toggle bit for interupt generation every time a new command is sent
`define WCMD_STAT_BESS          1    //BESS command indication
`define WCMD_STAT_PV            2    //PV command indicaiton
`define WCMD_STAT_Gen           3    //Genset command indicaiton
`define WCMD_STAT_Rly           4    //Relay command indicaiton
                                     //Leaving bit 5-9 for other types of assets 
`define WCMD_STAT_BESSrun       10    //BESS start command
`define WCMD_STAT_BESSp         11    //BESS P command
`define WCMD_STAT_BESSq         12    //BESS Q command
`define WCMD_STAT_BESSpf        13    //BESS PF command
`define WCMD_STAT_BESSqtyp      14    //BESS Q type command
`define WCMD_STAT_BESSislnd     15    //BESS island (grid forming) command
`define WCMD_STAT_BESSfrq       16    //BESS island freq command
`define WCMD_STAT_BESSvlt       17    //BESS island volt command
`define WCMD_STAT_PVrun         18    //PV start command
`define WCMD_STAT_PVp           19    //PV P command
`define WCMD_STAT_PVq           20    //PV Q command
`define WCMD_STAT_PVpf          21    //PV PF command
`define WCMD_STAT_PVqtyp        22    //PV Q type command
`define WCMD_STAT_Genrun        23    //Genset start command
`define WCMD_STAT_Genp          24    //Genset P command
`define WCMD_STAT_Genq          25    //Genset Q command
`define WCMD_STAT_Genopmod      26    //Genset Operating Mode command
`define WCMD_STAT_Rlybkop       27    //Relay CB Open Command
`define WCMD_STAT_Rlybkcl       28    //Relay CB Close Command
                                      //bits 29-63 for future (note we are using 2 GPIO channels so total 64bits)

// `define WCMD_STAT_TGL           31    //Toggle bit for interupt generation every time a new command is sent
// `define WCMD_STAT_BESS          30    //BESS command indication
// `define WCMD_STAT_PV            29    //PV command indicaiton
// `define WCMD_STAT_BESSrun       23    //BESS start command
// `define WCMD_STAT_BESSp         22    //BESS P command
// `define WCMD_STAT_BESSq         21    //BESS Q command
// `define WCMD_STAT_BESSpf        20    //BESS PF command
// `define WCMD_STAT_BESSqtyp      19    //BESS Q type command
// `define WCMD_STAT_BESSislnd     18    //BESS island (grid forming) command
// `define WCMD_STAT_BESSfrq       17    //BESS island freq command
// `define WCMD_STAT_BESSvlt       16    //BESS island volt command
// `define WCMD_STAT_PVrun         15    //PV start command
// `define WCMD_STAT_PVp           14    //PV P command
// `define WCMD_STAT_PVq           13    //PV Q command
// `define WCMD_STAT_PVpf          12    //PV PF command
// `define WCMD_STAT_PVqtyp        11    //PV Q type command
// `define WCMD_STAT_Gen           10    //Genset command indicaiton
// `define WCMD_STAT_Genrun        9     //Genset start command
// `define WCMD_STAT_Genp          8     //Genset P command
// `define WCMD_STAT_Genq          7     //Genset Q command
// `define WCMD_STAT_Genopmod      6     //Genset Operating Mode command


module pspl_bramctrl(
    input                       clkin,
    input                       arst_n,
    
    //Data Read Back BRAM Interface
    input                       bess_bram_rdataflg,           //EMIO flag indicating PS has sent BESS read data into BRAM 
    input                       pv_bram_rdataflg,             //EMIO flag indicating PS has sent PV read data into BRAM
    input                       meter_bram_rdataflg,          //EMIO flag indicating PS has sent meter read data into BRAM
    input                       gen_bram_rdataflg,            //EMIO flag indicating PS has sent genset read data into BRAM
    input                       rly_bram_rdataflg,            //EMIO flag indicating PS has sent relay read data into BRAM
    input                       usrparam_bram_rdataflg,       //EMIO flag indicating PS has updated user parameters meter into BRAM
    input                       bessmeter_bram_rdataflg,      //EMIO flag indicating PS has sent bess meter read data into BRAM
    input                       pvmeter_bram_rdataflg,        //EMIO flag indicating PS has sent PV meter read data into BRAM
    input                       genmeter_bram_rdataflg,       //EMIO flag indicating PS has sent gen meter read data into BRAM
    input                       loadmeter_bram_rdataflg,      //EMIO flag indicating PS has sent load meter read data into BRAM

    output              [31:0]  bram_addr,
    input               [31:0]  bram_din,
    output              [31:0]  bram_dout,
    output reg                  bram_enb,
    output              [3:0]   bram_web,
    

    //Write Command Interface
    input                       pspl_wcmd_bsy,                //EMIO flag from PS indicating PS is busy fetching write command from BRAM
    //Write BRAM
    output              [31:0]  bramw_addr,
    input               [31:0]  bramw_din,
    output  reg         [31:0]  bramw_dout,
    output reg                  bramw_enb,
    output reg          [3:0]   bramw_web,
    //Write Command Signal
    output reg          [63:0]  wcmd_sig,

    //BESS Interface - "w" is data to be sent to BESS, "r" data readback from BESS
    input                       bess_run_w,
    input                       bess_runvld_w,
    input               [31:0]  bess_p_w,
    input                       bess_pvld_w,
    input               [31:0]  bess_q_w,
    input               [15:0]  bess_pf_w,
    input               [7:0]   bess_qtyp_w,
    input                       bess_islandmode_w,
    input                       bess_islandmodevld_w,
    input               [15:0]  bess_islandmodefrq_w,
    input                       bess_islandmodefrqvld_w,    
    input               [15:0]  bess_islandmodevolt_w,
    input                       bess_islandmodevoltvld_w,
    output reg          [6:0]   bess_status_r,
    output reg                  bess_islandmode_r,
    output reg          [7:0]   bess_fault_r,
    output reg          [31:0]  bess_soc_r,
    output reg          [31:0]  bess_wh_r,
    output reg          [31:0]  bess_maxdschgpwr_r,
    output reg          [31:0]  bess_maxchgpwr_r,
    output reg          [15:0]  bess_islandmodevolt_r,
    output reg          [15:0]  bess_islandmodefrq_r,
    output reg                  bess_rdata_vld,
    
    //PV INTERFACE
    input                       pv_run_w,
    input                       pv_runvld_w,
    input               [31:0]  pv_p_w,
    input                       pv_pvld_w,
    input               [31:0]  pv_q_w,
    input               [15:0]  pv_pf_w,
    input               [7:0]   pv_qtyp_w,
    output reg          [31:0]  pv_status_r,
    output reg          [31:0]  pv_fault_r,
    output reg          [31:0]  pv_wattsp_r,
    output reg          [31:0]  pv_watt_r,
    output reg          [31:0]  pv_var_r,
    output reg          [31:0]  pv_yield_r,
    output reg                  pv_rdata_vld,

    //POI Meter Interface
    output reg          [31:0]  meter_poi_3p,
    output reg          [31:0]  meter_poi_3q,
    output reg          [31:0]  meter_poi_3s,
    output reg          [31:0]  meter_poi_pf,
    output reg          [31:0]  meter_poi_ia,
    output reg          [31:0]  meter_poi_ib,
    output reg          [31:0]  meter_poi_ic,
    output reg          [31:0]  meter_poi_in,
    output reg          [31:0]  meter_poi_vab,
    output reg          [31:0]  meter_poi_vbc,
    output reg          [31:0]  meter_poi_vca,
    output reg          [31:0]  meter_poi_freq,
    output reg                  meter_rdata_vld,

    //Genset Interface
    input                       gen_run_w,
    input                       gen_runvld_w,
    input               [31:0]  gen_p_w,
    input                       gen_pvld_w,
    input               [31:0]  gen_q_w,
    input                       gen_qvld_w,
    input               [7:0]   gen_opmod_w,
    input                       gen_opmodvld_w,
    output reg          [31:0]  gen_status_r,
    output reg          [31:0]  gen_fault_r,
    output reg                  gen_rdata_vld,

    //POI Relay Interface
    input                       rly_brkop_w,
    input                       rly_brkopvld_w,
    input                       rly_brkcl_w,
    input                       rly_brkclvld_w,
    output reg          [31:0]  rly_protstat_r,
    output reg          [31:0]  rly_ioltchsv_r,
    output reg          [31:0]  rly_hwerr_r,
    output reg          [15:0]  rly_lvab_r,
    output reg          [15:0]  rly_lvbc_r,
    output reg          [15:0]  rly_lvca_r,
    output reg          [15:0]  rly_bvab_r,
    output reg          [15:0]  rly_bvbc_r,
    output reg          [15:0]  rly_bvca_r,
    output reg          [15:0]  rly_lfrq_r,
    output reg          [15:0]  rly_bfrq_r,
    output reg                  rly_rdata_vld,

    //BESS Meter Interface
    output reg          [31:0]  meter_bess_3p,
    output reg          [31:0]  meter_bess_3q,
    output reg          [31:0]  meter_bess_3s,
    output reg          [31:0]  meter_bess_pf,
    output reg          [31:0]  meter_bess_ia,
    output reg          [31:0]  meter_bess_ib,
    output reg          [31:0]  meter_bess_ic,
    output reg          [31:0]  meter_bess_in,
    output reg          [31:0]  meter_bess_vab,
    output reg          [31:0]  meter_bess_vbc,
    output reg          [31:0]  meter_bess_vca,
    output reg          [31:0]  meter_bess_freq,
    output reg                  meter_bessrdata_vld,

    //PV Meter Interface
    output reg          [31:0]  meter_pv_3p,
    output reg          [31:0]  meter_pv_3q,
    output reg          [31:0]  meter_pv_3s,
    output reg          [31:0]  meter_pv_pf,
    output reg          [31:0]  meter_pv_ia,
    output reg          [31:0]  meter_pv_ib,
    output reg          [31:0]  meter_pv_ic,
    output reg          [31:0]  meter_pv_in,
    output reg          [31:0]  meter_pv_vab,
    output reg          [31:0]  meter_pv_vbc,
    output reg          [31:0]  meter_pv_vca,
    output reg          [31:0]  meter_pv_freq,
    output reg                  meter_pvrdata_vld,

    //Genset Meter Interface
    output reg          [31:0]  meter_gen_3p,
    output reg          [31:0]  meter_gen_3q,
    output reg          [31:0]  meter_gen_3s,
    output reg          [31:0]  meter_gen_pf,
    output reg          [31:0]  meter_gen_ia,
    output reg          [31:0]  meter_gen_ib,
    output reg          [31:0]  meter_gen_ic,
    output reg          [31:0]  meter_gen_in,
    output reg          [31:0]  meter_gen_vab,
    output reg          [31:0]  meter_gen_vbc,
    output reg          [31:0]  meter_gen_vca,
    output reg          [31:0]  meter_gen_freq,
    output reg                  meter_genrdata_vld,

    //Load Meter Interface
    output reg          [31:0]  meter_load_3p,
    output reg          [31:0]  meter_load_3q,
    output reg          [31:0]  meter_load_3s,
    output reg          [31:0]  meter_load_pf,
    output reg          [31:0]  meter_load_ia,
    output reg          [31:0]  meter_load_ib,
    output reg          [31:0]  meter_load_ic,
    output reg          [31:0]  meter_load_in,
    output reg          [31:0]  meter_load_vab,
    output reg          [31:0]  meter_load_vbc,
    output reg          [31:0]  meter_load_vca,
    output reg          [31:0]  meter_load_freq,
    output reg                  meter_loadrdata_vld,

    //User Parameter Interface
    output reg          [31:0]  usr_imp_lmt,
    output reg          [31:0]  usr_exp_lmt,
    output reg          [31:0]  usr_besschrg_lmt,
    output reg          [31:0]  usr_bessdsch_lmt,
    output reg          [31:0]  usr_bess_kp,
    output reg          [31:0]  usr_bess_ki,
    output reg          [31:0]  usr_bess_kd,
    output reg          [31:0]  usr_pv_kp,
    output reg          [31:0]  usr_pv_ki,
    output reg          [31:0]  usr_pv_kd,
    output reg          [31:0]  usr_bess_maxsoc,
    output reg          [31:0]  usr_bess_minsoc,
    output reg          [31:0]  usr_net_load,
    output reg          [31:0]  usr_pv_max, 
    output              [7:0]   usr_ctrl_mode,
    output                      usr_exp_prio,
    output                      usr_bess_en,
    output                      usr_pv_en,
    output reg          [31:0]  usr_bessislnd_minwh,               
    output reg          [31:0]  usr_bessislnd_maxwh_ul,            
    output reg          [31:0]  usr_bessislnd_maxwh_ll,            
    output reg          [31:0]  usr_bessislndext_minwh,            
    output reg          [31:0]  usr_maxld_islnd,  
    output reg          [31:0]  usr_gen_baseld, 
    output reg          [31:0]  usr_grdhlthy_vmin,                 
    output reg          [31:0]  usr_grdhlthy_vmax,                 
    output reg          [31:0]  usr_grdhlthy_fmin,                 
    output reg          [31:0]  usr_grdhlthy_fmax,           
    output              [15:0]  usr_grdhlthy_dur,
    output                      usr_poibrkcl_cmd, 
    output                      usr_poibrkop_cmd,                 
    output                      usr_islnd_cmd,                                 
    output                      usr_gen_en,
    output                      usr_grid_resync,                   
    output                      usr_autoislnd_en,                  
    output                      usr_bess2gen_trnsf,                
    output                      usr_gen2bess_trnsf,                
    output                      usr_auto_resync,                   
    output                      usr_cltrns_resync,   
    output              [1:0]   usr_bess_gfmprio,                  
    output              [1:0]   usr_gen_gfmprio,    
    output                      usr_shut_down,            
    output reg                  usr_param_vld  

    );

wire    [15:0]   pspl_rdata_sig_array;

reg             bess_rdata_sig;
reg             pv_rdata_sig;
reg             meter_rdata_sig;
reg             usrparam_rdata_sig;
reg             gen_rdata_sig;
reg             rly_rdata_sig;
reg             bessmeter_rdata_sig;
reg             pvmeter_rdata_sig;
reg             genmeter_rdata_sig;
reg             loadmeter_rdata_sig;
reg     [9:0]   bram_addr_10bit;
reg     [9:0]   bramw_addr_10bit;
reg     [1:0]   state;
reg     [3:0]   state_bess_r;
reg     [3:0]   state_pv_r;
reg     [3:0]   state_meter_r;
reg     [5:0]   state_usrparam_r;
reg     [2:0]   state_gen_r;
reg     [3:0]   state_rly_r;
reg     [3:0]   state_bessmeter_r;
reg     [3:0]   state_pvmeter_r;
reg     [3:0]   state_genmeter_r;
reg     [3:0]   state_loadmeter_r;
reg     [1:0]   state_wcmd;
reg     [9:0]   bess_bram_addr;
reg     [9:0]   pv_bram_addr;
reg     [9:0]   meter_bram_addr;
reg     [9:0]   usrparam_bram_addr;
reg     [9:0]   gen_bram_addr;
reg     [9:0]   rly_bram_addr;
reg     [9:0]   bessmeter_bram_addr;
reg     [9:0]   pvmeter_bram_addr;
reg     [9:0]   genmeter_bram_addr;
reg     [9:0]   loadmeter_bram_addr;
reg     [31:0]  usr_cmd_reg;
reg     [63:0]  wcmd_sig_lastcmd;
reg     [63:0]  wcmd_sig_hld;
reg     [31:0]  bess_p_w_ltch;
reg     [31:0]  pv_p_w_ltch;
reg             bess_bram_enb;
reg             pv_bram_enb;
reg             meter_bram_enb;
reg             usrparam_bram_enb;
reg             gen_bram_enb;
reg             rly_bram_enb;
reg             bessmeter_bram_enb;
reg             pvmeter_bram_enb;
reg             genmeter_bram_enb;
reg             loadmeter_bram_enb;
reg             bess_pvld_wltch;
reg             pv_pvld_wltch;
reg             pspl_wcmd_bsyreg;
reg     [31:0]  usr_timer_reg;
reg             rly_brkop_w_ltch;
reg             rly_brkopvld_w_ltch;
reg             rly_brkcl_w_ltch;
reg             rly_brkclvld_w_ltch;
reg             bess_islandmode_w_ltch;
reg             bess_islandmodevld_w_ltch;
reg     [15:0]  bess_islandmodevolt_w_ltch;
reg             bess_islandmodevoltvld_w_ltch;
reg             bess_islandmodefrqvld_w_ltch;
reg     [15:0]  bess_islandmodefrq_w_ltch;
reg     [7:0]   gen_opmod_w_ltch;
reg             gen_opmodvld_w_ltch;
reg             gen_run_w_ltch;
reg             gen_runvld_w_ltch;

localparam 
    BESS_RDATA_STRTADDR             = 10'd0,    //starting address of BESS read data in PSPL BRAM
    PV_RDATA_STRTADDR               = 10'd40,   //starting address of PV read data in PSPL BRAM
    METER_RDATA_STRTADDR            = 10'd80,   //starting address of POI Meter read data in PSPL BRAM
    GEN_RDATA_STRTADDR              = 10'd128,  //starting address of Genset read data in PSPL BRAM
    RLY_RDATA_STRTADDR              = 10'd168,  //starting address of Relay read data in PSPL BRAM
    BESSMETER_RDATA_STRTADDR        = 10'd208,  //starting address of BESS Meter read data in PSPL BRAM
    PVMETER_RDATA_STRTADDR          = 10'd256,  //starting address of PV Meter read data in PSPL BRAM
    GENMETER_RDATA_STRTADDR         = 10'd304,  //starting address of Genset Meter read data in PSPL BRAM
    LOADMETER_RDATA_STRTADDR        = 10'd352,  //starting address of Load Meter read data in PSPL BRAM
    USRPARAM_RDATA_STRTADDR         = 10'd392,  //starting address of User Parameters read data in PSPL BRAM

    //Mapping of Write BRAM Address for Commands
    //Mapping of Address 0: Bit 0->BESS Run/Stop Command, Bit 8->BESS Island Command
    WBRAMADDR_BESS_RUN      = 10'd0,    //Write BRAM Addr for BESS Run Command, this addresss will be shared by all single bit BESS commands 
    WBRAMADDR_BESS_ISLND    = 10'd0,    //Write BRAM Addr for BESS Island (GFM or GFL) Command
 
    WBRAMADDR_BESS_P        = 10'd1,    //Write BRAM Addr for BESS P Command
    WBRAMADDR_BESS_Q        = 10'd2,    //Write BRAM Addr for BESS Q Command
    WBRAMADDR_BESS_PF       = 10'd3,    //Write BRAM Addr for BESS PF Command
    WBRAMADDR_BESS_QTYP     = 10'd3,    //Write BRAM Addr for BESS Q type Command (memory location is shared with PF since PF is only 16bits)
    WBRAMADDR_BESS_V       =  10'd4,    //Write BRAM Addr for BESS Volt Command
    WBRAMADDR_BESS_F       =  10'd4,    //Write BRAM Addr for BESS Freq Command, Memory location shared with Vref since both are 16bits


    WBRAMADDR_PV_RUN        = 10'd5,    //Write BRAM Addr for PV Run Command, , this address will be shared by all single bit PV commands 
    WBRAMADDR_PV_P          = 10'd6,    //Write BRAM Addr for PV P Command
    WBRAMADDR_PV_Q          = 10'd7,    //Write BRAM Addr for PV Q Command
    WBRAMADDR_PV_PF         = 10'd8,    //Write BRAM Addr for PV PF Command
    WBRAMADDR_PV_QTYP       = 10'd8,    //Write BRAM Addr for PV Q type Command (memory location is shared with PF since PF is only 16bits)

    WBRAMADDR_GEN_RUN       = 10'd9,    //Write BRAM Addr for Genset Run Command, this addresss will be shared by all single bit Genset commands
    WBRAMADDR_GEN_OPMOD     = 10'd9,    //Write BRAM Addr for Genset Operating Mode Command
    WBRAMADDR_GEN_P         = 10'd10,   //Write BRAM Addr for Genset P Command
    WBRAMADDR_GEN_Q         = 10'd11,   //Write BRAM Addr for Genset Q Command

    //Mapping of Address 12: Bit 0->Breaker Open, Bit 8->Breaker Close
    WBRAMADDR_RLY_BRKOP     = 10'd12,    //Write BRAM Addr for relay breaker open Command, this addresss will be shared by multiple single bit commands to relay
    WBRAMADDR_RLY_BRKCL     = 10'd12,    //Write BRAM Addr for relay breaker close Command

	ST_IDLE		                = 2'b00,
	ST_1SHOT	                = 2'b01,
	
	//BESS read state machine
	ST_BESS_R_IDLE		        = 4'b0000,
	ST_BESS_R_INTRM             = 4'b0001, 
	ST_BESS_R_REG1	            = 4'b0010,	
    ST_BESS_R_REG2	            = 4'b0011,
    ST_BESS_R_REG3	            = 4'b0100,
    ST_BESS_R_REG4	            = 4'b0101,
    ST_BESS_R_REG5	            = 4'b0110,
    ST_BESS_R_REG6	            = 4'b0111,
    ST_BESS_R_REG7	            = 4'b1000,
    ST_BESS_R_VLD	            = 4'b1001,
    
    //PV read state machine
	ST_PV_R_IDLE		        = 4'b0000,
	ST_PV_R_INTRM               = 4'b0001, 
	ST_PV_R_REG1	            = 4'b0010,	
    ST_PV_R_REG2	            = 4'b0011,
    ST_PV_R_REG3	            = 4'b0100,
    ST_PV_R_REG4	            = 4'b0101,
    ST_PV_R_REG5	            = 4'b0110,
    ST_PV_R_REG6	            = 4'b0111,
    ST_PV_R_VLD	                = 4'b1000,
    ST_PV_R_REG2_1	            = 4'b1001,


    //Meter read state machine
	ST_METER_R_IDLE		        = 4'd0,
	ST_METER_R_INTRM            = 4'd1, 
	ST_METER_R_REG1	            = 4'd2,	
    ST_METER_R_REG2	            = 4'd3,
    ST_METER_R_REG3	            = 4'd4,
    ST_METER_R_REG4	            = 4'd5,
    ST_METER_R_REG5	            = 4'd6,
	ST_METER_R_REG6	            = 4'd7,	
    ST_METER_R_REG7	            = 4'd8,
    ST_METER_R_REG8	            = 4'd9,
    ST_METER_R_REG9	            = 4'd10,
    ST_METER_R_REG10	        = 4'd11,
    ST_METER_R_REG11	        = 4'd12,
    ST_METER_R_REG12	        = 4'd13,
    ST_METER_R_REG13	        = 4'd14,
    ST_METER_R_VLD	            = 4'd15,
    
    //User parameters read state machine
    //using 6 bits, to have room for up to 64 user parameter registers
	ST_USRPARAM_R_IDLE		        = 6'd0,
	ST_USRPARAM_R_INTRM             = 6'd1, 
	ST_USRPARAM_R_REG1	            = 6'd2,	
    ST_USRPARAM_R_REG2	            = 6'd3,
    ST_USRPARAM_R_REG3	            = 6'd4,
    ST_USRPARAM_R_REG4	            = 6'd5,
    ST_USRPARAM_R_REG5	            = 6'd6,
	ST_USRPARAM_R_REG6	            = 6'd7,	
    ST_USRPARAM_R_REG7	            = 6'd8,
    ST_USRPARAM_R_REG8	            = 6'd9,
    ST_USRPARAM_R_REG9	            = 6'd10,
    ST_USRPARAM_R_REG10	            = 6'd11,
    ST_USRPARAM_R_REG11	            = 6'd12,
    ST_USRPARAM_R_REG12	            = 6'd13,
    ST_USRPARAM_R_REG13	            = 6'd14,
    ST_USRPARAM_R_REG14	            = 6'd15,
    ST_USRPARAM_R_REG15	            = 6'd16,
    ST_USRPARAM_R_REG16	            = 6'd17,
    ST_USRPARAM_R_REG17	            = 6'd18,
    ST_USRPARAM_R_REG18	            = 6'd19,
    ST_USRPARAM_R_REG19	            = 6'd20,
    ST_USRPARAM_R_REG20	            = 6'd21,
    ST_USRPARAM_R_REG21	            = 6'd22,
    ST_USRPARAM_R_REG22	            = 6'd23,
    ST_USRPARAM_R_REG23	            = 6'd24,
    ST_USRPARAM_R_REG24	            = 6'd25,
    ST_USRPARAM_R_REG25	            = 6'd26,
    ST_USRPARAM_R_REG26	            = 6'd27,
    ST_USRPARAM_R_REG27	            = 6'd28,
    ST_USRPARAM_R_VLD	            = 6'd29,

    //Genset read state machine
	ST_GEN_R_IDLE		        = 3'b000,
	ST_GEN_R_INTRM              = 3'b001, 
	ST_GEN_R_REG1	            = 3'b010,	
    ST_GEN_R_REG2	            = 3'b011,
    ST_GEN_R_REG3	            = 3'b100,
    ST_GEN_R_VLD	            = 3'b101,

    //Relay read state machine
	ST_RLY_R_IDLE		        = 4'd0,
	ST_RLY_R_INTRM              = 4'd1, 
	ST_RLY_R_REG1	            = 4'd2,	
    ST_RLY_R_REG2	            = 4'd3,
    ST_RLY_R_REG3	            = 4'd4,
    ST_RLY_R_REG4	            = 4'd5,
    ST_RLY_R_REG5	            = 4'd6,
	ST_RLY_R_REG6	            = 4'd7,	
    ST_RLY_R_REG7	            = 4'd8,
    ST_RLY_R_REG8	            = 4'd9,
    ST_RLY_R_VLD	            = 4'd10,

    //BESS Meter read state machine
	ST_BESSMETER_R_IDLE		        = 4'd0,
	ST_BESSMETER_R_INTRM            = 4'd1, 
	ST_BESSMETER_R_REG1	            = 4'd2,	
    ST_BESSMETER_R_REG2	            = 4'd3,
    ST_BESSMETER_R_REG3	            = 4'd4,
    ST_BESSMETER_R_REG4	            = 4'd5,
    ST_BESSMETER_R_REG5	            = 4'd6,
	ST_BESSMETER_R_REG6	            = 4'd7,	
    ST_BESSMETER_R_REG7	            = 4'd8,
    ST_BESSMETER_R_REG8	            = 4'd9,
    ST_BESSMETER_R_REG9	            = 4'd10,
    ST_BESSMETER_R_REG10	        = 4'd11,
    ST_BESSMETER_R_REG11	        = 4'd12,
    ST_BESSMETER_R_REG12	        = 4'd13,
    ST_BESSMETER_R_REG13	        = 4'd14,
    ST_BESSMETER_R_VLD	            = 4'd15,

    //PV Meter read state machine
	ST_PVMETER_R_IDLE		        = 4'd0,
	ST_PVMETER_R_INTRM              = 4'd1, 
	ST_PVMETER_R_REG1	            = 4'd2,	
    ST_PVMETER_R_REG2	            = 4'd3,
    ST_PVMETER_R_REG3	            = 4'd4,
    ST_PVMETER_R_REG4	            = 4'd5,
    ST_PVMETER_R_REG5	            = 4'd6,
	ST_PVMETER_R_REG6	            = 4'd7,	
    ST_PVMETER_R_REG7	            = 4'd8,
    ST_PVMETER_R_REG8	            = 4'd9,
    ST_PVMETER_R_REG9	            = 4'd10,
    ST_PVMETER_R_REG10	            = 4'd11,
    ST_PVMETER_R_REG11	            = 4'd12,
    ST_PVMETER_R_REG12	            = 4'd13,
    ST_PVMETER_R_REG13	            = 4'd14,
    ST_PVMETER_R_VLD	            = 4'd15,

    //Genset Meter read state machine
	ST_GENMETER_R_IDLE		        = 4'd0,
	ST_GENMETER_R_INTRM             = 4'd1, 
	ST_GENMETER_R_REG1	            = 4'd2,	
    ST_GENMETER_R_REG2	            = 4'd3,
    ST_GENMETER_R_REG3	            = 4'd4,
    ST_GENMETER_R_REG4	            = 4'd5,
    ST_GENMETER_R_REG5	            = 4'd6,
	ST_GENMETER_R_REG6	            = 4'd7,	
    ST_GENMETER_R_REG7	            = 4'd8,
    ST_GENMETER_R_REG8	            = 4'd9,
    ST_GENMETER_R_REG9	            = 4'd10,
    ST_GENMETER_R_REG10	            = 4'd11,
    ST_GENMETER_R_REG11	            = 4'd12,
    ST_GENMETER_R_REG12	            = 4'd13,
    ST_GENMETER_R_REG13	            = 4'd14,
    ST_GENMETER_R_VLD	            = 4'd15,

    //Load Meter read state machine
	ST_LOADMETER_R_IDLE		        = 4'd0,
	ST_LOADMETER_R_INTRM            = 4'd1, 
	ST_LOADMETER_R_REG1	            = 4'd2,	
    ST_LOADMETER_R_REG2	            = 4'd3,
    ST_LOADMETER_R_REG3	            = 4'd4,
    ST_LOADMETER_R_REG4	            = 4'd5,
    ST_LOADMETER_R_REG5	            = 4'd6,
	ST_LOADMETER_R_REG6	            = 4'd7,	
    ST_LOADMETER_R_REG7	            = 4'd8,
    ST_LOADMETER_R_REG8	            = 4'd9,
    ST_LOADMETER_R_REG9	            = 4'd10,
    ST_LOADMETER_R_REG10	        = 4'd11,
    ST_LOADMETER_R_REG11	        = 4'd12,
    ST_LOADMETER_R_REG12	        = 4'd13,
    ST_LOADMETER_R_REG13	        = 4'd14,
    ST_LOADMETER_R_VLD	            = 4'd15,

    //Write command BRAM state machine
    ST_WCMD_LOOP        = 2'd0,
    ST_WCMD_SIG         = 2'd1;            

assign bram_web = 4'd0;
assign pspl_rdata_sig_array = {6'd0,loadmeter_bram_rdataflg,genmeter_bram_rdataflg,pvmeter_bram_rdataflg,bessmeter_bram_rdataflg,rly_bram_rdataflg,
                               gen_bram_rdataflg,usrparam_bram_rdataflg,meter_bram_rdataflg,pv_bram_rdataflg,bess_bram_rdataflg};

assign bram_addr = {22'd0,bram_addr_10bit};

assign bramw_addr = {22'd0,bramw_addr_10bit};

//User Command Register Mapping
assign usr_exp_prio = usr_cmd_reg[0];
assign usr_bess_en = usr_cmd_reg[1];
assign usr_pv_en = usr_cmd_reg[2];
assign usr_gen_en = usr_cmd_reg[3];

assign usr_bess_gfmprio = usr_cmd_reg[5:4];
assign usr_gen_gfmprio = usr_cmd_reg[7:6];


assign usr_autoislnd_en = usr_cmd_reg[8];
assign usr_auto_resync = usr_cmd_reg[9];
assign usr_cltrns_resync = usr_cmd_reg[10];
assign usr_islnd_cmd = usr_cmd_reg[11];
assign usr_grid_resync = usr_cmd_reg[12];
assign usr_bess2gen_trnsf = usr_cmd_reg[13];
assign usr_gen2bess_trnsf = usr_cmd_reg[14];
assign usr_poibrkcl_cmd = usr_cmd_reg[15];
assign usr_poibrkop_cmd = usr_cmd_reg[16];
assign usr_shut_down = usr_cmd_reg[17];
assign usr_ctrl_mode = usr_cmd_reg[31:24];

assign usr_grdhlthy_dur = usr_timer_reg[15:0]; 

always @ (posedge clkin or negedge arst_n)
begin
    if (~arst_n)
    begin
        bram_addr_10bit   <= #`adly 10'd0;
        bram_enb    <= #`adly 1'b0;
    end
    else
    begin
        bram_addr_10bit   <= #`adly bess_bram_addr | pv_bram_addr | meter_bram_addr | usrparam_bram_addr | gen_bram_addr | rly_bram_addr |
                                    bessmeter_bram_addr | pvmeter_bram_addr | genmeter_bram_addr | loadmeter_bram_addr;
        bram_enb    <= #`adly bess_bram_enb | pv_bram_enb | meter_bram_enb | usrparam_bram_enb | gen_bram_enb | rly_bram_enb |
                              bessmeter_bram_enb | pvmeter_bram_enb | genmeter_bram_enb | loadmeter_bram_enb;
    end   
end           

always @ (posedge clkin or negedge arst_n)
begin
    if (~arst_n)
    begin
        bess_rdata_sig          <= #`adly 1'b0;
        pv_rdata_sig            <= #`adly 1'b0;
        meter_rdata_sig         <= #`adly 1'b0;
        usrparam_rdata_sig      <= #`adly 1'b0;
        gen_rdata_sig           <= #`adly 1'b0;
        rly_rdata_sig           <= #`adly 1'b0;
        bessmeter_rdata_sig     <= #`adly 1'b0;
        pvmeter_rdata_sig       <= #`adly 1'b0;
        genmeter_rdata_sig      <= #`adly 1'b0;
        loadmeter_rdata_sig     <= #`adly 1'b0;
        state                   <= #`adly ST_IDLE;
    end
    else
    begin
        case (state)
        ST_IDLE:
        begin
            (* parallel_case *)
            case (pspl_rdata_sig_array)
                16'd1: begin
                        bess_rdata_sig          <= #`adly 1'b1;
                        pv_rdata_sig            <= #`adly 1'b0;
                        meter_rdata_sig         <= #`adly 1'b0;
                        usrparam_rdata_sig      <= #`adly 1'b0;
                        gen_rdata_sig           <= #`adly 1'b0;
                        rly_rdata_sig           <= #`adly 1'b0;
                        bessmeter_rdata_sig     <= #`adly 1'b0;
                        pvmeter_rdata_sig       <= #`adly 1'b0;
                        genmeter_rdata_sig      <= #`adly 1'b0;
                        loadmeter_rdata_sig     <= #`adly 1'b0;
                        state                   <= #`adly ST_1SHOT;
                      end
                16'd2: begin
                        bess_rdata_sig          <= #`adly 1'b0;
                        pv_rdata_sig            <= #`adly 1'b1;
                        meter_rdata_sig         <= #`adly 1'b0;
                        usrparam_rdata_sig      <= #`adly 1'b0;
                        gen_rdata_sig           <= #`adly 1'b0;
                        rly_rdata_sig           <= #`adly 1'b0;
                        bessmeter_rdata_sig     <= #`adly 1'b0;
                        pvmeter_rdata_sig       <= #`adly 1'b0;
                        genmeter_rdata_sig      <= #`adly 1'b0;
                        loadmeter_rdata_sig     <= #`adly 1'b0;
                        state                   <= #`adly ST_1SHOT;
                      end 
                16'd4: begin
                        bess_rdata_sig          <= #`adly 1'b0;
                        pv_rdata_sig            <= #`adly 1'b0;
                        meter_rdata_sig         <= #`adly 1'b1;
                        usrparam_rdata_sig      <= #`adly 1'b0;
                        gen_rdata_sig           <= #`adly 1'b0;
                        rly_rdata_sig           <= #`adly 1'b0;
                        bessmeter_rdata_sig     <= #`adly 1'b0;
                        pvmeter_rdata_sig       <= #`adly 1'b0;
                        genmeter_rdata_sig      <= #`adly 1'b0;
                        loadmeter_rdata_sig     <= #`adly 1'b0;
                        state                   <= #`adly ST_1SHOT;
                      end    
                16'd8: begin
                        bess_rdata_sig          <= #`adly 1'b0;
                        pv_rdata_sig            <= #`adly 1'b0;
                        meter_rdata_sig         <= #`adly 1'b0;
                        usrparam_rdata_sig      <= #`adly 1'b1;
                        gen_rdata_sig           <= #`adly 1'b0;
                        rly_rdata_sig           <= #`adly 1'b0;
                        bessmeter_rdata_sig     <= #`adly 1'b0;
                        pvmeter_rdata_sig       <= #`adly 1'b0;
                        genmeter_rdata_sig      <= #`adly 1'b0;
                        loadmeter_rdata_sig     <= #`adly 1'b0;
                        state                   <= #`adly ST_1SHOT;
                      end    
                16'd16: begin
                        bess_rdata_sig          <= #`adly 1'b0;
                        pv_rdata_sig            <= #`adly 1'b0;
                        meter_rdata_sig         <= #`adly 1'b0;
                        usrparam_rdata_sig      <= #`adly 1'b0;
                        gen_rdata_sig           <= #`adly 1'b1;
                        rly_rdata_sig           <= #`adly 1'b0;
                        bessmeter_rdata_sig     <= #`adly 1'b0;
                        pvmeter_rdata_sig       <= #`adly 1'b0;
                        genmeter_rdata_sig      <= #`adly 1'b0;
                        loadmeter_rdata_sig     <= #`adly 1'b0;
                        state                   <= #`adly ST_1SHOT;
                      end  
                16'd32: begin
                        bess_rdata_sig          <= #`adly 1'b0;
                        pv_rdata_sig            <= #`adly 1'b0;
                        meter_rdata_sig         <= #`adly 1'b0;
                        usrparam_rdata_sig      <= #`adly 1'b0;
                        gen_rdata_sig           <= #`adly 1'b0;
                        rly_rdata_sig           <= #`adly 1'b1;
                        bessmeter_rdata_sig     <= #`adly 1'b0;
                        pvmeter_rdata_sig       <= #`adly 1'b0;
                        genmeter_rdata_sig      <= #`adly 1'b0;
                        loadmeter_rdata_sig     <= #`adly 1'b0;
                        state                   <= #`adly ST_1SHOT;
                      end   
                16'd64: begin
                        bess_rdata_sig          <= #`adly 1'b0;
                        pv_rdata_sig            <= #`adly 1'b0;
                        meter_rdata_sig         <= #`adly 1'b0;
                        usrparam_rdata_sig      <= #`adly 1'b0;
                        gen_rdata_sig           <= #`adly 1'b0;
                        rly_rdata_sig           <= #`adly 1'b0;
                        bessmeter_rdata_sig     <= #`adly 1'b1;
                        pvmeter_rdata_sig       <= #`adly 1'b0;
                        genmeter_rdata_sig      <= #`adly 1'b0;
                        loadmeter_rdata_sig     <= #`adly 1'b0;
                        state                   <= #`adly ST_1SHOT;
                      end     
                16'd128: begin
                        bess_rdata_sig          <= #`adly 1'b0;
                        pv_rdata_sig            <= #`adly 1'b0;
                        meter_rdata_sig         <= #`adly 1'b0;
                        usrparam_rdata_sig      <= #`adly 1'b0;
                        gen_rdata_sig           <= #`adly 1'b0;
                        rly_rdata_sig           <= #`adly 1'b0;
                        bessmeter_rdata_sig     <= #`adly 1'b0;
                        pvmeter_rdata_sig       <= #`adly 1'b1;
                        genmeter_rdata_sig      <= #`adly 1'b0;
                        loadmeter_rdata_sig     <= #`adly 1'b0;
                        state                   <= #`adly ST_1SHOT;
                      end 
                16'd256: begin
                        bess_rdata_sig          <= #`adly 1'b0;
                        pv_rdata_sig            <= #`adly 1'b0;
                        meter_rdata_sig         <= #`adly 1'b0;
                        usrparam_rdata_sig      <= #`adly 1'b0;
                        gen_rdata_sig           <= #`adly 1'b0;
                        rly_rdata_sig           <= #`adly 1'b0;
                        bessmeter_rdata_sig     <= #`adly 1'b0;
                        pvmeter_rdata_sig       <= #`adly 1'b0;
                        genmeter_rdata_sig      <= #`adly 1'b1;
                        loadmeter_rdata_sig     <= #`adly 1'b0;
                        state                   <= #`adly ST_1SHOT;
                      end     
                16'd512: begin
                        bess_rdata_sig          <= #`adly 1'b0;
                        pv_rdata_sig            <= #`adly 1'b0;
                        meter_rdata_sig         <= #`adly 1'b0;
                        usrparam_rdata_sig      <= #`adly 1'b0;
                        gen_rdata_sig           <= #`adly 1'b0;
                        rly_rdata_sig           <= #`adly 1'b0;
                        bessmeter_rdata_sig     <= #`adly 1'b0;
                        pvmeter_rdata_sig       <= #`adly 1'b0;
                        genmeter_rdata_sig      <= #`adly 1'b0;
                        loadmeter_rdata_sig     <= #`adly 1'b1;
                        state                   <= #`adly ST_1SHOT;
                      end                                                                                                         
                default: begin
                        bess_rdata_sig          <= #`adly 1'b0;
                        pv_rdata_sig            <= #`adly 1'b0;
                        meter_rdata_sig         <= #`adly 1'b0;
                        usrparam_rdata_sig      <= #`adly 1'b0;
                        gen_rdata_sig           <= #`adly 1'b0;
                        rly_rdata_sig           <= #`adly 1'b0;
                        bessmeter_rdata_sig     <= #`adly 1'b0;
                        pvmeter_rdata_sig       <= #`adly 1'b0;
                        genmeter_rdata_sig      <= #`adly 1'b0;
                        loadmeter_rdata_sig     <= #`adly 1'b0;
                        state                   <= #`adly ST_IDLE;
                      end                                                                                                           
            endcase                                       
        end
        ST_1SHOT:
        begin
            bess_rdata_sig          <= #`adly 1'b0;
            pv_rdata_sig            <= #`adly 1'b0;
            meter_rdata_sig         <= #`adly 1'b0;
            usrparam_rdata_sig      <= #`adly 1'b0;
            gen_rdata_sig           <= #`adly 1'b0;
            rly_rdata_sig           <= #`adly 1'b0;
            bessmeter_rdata_sig     <= #`adly 1'b0;
            pvmeter_rdata_sig       <= #`adly 1'b0;
            genmeter_rdata_sig      <= #`adly 1'b0;
            loadmeter_rdata_sig     <= #`adly 1'b0;
            if (pspl_rdata_sig_array!=16'd0) //to ensure PS has deasserted the signal
                state       <= #`adly ST_1SHOT;
            else 
                state       <= #`adly ST_IDLE;
        end
        endcase
    end    
end  


//BESS BRAM Read State Machine
always @ (posedge clkin, negedge arst_n)
begin
    if (~arst_n)
    begin
        state_bess_r         <= #`adly ST_BESS_R_IDLE;
        bess_rdata_vld       <= #`adly 1'b0;
        bess_bram_enb        <= #`adly 1'b0;
        bess_bram_addr       <= #`adly 10'd0;
    end    
    else
    begin
        (* parallel_case *)
        case (state_bess_r)
        ST_BESS_R_IDLE:
        begin
            if (bess_rdata_sig==1'b1)
            begin
               bess_bram_addr        <= #`adly BESS_RDATA_STRTADDR;
               bess_bram_enb         <= #`adly 1'b1;                    
               state_bess_r          <= #`adly ST_BESS_R_INTRM;
            end  
            else
            begin
               bess_bram_addr        <= #`adly 10'd0; 
               bess_bram_enb         <= #`adly 1'b0;                    
               state_bess_r          <= #`adly ST_BESS_R_IDLE;
            end  
        end
        ST_BESS_R_INTRM:
        begin
            bess_bram_addr          <= #`adly bess_bram_addr + 1;
            bess_bram_enb           <= #`adly 1'b1; 
            state_bess_r            <= #`adly ST_BESS_R_REG1;
        end
        ST_BESS_R_REG1:
        begin
            bess_bram_addr          <= #`adly bess_bram_addr + 1;
            bess_bram_enb           <= #`adly 1'b1; 
            state_bess_r            <= #`adly ST_BESS_R_REG2;
        end        
        ST_BESS_R_REG2:
        begin
            bess_bram_addr        <= #`adly bess_bram_addr + 1;
            bess_bram_enb         <= #`adly 1'b1; 
            state_bess_r          <= #`adly ST_BESS_R_REG3;

            bess_status_r           <= #`adly bram_din[6:0];
            bess_islandmode_r       <= #`adly bram_din[7];
            bess_fault_r            <= #`adly bram_din[15:8];
        end    
        ST_BESS_R_REG3:
        begin
            bess_bram_addr        <= #`adly bess_bram_addr + 1;
            bess_bram_enb         <= #`adly 1'b1; 
            state_bess_r          <= #`adly ST_BESS_R_REG4;   
            bess_soc_r            <= #`adly bram_din;       
        end
        ST_BESS_R_REG4:
        begin
            bess_bram_addr        <= #`adly bess_bram_addr + 1;
            bess_bram_enb         <= #`adly 1'b1;
            state_bess_r          <= #`adly ST_BESS_R_REG5;
            bess_maxdschgpwr_r    <= #`adly bram_din;
        end   
        ST_BESS_R_REG5:
        begin
            bess_bram_addr        <= #`adly 10'd0;
            bess_bram_enb         <= #`adly 1'b0;             
            state_bess_r          <= #`adly ST_BESS_R_REG6;
            bess_maxchgpwr_r      <= #`adly bram_din;
        end 
        ST_BESS_R_REG6:
        begin
            state_bess_r          <= #`adly ST_BESS_R_REG7;
            bess_wh_r             <= #`adly bram_din;
        end 
        ST_BESS_R_REG7:
        begin
            state_bess_r            <= #`adly ST_BESS_R_VLD;
            bess_islandmodevolt_r   <= #`adly bram_din[15:0];
            bess_islandmodefrq_r    <= #`adly bram_din[31:16];
            bess_rdata_vld          <= #`adly 1'b1;
        end 
        ST_BESS_R_VLD:
        begin
            if (bess_rdata_sig==1'b1)
            begin
               bess_rdata_vld        <= #`adly 1'b0;                    
               state_bess_r          <= #`adly ST_BESS_R_VLD;
            end  
            else
            begin
               bess_rdata_vld        <= #`adly 1'b0;                    
               state_bess_r          <= #`adly ST_BESS_R_IDLE;
            end  
        end       
        endcase
    end
end           

//PV BRAM Read State Machine
always @ (posedge clkin, negedge arst_n)
begin
    if (~arst_n)
    begin
        state_pv_r           <= #`adly ST_PV_R_IDLE;
        pv_rdata_vld         <= #`adly 1'b0;
        pv_bram_enb          <= #`adly 1'b0;
        pv_bram_addr         <= #`adly 10'd0;
    end    
    else
    begin
        (* parallel_case *)
        case (state_pv_r)
        ST_PV_R_IDLE:
        begin
            if (pv_rdata_sig==1'b1)
            begin
               pv_bram_addr         <= #`adly PV_RDATA_STRTADDR;
               pv_bram_enb          <= #`adly 1'b1;                    
               state_pv_r           <= #`adly ST_PV_R_INTRM;
            end  
            else
            begin
               pv_bram_addr         <= #`adly 10'd0; 
               pv_bram_enb          <= #`adly 1'b0;                    
               state_pv_r           <= #`adly ST_PV_R_IDLE;
            end  
        end
        ST_PV_R_INTRM:
        begin
            pv_bram_addr            <= #`adly pv_bram_addr + 1;
            pv_bram_enb             <= #`adly 1'b1; 
            state_pv_r              <= #`adly ST_PV_R_REG1;
        end
        ST_PV_R_REG1:
        begin
            pv_bram_addr            <= #`adly pv_bram_addr + 1;
            pv_bram_enb             <= #`adly 1'b1; 
            state_pv_r              <= #`adly ST_PV_R_REG2;
        end        
        ST_PV_R_REG2:
        begin
            pv_bram_addr        <= #`adly pv_bram_addr + 1;
            pv_bram_enb         <= #`adly 1'b1; 
            state_pv_r          <= #`adly ST_PV_R_REG2_1;
            pv_status_r         <= #`adly bram_din;

        end   
        ST_PV_R_REG2_1:
        begin
            pv_bram_addr        <= #`adly pv_bram_addr + 1;
            pv_bram_enb         <= #`adly 1'b1; 
            state_pv_r          <= #`adly ST_PV_R_REG3;
            pv_fault_r          <= #`adly bram_din; 

        end            
        ST_PV_R_REG3:
        begin
            pv_bram_addr        <= #`adly pv_bram_addr + 1;
            pv_bram_enb         <= #`adly 1'b1; 
            state_pv_r          <= #`adly ST_PV_R_REG4;
            
            pv_wattsp_r         <= #`adly bram_din;
        end 
        ST_PV_R_REG4:
        begin
            pv_bram_addr        <= #`adly 10'd0;
            pv_bram_enb         <= #`adly 1'b0; 
            state_pv_r          <= #`adly ST_PV_R_REG5;
            
            pv_watt_r           <= #`adly bram_din;
        end    
        ST_PV_R_REG5:
        begin 
            state_pv_r          <= #`adly ST_PV_R_REG6;
            pv_var_r            <= #`adly bram_din;
        end  
        ST_PV_R_REG6:
        begin 
            state_pv_r          <= #`adly ST_PV_R_VLD;
            pv_yield_r          <= #`adly bram_din;
            pv_rdata_vld        <= #`adly 1'b1;
        end  
        ST_PV_R_VLD:
        begin
            if (pv_rdata_sig==1'b1)
            begin
               pv_rdata_vld        <= #`adly 1'b0;                    
               state_pv_r          <= #`adly ST_PV_R_VLD;
            end  
            else
            begin
               pv_rdata_vld        <= #`adly 1'b0;                    
               state_pv_r          <= #`adly ST_PV_R_IDLE;
            end  
        end       
        endcase
    end
end  

//POI Meter BRAM Read State Machine
always @ (posedge clkin, negedge arst_n)
begin
    if (~arst_n)
    begin
        state_meter_r           <= #`adly ST_METER_R_IDLE;
        meter_rdata_vld         <= #`adly 1'b0;
        meter_bram_enb          <= #`adly 1'b0;
        meter_bram_addr         <= #`adly 10'd0;
    end    
    else
    begin
        (* parallel_case *)
        case (state_meter_r)
        ST_METER_R_IDLE:
        begin
            if (meter_rdata_sig==1'b1)
            begin
               meter_bram_addr         <= #`adly METER_RDATA_STRTADDR;
               meter_bram_enb          <= #`adly 1'b1;                    
               state_meter_r           <= #`adly ST_METER_R_INTRM;
            end  
            else
            begin
               meter_bram_addr         <= #`adly 10'd0; 
               meter_bram_enb          <= #`adly 1'b0;                    
               state_meter_r           <= #`adly ST_METER_R_IDLE;
            end  
        end
        ST_METER_R_INTRM:
        begin
            meter_bram_addr            <= #`adly meter_bram_addr + 1;
            meter_bram_enb             <= #`adly 1'b1; 
            state_meter_r              <= #`adly ST_METER_R_REG1;
        end
        ST_METER_R_REG1:
        begin
            meter_bram_addr            <= #`adly meter_bram_addr + 1;
            meter_bram_enb             <= #`adly 1'b1; 
            state_meter_r              <= #`adly ST_METER_R_REG2;
            
        end        
        ST_METER_R_REG2:
        begin
            meter_bram_addr             <= #`adly meter_bram_addr + 1;
            meter_bram_enb              <= #`adly 1'b1; 
            state_meter_r               <= #`adly ST_METER_R_REG3;
            
            meter_poi_3p                <= #`adly bram_din;
        end   
        ST_METER_R_REG3:
        begin
            meter_bram_addr             <= #`adly meter_bram_addr + 1;
            meter_bram_enb              <= #`adly 1'b1; 
            state_meter_r               <= #`adly ST_METER_R_REG4;
            
            meter_poi_3q                <= #`adly bram_din;
        end 
        ST_METER_R_REG4:
        begin
            meter_bram_addr             <= #`adly meter_bram_addr + 1;
            meter_bram_enb              <= #`adly 1'b1; 
            state_meter_r               <= #`adly ST_METER_R_REG5;
            meter_poi_3s                <= #`adly bram_din;
        end   
        ST_METER_R_REG5:
        begin
            meter_bram_addr             <= #`adly meter_bram_addr + 1;
            meter_bram_enb              <= #`adly 1'b1; 
            state_meter_r               <= #`adly ST_METER_R_REG6;
            meter_poi_pf                <= #`adly bram_din;
        end 
        ST_METER_R_REG6:
        begin
            meter_bram_addr             <= #`adly meter_bram_addr + 1;
            meter_bram_enb              <= #`adly 1'b1; 
            state_meter_r               <= #`adly ST_METER_R_REG7;
            meter_poi_ia                <= #`adly bram_din;
        end    
        ST_METER_R_REG7:
        begin
            meter_bram_addr             <= #`adly meter_bram_addr + 1;
            meter_bram_enb              <= #`adly 1'b1; 
            state_meter_r               <= #`adly ST_METER_R_REG8;
            meter_poi_ib                <= #`adly bram_din;
        end 
        ST_METER_R_REG8:
        begin
            meter_bram_addr             <= #`adly meter_bram_addr + 1;
            meter_bram_enb              <= #`adly 1'b1; 
            state_meter_r               <= #`adly ST_METER_R_REG9;
            meter_poi_ic                <= #`adly bram_din;
        end  
        ST_METER_R_REG9:
        begin
            meter_bram_addr             <= #`adly meter_bram_addr + 1;
            meter_bram_enb              <= #`adly 1'b1; 
            state_meter_r               <= #`adly ST_METER_R_REG10;
            meter_poi_in                <= #`adly bram_din;
        end 
        ST_METER_R_REG10:
        begin
            meter_bram_addr             <= #`adly meter_bram_addr + 1;
            meter_bram_enb              <= #`adly 1'b1; 
            state_meter_r               <= #`adly ST_METER_R_REG11;
            meter_poi_vab                <= #`adly bram_din;
        end    
        ST_METER_R_REG11:
        begin
            meter_bram_addr             <= #`adly 10'd0;
            meter_bram_enb              <= #`adly 1'b0; 
            state_meter_r               <= #`adly ST_METER_R_REG12;
            meter_poi_vbc               <= #`adly bram_din;
        end
        ST_METER_R_REG12:
        begin
            state_meter_r               <= #`adly ST_METER_R_REG13;
            meter_poi_vca               <= #`adly bram_din;
        end     
        ST_METER_R_REG13:
        begin
            state_meter_r               <= #`adly ST_METER_R_VLD;
            meter_poi_freq              <= #`adly bram_din;
            meter_rdata_vld             <= #`adly 1'b1;
        end                 
        ST_METER_R_VLD:
        begin
            if (meter_rdata_sig==1'b1)
            begin
               meter_rdata_vld        <= #`adly 1'b0;                    
               state_meter_r          <= #`adly ST_METER_R_VLD;
            end  
            else
            begin
               meter_rdata_vld        <= #`adly 1'b0;                    
               state_meter_r          <= #`adly ST_METER_R_IDLE;
            end  
        end       
        endcase
    end
end  


//User Parameters BRAM Read State Machine
// note 1
always @ (posedge clkin, negedge arst_n)
begin
    if (~arst_n)
    begin
        state_usrparam_r           <= #`adly ST_USRPARAM_R_IDLE;
        usr_param_vld              <= #`adly 1'b0;
        usrparam_bram_enb          <= #`adly 1'b0;
        usrparam_bram_addr         <= #`adly 10'd0;
    end    
    else
    begin
        (* parallel_case *)
        case (state_usrparam_r)
        ST_USRPARAM_R_IDLE:
        begin
            if (usrparam_rdata_sig==1'b1)
            begin
               usrparam_bram_addr         <= #`adly USRPARAM_RDATA_STRTADDR;
               usrparam_bram_enb          <= #`adly 1'b1;                    
               state_usrparam_r           <= #`adly ST_USRPARAM_R_INTRM;
            end  
            else
            begin
               usrparam_bram_addr         <= #`adly 10'd0; 
               usrparam_bram_enb          <= #`adly 1'b0;                    
               state_usrparam_r           <= #`adly ST_USRPARAM_R_IDLE;
            end  
        end
        ST_USRPARAM_R_INTRM:
        begin
            usrparam_bram_addr            <= #`adly usrparam_bram_addr + 1;
            usrparam_bram_enb             <= #`adly 1'b1; 
            state_usrparam_r              <= #`adly ST_USRPARAM_R_REG1;
        end
        ST_USRPARAM_R_REG1:
        begin
            usrparam_bram_addr            <= #`adly usrparam_bram_addr + 1;
            usrparam_bram_enb             <= #`adly 1'b1; 
            state_usrparam_r              <= #`adly ST_USRPARAM_R_REG2;
        end        
        ST_USRPARAM_R_REG2:
        begin
            usrparam_bram_addr            <= #`adly usrparam_bram_addr + 1;
            usrparam_bram_enb             <= #`adly 1'b1; 
            state_usrparam_r              <= #`adly ST_USRPARAM_R_REG3;
            
            usr_imp_lmt                   <= #`adly bram_din;
        end   
        ST_USRPARAM_R_REG3:
        begin
            usrparam_bram_addr            <= #`adly usrparam_bram_addr + 1;
            usrparam_bram_enb             <= #`adly 1'b1; 
            state_usrparam_r              <= #`adly ST_USRPARAM_R_REG4;
            
            usr_exp_lmt                   <= #`adly bram_din;
        end 
        ST_USRPARAM_R_REG4:
        begin
            usrparam_bram_addr            <= #`adly usrparam_bram_addr + 1;
            usrparam_bram_enb             <= #`adly 1'b1; 
            state_usrparam_r              <= #`adly ST_USRPARAM_R_REG5;
            
            usr_besschrg_lmt              <= #`adly bram_din;
        end   
        ST_USRPARAM_R_REG5:
        begin
            usrparam_bram_addr            <= #`adly usrparam_bram_addr + 1;
            usrparam_bram_enb             <= #`adly 1'b1; 
            state_usrparam_r              <= #`adly ST_USRPARAM_R_REG6;
            
            usr_bessdsch_lmt              <= #`adly bram_din;
        end 
        ST_USRPARAM_R_REG6:
        begin
            usrparam_bram_addr            <= #`adly usrparam_bram_addr + 1;
            usrparam_bram_enb             <= #`adly 1'b1; 
            state_usrparam_r              <= #`adly ST_USRPARAM_R_REG7;
            
            usr_bess_kp                   <= #`adly bram_din;
        end    
        ST_USRPARAM_R_REG7:
        begin
            usrparam_bram_addr            <= #`adly usrparam_bram_addr + 1;
            usrparam_bram_enb             <= #`adly 1'b1; 
            state_usrparam_r              <= #`adly ST_USRPARAM_R_REG8;
            
            usr_bess_ki                   <= #`adly bram_din;
        end 
        ST_USRPARAM_R_REG8:
        begin
            usrparam_bram_addr            <= #`adly usrparam_bram_addr + 1;
            usrparam_bram_enb             <= #`adly 1'b1; 
            state_usrparam_r              <= #`adly ST_USRPARAM_R_REG9;
            
            usr_bess_kd                   <= #`adly bram_din;
        end  
        ST_USRPARAM_R_REG9:
        begin
            usrparam_bram_addr            <= #`adly usrparam_bram_addr + 1;
            usrparam_bram_enb             <= #`adly 1'b1; 
            state_usrparam_r              <= #`adly ST_USRPARAM_R_REG10;
            
            usr_pv_kp                     <= #`adly bram_din;
        end 
        ST_USRPARAM_R_REG10:
        begin
            usrparam_bram_addr            <= #`adly usrparam_bram_addr + 1;
            usrparam_bram_enb             <= #`adly 1'b1; 
            state_usrparam_r              <= #`adly ST_USRPARAM_R_REG11;
            
            usr_pv_ki                     <= #`adly bram_din;
        end    
        ST_USRPARAM_R_REG11:
        begin
            usrparam_bram_addr            <= #`adly usrparam_bram_addr + 1;
            usrparam_bram_enb             <= #`adly 1'b1; 
            state_usrparam_r              <= #`adly ST_USRPARAM_R_REG12;
            
            usr_pv_kd                     <= #`adly bram_din;
        end
        ST_USRPARAM_R_REG12:
        begin
            usrparam_bram_addr            <= #`adly usrparam_bram_addr + 1;
            usrparam_bram_enb             <= #`adly 1'b1; 
            state_usrparam_r              <= #`adly ST_USRPARAM_R_REG13;
            
            usr_bess_maxsoc               <= #`adly bram_din;
        end        
        ST_USRPARAM_R_REG13:
        begin
            usrparam_bram_addr            <= #`adly usrparam_bram_addr + 1;
            usrparam_bram_enb             <= #`adly 1'b1; 
            state_usrparam_r              <= #`adly ST_USRPARAM_R_REG14;
            usr_bess_minsoc               <= #`adly bram_din;
        end          
        ST_USRPARAM_R_REG14:
        begin
            usrparam_bram_addr            <= #`adly usrparam_bram_addr + 1;
            usrparam_bram_enb             <= #`adly 1'b1; 
            state_usrparam_r              <= #`adly ST_USRPARAM_R_REG15;
            usr_pv_max                    <= #`adly bram_din;
        end       
        ST_USRPARAM_R_REG15:
        begin
            usrparam_bram_addr            <= #`adly usrparam_bram_addr + 1;
            usrparam_bram_enb             <= #`adly 1'b1;             
            state_usrparam_r              <= #`adly ST_USRPARAM_R_REG16;
            usr_cmd_reg                   <= #`adly bram_din;
        end   
        ST_USRPARAM_R_REG16:
        begin
            usrparam_bram_addr            <= #`adly usrparam_bram_addr + 1;
            usrparam_bram_enb             <= #`adly 1'b1;             
            state_usrparam_r              <= #`adly ST_USRPARAM_R_REG17;
            usr_net_load                  <= #`adly bram_din;
        end   
        ST_USRPARAM_R_REG17:
        begin
            usrparam_bram_addr            <= #`adly usrparam_bram_addr + 1;
            usrparam_bram_enb             <= #`adly 1'b1;             
            state_usrparam_r              <= #`adly ST_USRPARAM_R_REG18;
            usr_bessislnd_minwh           <= #`adly bram_din;
        end   
        ST_USRPARAM_R_REG18:
        begin
            usrparam_bram_addr            <= #`adly usrparam_bram_addr + 1;
            usrparam_bram_enb             <= #`adly 1'b1;             
            state_usrparam_r              <= #`adly ST_USRPARAM_R_REG19;
            usr_bessislnd_maxwh_ul        <= #`adly bram_din;
        end   
        ST_USRPARAM_R_REG19:
        begin
            usrparam_bram_addr            <= #`adly usrparam_bram_addr + 1;
            usrparam_bram_enb             <= #`adly 1'b1;             
            state_usrparam_r              <= #`adly ST_USRPARAM_R_REG20;
            usr_bessislnd_maxwh_ll        <= #`adly bram_din;
        end 
        ST_USRPARAM_R_REG20:
        begin
            usrparam_bram_addr            <= #`adly usrparam_bram_addr + 1;
            usrparam_bram_enb             <= #`adly 1'b1;             
            state_usrparam_r              <= #`adly ST_USRPARAM_R_REG21;
            usr_bessislndext_minwh        <= #`adly bram_din;
        end 
        ST_USRPARAM_R_REG21:
        begin
            usrparam_bram_addr            <= #`adly usrparam_bram_addr + 1;
            usrparam_bram_enb             <= #`adly 1'b1;             
            state_usrparam_r              <= #`adly ST_USRPARAM_R_REG22;
            usr_maxld_islnd               <= #`adly bram_din;
        end 
        ST_USRPARAM_R_REG22:
        begin
            usrparam_bram_addr            <= #`adly usrparam_bram_addr + 1;
            usrparam_bram_enb             <= #`adly 1'b1;             
            state_usrparam_r              <= #`adly ST_USRPARAM_R_REG23;
            usr_gen_baseld                <= #`adly bram_din;
        end 
        ST_USRPARAM_R_REG23:
        begin
            usrparam_bram_addr            <= #`adly usrparam_bram_addr + 1;
            usrparam_bram_enb             <= #`adly 1'b1;             
            state_usrparam_r              <= #`adly ST_USRPARAM_R_REG24;
            usr_grdhlthy_vmin             <= #`adly bram_din;
        end   
        ST_USRPARAM_R_REG24:
        begin
            usrparam_bram_addr            <= #`adly usrparam_bram_addr + 1;
            usrparam_bram_enb             <= #`adly 1'b1;             
            state_usrparam_r              <= #`adly ST_USRPARAM_R_REG25;
            usr_grdhlthy_vmax             <= #`adly bram_din;
        end                 
        ST_USRPARAM_R_REG25:
        begin
            usrparam_bram_addr            <= #`adly 10'd0;
            usrparam_bram_enb             <= #`adly 1'b0; 
            state_usrparam_r              <= #`adly ST_USRPARAM_R_REG26;
            usr_grdhlthy_fmin             <= #`adly bram_din;
        end       
        ST_USRPARAM_R_REG26:
        begin
            state_usrparam_r              <= #`adly ST_USRPARAM_R_REG27;
            usr_grdhlthy_fmax             <= #`adly bram_din;
        end   
        ST_USRPARAM_R_REG27:
        begin
            state_usrparam_r              <= #`adly ST_USRPARAM_R_VLD;
            usr_timer_reg                 <= #`adly bram_din;
            usr_param_vld                 <= #`adly 1'b1;
        end   
        ST_USRPARAM_R_VLD:
        begin
            if (bess_rdata_sig==1'b1)
            begin
               usr_param_vld              <= #`adly 1'b0;                    
               state_usrparam_r           <= #`adly ST_USRPARAM_R_VLD;
            end  
            else
            begin
               usr_param_vld              <= #`adly 1'b0;                    
               state_usrparam_r           <= #`adly ST_USRPARAM_R_IDLE;
            end  
        end       
        endcase
    end
end  

//Genset BRAM Read State Machine
always @ (posedge clkin, negedge arst_n)
begin
    if (~arst_n)
    begin
        state_gen_r         <= #`adly ST_GEN_R_IDLE;
        gen_rdata_vld       <= #`adly 1'b0;
        gen_bram_enb        <= #`adly 1'b0;
        gen_bram_addr       <= #`adly 10'd0;
    end    
    else
    begin
        (* parallel_case *)
        case (state_gen_r)
        ST_GEN_R_IDLE:
        begin
            if (gen_rdata_sig==1'b1)
            begin
               gen_bram_addr        <= #`adly GEN_RDATA_STRTADDR;
               gen_bram_enb         <= #`adly 1'b1;                    
               state_gen_r          <= #`adly ST_GEN_R_INTRM;
            end  
            else
            begin
               gen_bram_addr        <= #`adly 10'd0; 
               gen_bram_enb         <= #`adly 1'b0;                    
               state_gen_r          <= #`adly ST_GEN_R_IDLE;
            end  
        end
        ST_GEN_R_INTRM:
        begin
            gen_bram_addr          <= #`adly gen_bram_addr + 1;
            gen_bram_enb           <= #`adly 1'b1; 
            state_gen_r            <= #`adly ST_GEN_R_REG1;
        end
        ST_GEN_R_REG1:
        begin
            gen_bram_addr        <= #`adly 10'd0;
            gen_bram_enb         <= #`adly 1'b0; 
            state_gen_r          <= #`adly ST_GEN_R_REG2;       
        end      
        ST_GEN_R_REG2:
        begin
            state_gen_r          <= #`adly ST_GEN_R_REG3;
            gen_status_r         <= #`adly bram_din;
        end    
        ST_GEN_R_REG3:
        begin
            state_gen_r          <= #`adly ST_GEN_R_VLD;
            gen_fault_r          <= #`adly bram_din;
            gen_rdata_vld        <= #`adly 1'b1;
        end 
        ST_GEN_R_VLD:
        begin
            if (gen_rdata_sig==1'b1)
            begin
               gen_rdata_vld        <= #`adly 1'b0;                    
               state_gen_r          <= #`adly ST_GEN_R_VLD;
            end  
            else
            begin
               gen_rdata_vld        <= #`adly 1'b0;                    
               state_gen_r          <= #`adly ST_GEN_R_IDLE;
            end  
        end       
        endcase
    end
end    

//Relay BRAM Read State Machine
always @ (posedge clkin, negedge arst_n)
begin
    if (~arst_n)
    begin
        state_rly_r         <= #`adly ST_RLY_R_IDLE;
        rly_rdata_vld       <= #`adly 1'b0;
        rly_bram_enb        <= #`adly 1'b0;
        rly_bram_addr       <= #`adly 10'd0;
    end    
    else
    begin
        (* parallel_case *)
        case (state_rly_r)
        ST_RLY_R_IDLE:
        begin
            if (rly_rdata_sig==1'b1)
            begin
               rly_bram_addr        <= #`adly RLY_RDATA_STRTADDR;
               rly_bram_enb         <= #`adly 1'b1;                    
               state_rly_r          <= #`adly ST_RLY_R_INTRM;
            end  
            else
            begin
               rly_bram_addr        <= #`adly 10'd0; 
               rly_bram_enb         <= #`adly 1'b0;                    
               state_rly_r          <= #`adly ST_RLY_R_IDLE;
            end  
        end
        ST_RLY_R_INTRM:
        begin
            rly_bram_addr          <= #`adly rly_bram_addr + 1;
            rly_bram_enb           <= #`adly 1'b1; 
            state_rly_r            <= #`adly ST_RLY_R_REG1;
        end
        ST_RLY_R_REG1:
        begin
            rly_bram_addr        <= #`adly rly_bram_addr + 1;
            rly_bram_enb         <= #`adly 1'b1; 
            state_rly_r          <= #`adly ST_RLY_R_REG2;       
        end      
        ST_RLY_R_REG2:
        begin
            rly_bram_addr        <= #`adly rly_bram_addr + 1;
            rly_bram_enb         <= #`adly 1'b1; 
            state_rly_r          <= #`adly ST_RLY_R_REG3;
            rly_protstat_r       <= #`adly bram_din;  
        end 
        ST_RLY_R_REG3:
        begin
            rly_bram_addr        <= #`adly rly_bram_addr + 1;
            rly_bram_enb         <= #`adly 1'b1; 
            state_rly_r          <= #`adly ST_RLY_R_REG4;
            rly_ioltchsv_r       <= #`adly bram_din;  
        end         
        ST_RLY_R_REG4:
        begin
            rly_bram_addr        <= #`adly rly_bram_addr + 1;
            rly_bram_enb         <= #`adly 1'b1; 
            state_rly_r          <= #`adly ST_RLY_R_REG5;
            rly_hwerr_r          <= #`adly bram_din;  
        end
        ST_RLY_R_REG5:
        begin
            rly_bram_addr        <= #`adly rly_bram_addr + 1;
            rly_bram_enb         <= #`adly 1'b1; 
            state_rly_r          <= #`adly ST_RLY_R_REG6;
            rly_lvab_r           <= #`adly bram_din[15:0];
            rly_lvbc_r           <= #`adly bram_din[31:16];
        end    
        ST_RLY_R_REG6:
        begin
            rly_bram_addr        <= #`adly 10'd0;
            rly_bram_enb         <= #`adly 1'b0; 
            state_rly_r          <= #`adly ST_RLY_R_REG7;
            rly_lvca_r           <= #`adly bram_din[15:0];
            rly_bvab_r           <= #`adly bram_din[31:16];
        end 
        ST_RLY_R_REG7:
        begin
            state_rly_r          <= #`adly ST_RLY_R_REG8;
            rly_bvbc_r           <= #`adly bram_din[15:0];
            rly_bvca_r           <= #`adly bram_din[31:16];
        end 
        ST_RLY_R_REG8:
        begin
            state_rly_r          <= #`adly ST_RLY_R_VLD;
            rly_rdata_vld        <= #`adly 1'b1; 
            rly_lfrq_r           <= #`adly bram_din[15:0];
            rly_bfrq_r           <= #`adly bram_din[31:16];
        end                                                       
        ST_RLY_R_VLD:
        begin
            if (rly_rdata_sig==1'b1)
            begin
               rly_rdata_vld        <= #`adly 1'b0;                    
               state_rly_r          <= #`adly ST_RLY_R_VLD;
            end  
            else
            begin
               rly_rdata_vld        <= #`adly 1'b0;                    
               state_rly_r          <= #`adly ST_RLY_R_IDLE;
            end  
        end       
        endcase
    end
end    

//BESS Meter BRAM Read State Machine
always @ (posedge clkin, negedge arst_n)
begin
    if (~arst_n)
    begin
        state_bessmeter_r           <= #`adly ST_BESSMETER_R_IDLE;
        meter_bessrdata_vld         <= #`adly 1'b0;
        bessmeter_bram_enb          <= #`adly 1'b0;
        bessmeter_bram_addr         <= #`adly 10'd0;
    end    
    else
    begin
        (* parallel_case *)
        case (state_bessmeter_r)
        ST_BESSMETER_R_IDLE:
        begin
            if (bessmeter_rdata_sig==1'b1)
            begin
               bessmeter_bram_addr          <= #`adly BESSMETER_RDATA_STRTADDR;
               bessmeter_bram_enb           <= #`adly 1'b1;                    
               state_bessmeter_r            <= #`adly ST_BESSMETER_R_INTRM;
            end  
            else
            begin
               bessmeter_bram_addr         <= #`adly 10'd0; 
               bessmeter_bram_enb          <= #`adly 1'b0;                    
               state_bessmeter_r           <= #`adly ST_BESSMETER_R_IDLE;
            end  
        end
        ST_BESSMETER_R_INTRM:
        begin
            bessmeter_bram_addr            <= #`adly bessmeter_bram_addr + 1;
            bessmeter_bram_enb             <= #`adly 1'b1; 
            state_bessmeter_r              <= #`adly ST_BESSMETER_R_REG1;
        end
        ST_BESSMETER_R_REG1:
        begin
            bessmeter_bram_addr            <= #`adly bessmeter_bram_addr + 1;
            bessmeter_bram_enb             <= #`adly 1'b1; 
            state_bessmeter_r              <= #`adly ST_BESSMETER_R_REG2;
            
        end        
        ST_BESSMETER_R_REG2:
        begin
            bessmeter_bram_addr             <= #`adly bessmeter_bram_addr + 1;
            bessmeter_bram_enb              <= #`adly 1'b1; 
            state_bessmeter_r               <= #`adly ST_BESSMETER_R_REG3;
        
            meter_bess_3p                   <= #`adly bram_din;
        end   
        ST_BESSMETER_R_REG3:
        begin
            bessmeter_bram_addr             <= #`adly bessmeter_bram_addr + 1;
            bessmeter_bram_enb              <= #`adly 1'b1; 
            state_bessmeter_r               <= #`adly ST_BESSMETER_R_REG4;
            
            meter_bess_3q                   <= #`adly bram_din;
        end 
        ST_BESSMETER_R_REG4:
        begin
            bessmeter_bram_addr             <= #`adly bessmeter_bram_addr + 1;
            bessmeter_bram_enb              <= #`adly 1'b1; 
            state_bessmeter_r               <= #`adly ST_BESSMETER_R_REG5;
            meter_bess_3s                   <= #`adly bram_din;
        end   
        ST_BESSMETER_R_REG5:
        begin
            bessmeter_bram_addr             <= #`adly bessmeter_bram_addr + 1;
            bessmeter_bram_enb              <= #`adly 1'b1; 
            state_bessmeter_r               <= #`adly ST_BESSMETER_R_REG6;
            meter_bess_pf                   <= #`adly bram_din;
        end 
        ST_BESSMETER_R_REG6:
        begin
            bessmeter_bram_addr             <= #`adly bessmeter_bram_addr + 1;
            bessmeter_bram_enb              <= #`adly 1'b1; 
            state_bessmeter_r               <= #`adly ST_BESSMETER_R_REG7;
            meter_bess_ia                   <= #`adly bram_din;
        end    
        ST_BESSMETER_R_REG7:
        begin
            bessmeter_bram_addr             <= #`adly bessmeter_bram_addr + 1;
            bessmeter_bram_enb              <= #`adly 1'b1; 
            state_bessmeter_r               <= #`adly ST_BESSMETER_R_REG8;
            meter_bess_ib                   <= #`adly bram_din;
        end 
        ST_BESSMETER_R_REG8:
        begin
            bessmeter_bram_addr             <= #`adly bessmeter_bram_addr + 1;
            bessmeter_bram_enb              <= #`adly 1'b1; 
            state_bessmeter_r               <= #`adly ST_BESSMETER_R_REG9;
            meter_bess_ic                   <= #`adly bram_din;
        end  
        ST_BESSMETER_R_REG9:
        begin
            bessmeter_bram_addr             <= #`adly bessmeter_bram_addr + 1;
            bessmeter_bram_enb              <= #`adly 1'b1; 
            state_bessmeter_r               <= #`adly ST_BESSMETER_R_REG10;
            meter_bess_in                   <= #`adly bram_din;
        end 
        ST_BESSMETER_R_REG10:
        begin
            bessmeter_bram_addr             <= #`adly bessmeter_bram_addr + 1;
            bessmeter_bram_enb              <= #`adly 1'b1; 
            state_bessmeter_r               <= #`adly ST_BESSMETER_R_REG11;
            meter_bess_vab                  <= #`adly bram_din;
        end    
        ST_BESSMETER_R_REG11:
        begin
            bessmeter_bram_addr             <= #`adly 10'd0;
            bessmeter_bram_enb              <= #`adly 1'b0; 
            state_bessmeter_r               <= #`adly ST_BESSMETER_R_REG12;
            meter_bess_vbc                  <= #`adly bram_din;
        end
        ST_BESSMETER_R_REG12:
        begin
            state_bessmeter_r               <= #`adly ST_BESSMETER_R_REG13;
            meter_bess_vca                  <= #`adly bram_din;
        end     
        ST_BESSMETER_R_REG13:
        begin
            state_bessmeter_r               <= #`adly ST_BESSMETER_R_VLD;
            meter_bess_freq                 <= #`adly bram_din;
            meter_bessrdata_vld             <= #`adly 1'b1;
        end                 
        ST_BESSMETER_R_VLD:
        begin
            if (bessmeter_rdata_sig==1'b1)
            begin
               meter_bessrdata_vld        <= #`adly 1'b0;                    
               state_bessmeter_r          <= #`adly ST_BESSMETER_R_VLD;
            end  
            else
            begin
               meter_bessrdata_vld        <= #`adly 1'b0;                    
               state_bessmeter_r          <= #`adly ST_BESSMETER_R_IDLE;
            end  
        end       
        endcase
    end
end  

//PV Meter BRAM Read State Machine
always @ (posedge clkin, negedge arst_n)
begin
    if (~arst_n)
    begin
        state_pvmeter_r           <= #`adly ST_PVMETER_R_IDLE;
        meter_pvrdata_vld         <= #`adly 1'b0;
        pvmeter_bram_enb          <= #`adly 1'b0;
        pvmeter_bram_addr         <= #`adly 10'd0;
    end    
    else
    begin
        (* parallel_case *)
        case (state_pvmeter_r)
        ST_PVMETER_R_IDLE:
        begin
            if (pvmeter_rdata_sig==1'b1)
            begin
               pvmeter_bram_addr          <= #`adly PVMETER_RDATA_STRTADDR;
               pvmeter_bram_enb           <= #`adly 1'b1;                    
               state_pvmeter_r            <= #`adly ST_PVMETER_R_INTRM;
            end  
            else
            begin
               pvmeter_bram_addr         <= #`adly 10'd0; 
               pvmeter_bram_enb          <= #`adly 1'b0;                    
               state_pvmeter_r           <= #`adly ST_PVMETER_R_IDLE;
            end  
        end
        ST_PVMETER_R_INTRM:
        begin
            pvmeter_bram_addr            <= #`adly pvmeter_bram_addr + 1;
            pvmeter_bram_enb             <= #`adly 1'b1; 
            state_pvmeter_r              <= #`adly ST_PVMETER_R_REG1;
        end
        ST_PVMETER_R_REG1:
        begin
            pvmeter_bram_addr            <= #`adly pvmeter_bram_addr + 1;
            pvmeter_bram_enb             <= #`adly 1'b1; 
            state_pvmeter_r              <= #`adly ST_PVMETER_R_REG2;
            
        end        
        ST_PVMETER_R_REG2:
        begin
            pvmeter_bram_addr             <= #`adly pvmeter_bram_addr + 1;
            pvmeter_bram_enb              <= #`adly 1'b1; 
            state_pvmeter_r               <= #`adly ST_PVMETER_R_REG3;
        
            meter_pv_3p                   <= #`adly bram_din;
        end   
        ST_PVMETER_R_REG3:
        begin
            pvmeter_bram_addr             <= #`adly pvmeter_bram_addr + 1;
            pvmeter_bram_enb              <= #`adly 1'b1; 
            state_pvmeter_r               <= #`adly ST_PVMETER_R_REG4;
            
            meter_pv_3q                   <= #`adly bram_din;
        end 
        ST_PVMETER_R_REG4:
        begin
            pvmeter_bram_addr             <= #`adly pvmeter_bram_addr + 1;
            pvmeter_bram_enb              <= #`adly 1'b1; 
            state_pvmeter_r               <= #`adly ST_PVMETER_R_REG5;
            meter_pv_3s                   <= #`adly bram_din;
        end   
        ST_PVMETER_R_REG5:
        begin
            pvmeter_bram_addr             <= #`adly pvmeter_bram_addr + 1;
            pvmeter_bram_enb              <= #`adly 1'b1; 
            state_pvmeter_r               <= #`adly ST_PVMETER_R_REG6;
            meter_pv_pf                   <= #`adly bram_din;
        end 
        ST_PVMETER_R_REG6:
        begin
            pvmeter_bram_addr             <= #`adly pvmeter_bram_addr + 1;
            pvmeter_bram_enb              <= #`adly 1'b1; 
            state_pvmeter_r               <= #`adly ST_PVMETER_R_REG7;
            meter_pv_ia                   <= #`adly bram_din;
        end    
        ST_PVMETER_R_REG7:
        begin
            pvmeter_bram_addr             <= #`adly pvmeter_bram_addr + 1;
            pvmeter_bram_enb              <= #`adly 1'b1; 
            state_pvmeter_r               <= #`adly ST_PVMETER_R_REG8;
            meter_pv_ib                   <= #`adly bram_din;
        end 
        ST_PVMETER_R_REG8:
        begin
            pvmeter_bram_addr             <= #`adly pvmeter_bram_addr + 1;
            pvmeter_bram_enb              <= #`adly 1'b1; 
            state_pvmeter_r               <= #`adly ST_PVMETER_R_REG9;
            meter_pv_ic                   <= #`adly bram_din;
        end  
        ST_PVMETER_R_REG9:
        begin
            pvmeter_bram_addr             <= #`adly pvmeter_bram_addr + 1;
            pvmeter_bram_enb              <= #`adly 1'b1; 
            state_pvmeter_r               <= #`adly ST_PVMETER_R_REG10;
            meter_pv_in                   <= #`adly bram_din;
        end 
        ST_PVMETER_R_REG10:
        begin
            pvmeter_bram_addr             <= #`adly pvmeter_bram_addr + 1;
            pvmeter_bram_enb              <= #`adly 1'b1; 
            state_pvmeter_r               <= #`adly ST_PVMETER_R_REG11;
            meter_pv_vab                  <= #`adly bram_din;
        end    
        ST_PVMETER_R_REG11:
        begin
            pvmeter_bram_addr             <= #`adly 10'd0;
            pvmeter_bram_enb              <= #`adly 1'b0; 
            state_pvmeter_r               <= #`adly ST_PVMETER_R_REG12;
            meter_pv_vbc                  <= #`adly bram_din;
        end
        ST_PVMETER_R_REG12:
        begin
            state_pvmeter_r               <= #`adly ST_PVMETER_R_REG13;
            meter_pv_vca                  <= #`adly bram_din;
        end     
        ST_PVMETER_R_REG13:
        begin
            state_pvmeter_r               <= #`adly ST_PVMETER_R_VLD;
            meter_pv_freq                 <= #`adly bram_din;
            meter_pvrdata_vld             <= #`adly 1'b1;
        end                 
        ST_PVMETER_R_VLD:
        begin
            if (pvmeter_rdata_sig==1'b1)
            begin
               meter_pvrdata_vld        <= #`adly 1'b0;                    
               state_pvmeter_r          <= #`adly ST_PVMETER_R_VLD;
            end  
            else
            begin
               meter_pvrdata_vld        <= #`adly 1'b0;                    
               state_pvmeter_r          <= #`adly ST_PVMETER_R_IDLE;
            end  
        end       
        endcase
    end
end 

//GENSET Meter BRAM Read State Machine
always @ (posedge clkin, negedge arst_n)
begin
    if (~arst_n)
    begin
        state_genmeter_r           <= #`adly ST_GENMETER_R_IDLE;
        meter_genrdata_vld         <= #`adly 1'b0;
        genmeter_bram_enb          <= #`adly 1'b0;
        genmeter_bram_addr         <= #`adly 10'd0;
    end    
    else
    begin
        (* parallel_case *)
        case (state_genmeter_r)
        ST_GENMETER_R_IDLE:
        begin
            if (genmeter_rdata_sig==1'b1)
            begin
               genmeter_bram_addr          <= #`adly GENMETER_RDATA_STRTADDR;
               genmeter_bram_enb           <= #`adly 1'b1;                    
               state_genmeter_r            <= #`adly ST_GENMETER_R_INTRM;
            end  
            else
            begin
               genmeter_bram_addr         <= #`adly 10'd0; 
               genmeter_bram_enb          <= #`adly 1'b0;                    
               state_genmeter_r           <= #`adly ST_GENMETER_R_IDLE;
            end  
        end
        ST_GENMETER_R_INTRM:
        begin
            genmeter_bram_addr            <= #`adly genmeter_bram_addr + 1;
            genmeter_bram_enb             <= #`adly 1'b1; 
            state_genmeter_r              <= #`adly ST_GENMETER_R_REG1;
        end
        ST_GENMETER_R_REG1:
        begin
            genmeter_bram_addr            <= #`adly genmeter_bram_addr + 1;
            genmeter_bram_enb             <= #`adly 1'b1; 
            state_genmeter_r              <= #`adly ST_GENMETER_R_REG2;
            
        end        
        ST_GENMETER_R_REG2:
        begin
            genmeter_bram_addr             <= #`adly genmeter_bram_addr + 1;
            genmeter_bram_enb              <= #`adly 1'b1; 
            state_genmeter_r               <= #`adly ST_GENMETER_R_REG3;
        
            meter_gen_3p                   <= #`adly bram_din;
        end   
        ST_GENMETER_R_REG3:
        begin
            genmeter_bram_addr             <= #`adly genmeter_bram_addr + 1;
            genmeter_bram_enb              <= #`adly 1'b1; 
            state_genmeter_r               <= #`adly ST_GENMETER_R_REG4;
            
            meter_gen_3q                   <= #`adly bram_din;
        end 
        ST_GENMETER_R_REG4:
        begin
            genmeter_bram_addr             <= #`adly genmeter_bram_addr + 1;
            genmeter_bram_enb              <= #`adly 1'b1; 
            state_genmeter_r               <= #`adly ST_GENMETER_R_REG5;
            meter_gen_3s                   <= #`adly bram_din;
        end   
        ST_GENMETER_R_REG5:
        begin
            genmeter_bram_addr             <= #`adly genmeter_bram_addr + 1;
            genmeter_bram_enb              <= #`adly 1'b1; 
            state_genmeter_r               <= #`adly ST_GENMETER_R_REG6;
            meter_gen_pf                   <= #`adly bram_din;
        end 
        ST_GENMETER_R_REG6:
        begin
            genmeter_bram_addr             <= #`adly genmeter_bram_addr + 1;
            genmeter_bram_enb              <= #`adly 1'b1; 
            state_genmeter_r               <= #`adly ST_GENMETER_R_REG7;
            meter_gen_ia                   <= #`adly bram_din;
        end    
        ST_GENMETER_R_REG7:
        begin
            genmeter_bram_addr             <= #`adly genmeter_bram_addr + 1;
            genmeter_bram_enb              <= #`adly 1'b1; 
            state_genmeter_r               <= #`adly ST_GENMETER_R_REG8;
            meter_gen_ib                   <= #`adly bram_din;
        end 
        ST_GENMETER_R_REG8:
        begin
            genmeter_bram_addr             <= #`adly genmeter_bram_addr + 1;
            genmeter_bram_enb              <= #`adly 1'b1; 
            state_genmeter_r               <= #`adly ST_GENMETER_R_REG9;
            meter_gen_ic                   <= #`adly bram_din;
        end  
        ST_GENMETER_R_REG9:
        begin
            genmeter_bram_addr             <= #`adly genmeter_bram_addr + 1;
            genmeter_bram_enb              <= #`adly 1'b1; 
            state_genmeter_r               <= #`adly ST_GENMETER_R_REG10;
            meter_gen_in                   <= #`adly bram_din;
        end 
        ST_GENMETER_R_REG10:
        begin
            genmeter_bram_addr             <= #`adly genmeter_bram_addr + 1;
            genmeter_bram_enb              <= #`adly 1'b1; 
            state_genmeter_r               <= #`adly ST_GENMETER_R_REG11;
            meter_gen_vab                  <= #`adly bram_din;
        end    
        ST_GENMETER_R_REG11:
        begin
            genmeter_bram_addr             <= #`adly 10'd0;
            genmeter_bram_enb              <= #`adly 1'b0; 
            state_genmeter_r               <= #`adly ST_GENMETER_R_REG12;
            meter_gen_vbc                  <= #`adly bram_din;
        end
        ST_GENMETER_R_REG12:
        begin
            state_genmeter_r               <= #`adly ST_GENMETER_R_REG13;
            meter_gen_vca                  <= #`adly bram_din;
        end     
        ST_GENMETER_R_REG13:
        begin
            state_genmeter_r               <= #`adly ST_GENMETER_R_VLD;
            meter_gen_freq                 <= #`adly bram_din;
            meter_genrdata_vld             <= #`adly 1'b1;
        end                 
        ST_GENMETER_R_VLD:
        begin
            if (genmeter_rdata_sig==1'b1)
            begin
               meter_genrdata_vld        <= #`adly 1'b0;                    
               state_genmeter_r          <= #`adly ST_GENMETER_R_VLD;
            end  
            else
            begin
               meter_genrdata_vld        <= #`adly 1'b0;                    
               state_genmeter_r          <= #`adly ST_GENMETER_R_IDLE;
            end  
        end       
        endcase
    end
end  

//Load Meter BRAM Read State Machine
always @ (posedge clkin, negedge arst_n)
begin
    if (~arst_n)
    begin
        state_loadmeter_r           <= #`adly ST_LOADMETER_R_IDLE;
        meter_loadrdata_vld         <= #`adly 1'b0;
        loadmeter_bram_enb          <= #`adly 1'b0;
        loadmeter_bram_addr         <= #`adly 10'd0;
    end    
    else
    begin
        (* parallel_case *)
        case (state_loadmeter_r)
        ST_LOADMETER_R_IDLE:
        begin
            if (loadmeter_rdata_sig==1'b1)
            begin
               loadmeter_bram_addr          <= #`adly LOADMETER_RDATA_STRTADDR;
               loadmeter_bram_enb           <= #`adly 1'b1;                    
               state_loadmeter_r            <= #`adly ST_LOADMETER_R_INTRM;
            end  
            else
            begin
               loadmeter_bram_addr         <= #`adly 10'd0; 
               loadmeter_bram_enb          <= #`adly 1'b0;                    
               state_loadmeter_r           <= #`adly ST_LOADMETER_R_IDLE;
            end  
        end
        ST_LOADMETER_R_INTRM:
        begin
            loadmeter_bram_addr            <= #`adly loadmeter_bram_addr + 1;
            loadmeter_bram_enb             <= #`adly 1'b1; 
            state_loadmeter_r              <= #`adly ST_LOADMETER_R_REG1;
        end
        ST_LOADMETER_R_REG1:
        begin
            loadmeter_bram_addr            <= #`adly loadmeter_bram_addr + 1;
            loadmeter_bram_enb             <= #`adly 1'b1; 
            state_loadmeter_r              <= #`adly ST_LOADMETER_R_REG2;
            
        end        
        ST_LOADMETER_R_REG2:
        begin
            loadmeter_bram_addr             <= #`adly loadmeter_bram_addr + 1;
            loadmeter_bram_enb              <= #`adly 1'b1; 
            state_loadmeter_r               <= #`adly ST_LOADMETER_R_REG3;
        
            meter_load_3p                   <= #`adly bram_din;
        end   
        ST_LOADMETER_R_REG3:
        begin
            loadmeter_bram_addr             <= #`adly loadmeter_bram_addr + 1;
            loadmeter_bram_enb              <= #`adly 1'b1; 
            state_loadmeter_r               <= #`adly ST_LOADMETER_R_REG4;
            
            meter_load_3q                   <= #`adly bram_din;
        end 
        ST_LOADMETER_R_REG4:
        begin
            loadmeter_bram_addr             <= #`adly loadmeter_bram_addr + 1;
            loadmeter_bram_enb              <= #`adly 1'b1; 
            state_loadmeter_r               <= #`adly ST_LOADMETER_R_REG5;
            meter_load_3s                   <= #`adly bram_din;
        end   
        ST_LOADMETER_R_REG5:
        begin
            loadmeter_bram_addr             <= #`adly loadmeter_bram_addr + 1;
            loadmeter_bram_enb              <= #`adly 1'b1; 
            state_loadmeter_r               <= #`adly ST_LOADMETER_R_REG6;
            meter_load_pf                   <= #`adly bram_din;
        end 
        ST_LOADMETER_R_REG6:
        begin
            loadmeter_bram_addr             <= #`adly loadmeter_bram_addr + 1;
            loadmeter_bram_enb              <= #`adly 1'b1; 
            state_loadmeter_r               <= #`adly ST_LOADMETER_R_REG7;
            meter_load_ia                   <= #`adly bram_din;
        end    
        ST_LOADMETER_R_REG7:
        begin
            loadmeter_bram_addr             <= #`adly loadmeter_bram_addr + 1;
            loadmeter_bram_enb              <= #`adly 1'b1; 
            state_loadmeter_r               <= #`adly ST_LOADMETER_R_REG8;
            meter_load_ib                   <= #`adly bram_din;
        end 
        ST_LOADMETER_R_REG8:
        begin
            loadmeter_bram_addr             <= #`adly loadmeter_bram_addr + 1;
            loadmeter_bram_enb              <= #`adly 1'b1; 
            state_loadmeter_r               <= #`adly ST_LOADMETER_R_REG9;
            meter_load_ic                   <= #`adly bram_din;
        end  
        ST_LOADMETER_R_REG9:
        begin
            loadmeter_bram_addr             <= #`adly loadmeter_bram_addr + 1;
            loadmeter_bram_enb              <= #`adly 1'b1; 
            state_loadmeter_r               <= #`adly ST_LOADMETER_R_REG10;
            meter_load_in                   <= #`adly bram_din;
        end 
        ST_LOADMETER_R_REG10:
        begin
            loadmeter_bram_addr             <= #`adly loadmeter_bram_addr + 1;
            loadmeter_bram_enb              <= #`adly 1'b1; 
            state_loadmeter_r               <= #`adly ST_LOADMETER_R_REG11;
            meter_load_vab                  <= #`adly bram_din;
        end    
        ST_LOADMETER_R_REG11:
        begin
            loadmeter_bram_addr             <= #`adly 10'd0;
            loadmeter_bram_enb              <= #`adly 1'b0; 
            state_loadmeter_r               <= #`adly ST_LOADMETER_R_REG12;
            meter_load_vbc                  <= #`adly bram_din;
        end
        ST_LOADMETER_R_REG12:
        begin
            state_loadmeter_r               <= #`adly ST_LOADMETER_R_REG13;
            meter_load_vca                  <= #`adly bram_din;
        end     
        ST_LOADMETER_R_REG13:
        begin
            state_loadmeter_r               <= #`adly ST_LOADMETER_R_VLD;
            meter_load_freq                 <= #`adly bram_din;
            meter_loadrdata_vld             <= #`adly 1'b1;
        end                 
        ST_LOADMETER_R_VLD:
        begin
            if (loadmeter_rdata_sig==1'b1)
            begin
               meter_loadrdata_vld        <= #`adly 1'b0;                    
               state_loadmeter_r          <= #`adly ST_LOADMETER_R_VLD;
            end  
            else
            begin
               meter_loadrdata_vld        <= #`adly 1'b0;                    
               state_loadmeter_r          <= #`adly ST_LOADMETER_R_IDLE;
            end  
        end       
        endcase
    end
end  

//********************* PL to PS Write Commands Code *******************************

always @ (posedge clkin or negedge arst_n)
begin
    if (~arst_n)
    begin
            bess_pvld_wltch         <= #`adly 1'b0;
            bess_p_w_ltch           <= #`adly 32'd0;
    end
    else if (bess_pvld_w)
        begin
            bess_pvld_wltch         <= #`adly 1'b1;
            bess_p_w_ltch           <= #`adly bess_p_w;
        end
    else if (wcmd_sig_lastcmd[`WCMD_STAT_BESSp]) 
    begin
        bess_pvld_wltch         <= #`adly 1'b0; 
        bess_p_w_ltch           <= #`adly bess_p_w_ltch;
    end   
end

always @ (posedge clkin or negedge arst_n)
begin
    if (~arst_n)
    begin
        pv_pvld_wltch         <= #`adly 1'b0;
        pv_p_w_ltch           <= #`adly 32'd0;
    end  
    else if (pv_pvld_w)
    begin
        pv_pvld_wltch         <= #`adly 1'b1;
        pv_p_w_ltch           <= #`adly pv_p_w;  
    end
    else if (wcmd_sig_lastcmd[`WCMD_STAT_PVp]) 
    begin
        pv_pvld_wltch         <= #`adly 1'b0; 
        pv_p_w_ltch           <= #`adly pv_p_w_ltch; 
    end   
end

always @ (posedge clkin or negedge arst_n)
begin
    if (~arst_n)
    begin
        rly_brkopvld_w_ltch         <= #`adly 1'b0;
        rly_brkop_w_ltch            <= #`adly 1'b0;
    end  
    else if (rly_brkopvld_w)
    begin
        rly_brkopvld_w_ltch         <= #`adly 1'b1;
        rly_brkop_w_ltch            <= #`adly rly_brkop_w;  
    end
    else if (wcmd_sig_lastcmd[`WCMD_STAT_Rlybkop]) 
    begin
        rly_brkopvld_w_ltch         <= #`adly 1'b0;
        rly_brkop_w_ltch            <= #`adly rly_brkop_w_ltch;
    end   
end

always @ (posedge clkin or negedge arst_n)
begin
    if (~arst_n)
    begin
        rly_brkclvld_w_ltch         <= #`adly 1'b0;
        rly_brkcl_w_ltch            <= #`adly 1'b0;
    end  
    else if (rly_brkclvld_w)
    begin
        rly_brkclvld_w_ltch         <= #`adly 1'b1;
        rly_brkcl_w_ltch            <= #`adly rly_brkcl_w;  
    end
    else if (wcmd_sig_lastcmd[`WCMD_STAT_Rlybkcl]) 
    begin
        rly_brkclvld_w_ltch         <= #`adly 1'b0;
        rly_brkcl_w_ltch            <= #`adly rly_brkcl_w_ltch;
    end   
end

always @ (posedge clkin or negedge arst_n)
begin
    if (~arst_n)
    begin
        bess_islandmodevld_w_ltch         <= #`adly 1'b0;
        bess_islandmode_w_ltch            <= #`adly 1'b0;
    end  
    else if (bess_islandmodevld_w)
    begin
        bess_islandmodevld_w_ltch         <= #`adly 1'b1;
        bess_islandmode_w_ltch            <= #`adly bess_islandmode_w;  
    end
    else if (wcmd_sig_lastcmd[`WCMD_STAT_BESSislnd]) 
    begin
        bess_islandmodevld_w_ltch         <= #`adly 1'b0;
        bess_islandmode_w_ltch            <= #`adly bess_islandmode_w_ltch;
    end   
end
always @ (posedge clkin or negedge arst_n)
begin
    if (~arst_n)
    begin
        bess_islandmodevoltvld_w_ltch         <= #`adly 1'b0;
        bess_islandmodevolt_w_ltch            <= #`adly 16'd0;
    end  
    else if (bess_islandmodevoltvld_w)
    begin
        bess_islandmodevoltvld_w_ltch         <= #`adly 1'b1;
        bess_islandmodevolt_w_ltch            <= #`adly bess_islandmodevolt_w;  
    end
    else if (wcmd_sig_lastcmd[`WCMD_STAT_BESSvlt]) 
    begin
        bess_islandmodevoltvld_w_ltch         <= #`adly 1'b0;
        bess_islandmodevolt_w_ltch            <= #`adly bess_islandmodevolt_w_ltch;
    end   
end
always @ (posedge clkin or negedge arst_n)
begin
    if (~arst_n)
    begin
        bess_islandmodefrqvld_w_ltch         <= #`adly 1'b0;
        bess_islandmodefrq_w_ltch            <= #`adly 16'd0;
    end  
    else if (bess_islandmodefrqvld_w)
    begin
        bess_islandmodefrqvld_w_ltch         <= #`adly 1'b1;
        bess_islandmodefrq_w_ltch            <= #`adly bess_islandmodefrq_w;  
    end
    else if (wcmd_sig_lastcmd[`WCMD_STAT_BESSfrq]) 
    begin
        bess_islandmodefrqvld_w_ltch         <= #`adly 1'b0;
        bess_islandmodefrq_w_ltch            <= #`adly bess_islandmodefrq_w_ltch;
    end   
end
always @ (posedge clkin or negedge arst_n)
begin
    if (~arst_n)
    begin
        gen_opmodvld_w_ltch         <= #`adly 1'b0;
        gen_opmod_w_ltch            <= #`adly 8'd0;
    end  
    else if (gen_opmodvld_w)
    begin
        gen_opmodvld_w_ltch         <= #`adly 1'b1;
        gen_opmod_w_ltch            <= #`adly gen_opmod_w;  
    end
    else if (wcmd_sig_lastcmd[`WCMD_STAT_Genopmod]) 
    begin
        gen_opmodvld_w_ltch         <= #`adly 1'b0;
        gen_opmod_w_ltch            <= #`adly gen_opmod_w_ltch;
    end   
end

always @ (posedge clkin or negedge arst_n)
begin
    if (~arst_n)
    begin
        gen_runvld_w_ltch         <= #`adly 1'b0;
        gen_run_w_ltch            <= #`adly 1'b0;
    end  
    else if (gen_runvld_w)
    begin
        gen_runvld_w_ltch         <= #`adly 1'b1;
        gen_run_w_ltch            <= #`adly gen_run_w;  
    end
    else if (wcmd_sig_lastcmd[`WCMD_STAT_Genrun]) 
    begin
        gen_runvld_w_ltch         <= #`adly 1'b0;
        gen_run_w_ltch            <= #`adly gen_run_w_ltch;
    end   
end

always @ (posedge clkin or negedge arst_n)
begin
    if (~arst_n)
        pspl_wcmd_bsyreg         <= #`adly 1'b0;
    else
        pspl_wcmd_bsyreg         <= #`adly pspl_wcmd_bsy;   
end

//Write Command BRAM state machine
always @ (posedge clkin or negedge arst_n)
begin
    if (~arst_n)
    begin
        state_wcmd          <= #`adly ST_WCMD_LOOP;
        bramw_enb           <= #`adly 1'b1;
        bramw_web           <= #`adly 4'd0;
        wcmd_sig            <= #`adly 64'd0;        
        wcmd_sig_hld        <= #`adly 64'd0;
        wcmd_sig_lastcmd    <= #`adly 64'd0;
    end
    else
    begin
        (* parallel_case *)
        case (state_wcmd)
        ST_WCMD_LOOP:
        begin
            if (pspl_wcmd_bsy & (~pspl_wcmd_bsyreg) & (wcmd_sig_hld!=64'd0)) begin 
                wcmd_sig_hld                            <= #`adly 64'd0;
                state_wcmd                              <= #`adly ST_WCMD_LOOP;
            end
            else if (bess_pvld_wltch) begin
                wcmd_sig_hld[`WCMD_STAT_BESS]           <= #`adly 1'b1;
                wcmd_sig_hld[`WCMD_STAT_BESSp]          <= #`adly 1'b1;
                wcmd_sig_lastcmd[`WCMD_STAT_BESS]       <= #`adly 1'b1;
                wcmd_sig_lastcmd[`WCMD_STAT_BESSp]      <= #`adly 1'b1;
                bramw_dout                              <= #`adly bess_p_w_ltch;
                bramw_addr_10bit                        <= #`adly WBRAMADDR_BESS_P;
                bramw_web                               <= #`adly {1'b1,1'b1,1'b1,1'b1};
                state_wcmd                              <= #`adly ST_WCMD_SIG;
            end
            else if (pv_pvld_wltch) begin
                wcmd_sig_hld[`WCMD_STAT_PV]             <= #`adly 1'b1;
                wcmd_sig_hld[`WCMD_STAT_PVp]            <= #`adly 1'b1;
                wcmd_sig_lastcmd[`WCMD_STAT_PV]         <= #`adly 1'b1;
                wcmd_sig_lastcmd[`WCMD_STAT_PVp]        <= #`adly 1'b1;
                bramw_dout                              <= #`adly pv_p_w_ltch;
                bramw_addr_10bit                        <= #`adly WBRAMADDR_PV_P;
                bramw_web                               <= #`adly {1'b1,1'b1,1'b1,1'b1};
                state_wcmd                              <= #`adly ST_WCMD_SIG;             
            end
            else if (rly_brkopvld_w_ltch) begin
                wcmd_sig_hld[`WCMD_STAT_Rly]             <= #`adly 1'b1;
                wcmd_sig_hld[`WCMD_STAT_Rlybkop]         <= #`adly 1'b1;
                wcmd_sig_lastcmd[`WCMD_STAT_Rly]         <= #`adly 1'b1;
                wcmd_sig_lastcmd[`WCMD_STAT_Rlybkop]     <= #`adly 1'b1;
                bramw_dout                               <= #`adly {31'd0, rly_brkop_w_ltch};
                bramw_addr_10bit                         <= #`adly WBRAMADDR_RLY_BRKOP;
                bramw_web                                <= #`adly {1'b0,1'b0,1'b0,1'b1};
                state_wcmd                               <= #`adly ST_WCMD_SIG;             
            end
            else if (rly_brkclvld_w_ltch) begin
                wcmd_sig_hld[`WCMD_STAT_Rly]             <= #`adly 1'b1;
                wcmd_sig_hld[`WCMD_STAT_Rlybkcl]         <= #`adly 1'b1;
                wcmd_sig_lastcmd[`WCMD_STAT_Rly]         <= #`adly 1'b1;
                wcmd_sig_lastcmd[`WCMD_STAT_Rlybkcl]     <= #`adly 1'b1;
                bramw_dout                               <= #`adly {23'd0, rly_brkcl_w_ltch,8'd0};//Note 3
                bramw_addr_10bit                         <= #`adly WBRAMADDR_RLY_BRKCL;
                bramw_web                                <= #`adly {1'b0,1'b0,1'b1,1'b0};
                state_wcmd                               <= #`adly ST_WCMD_SIG;             
            end
             else if (bess_islandmodevld_w_ltch) begin
                wcmd_sig_hld[`WCMD_STAT_BESS]               <= #`adly 1'b1;
                wcmd_sig_hld[`WCMD_STAT_BESSislnd]          <= #`adly 1'b1;
                wcmd_sig_lastcmd[`WCMD_STAT_BESS]           <= #`adly 1'b1;
                wcmd_sig_lastcmd[`WCMD_STAT_BESSislnd]      <= #`adly 1'b1;
                bramw_dout                                  <= #`adly {23'd0, bess_islandmode_w_ltch,8'd0};
                bramw_addr_10bit                            <= #`adly WBRAMADDR_BESS_ISLND;
                bramw_web                                   <= #`adly {1'b0,1'b0,1'b1,1'b0};
                state_wcmd                                  <= #`adly ST_WCMD_SIG;             
            end           
             else if (bess_islandmodevoltvld_w_ltch) begin
                wcmd_sig_hld[`WCMD_STAT_BESS]               <= #`adly 1'b1;
                wcmd_sig_hld[`WCMD_STAT_BESSvlt]            <= #`adly 1'b1;
                wcmd_sig_lastcmd[`WCMD_STAT_BESS]           <= #`adly 1'b1;
                wcmd_sig_lastcmd[`WCMD_STAT_BESSvlt]        <= #`adly 1'b1;
                bramw_dout                                  <= #`adly {16'd0,bess_islandmodevolt_w_ltch} ;
                bramw_addr_10bit                            <= #`adly WBRAMADDR_BESS_V;
                bramw_web                                   <= #`adly {1'b0,1'b0,1'b1,1'b1};
                state_wcmd                                  <= #`adly ST_WCMD_SIG;             
            end   
             else if (bess_islandmodefrqvld_w_ltch) begin
                wcmd_sig_hld[`WCMD_STAT_BESS]               <= #`adly 1'b1;
                wcmd_sig_hld[`WCMD_STAT_BESSfrq]            <= #`adly 1'b1;
                wcmd_sig_lastcmd[`WCMD_STAT_BESS]           <= #`adly 1'b1;
                wcmd_sig_lastcmd[`WCMD_STAT_BESSfrq]        <= #`adly 1'b1;
                bramw_dout                                  <= #`adly {bess_islandmodefrq_w_ltch,16'd0} ;
                bramw_addr_10bit                            <= #`adly WBRAMADDR_BESS_F;
                bramw_web                                   <= #`adly {1'b1,1'b1,1'b0,1'b0};
                state_wcmd                                  <= #`adly ST_WCMD_SIG;             
            end  
             else if (gen_runvld_w_ltch) begin
                wcmd_sig_hld[`WCMD_STAT_Gen]                <= #`adly 1'b1;
                wcmd_sig_hld[`WCMD_STAT_Genrun]           <= #`adly 1'b1;
                wcmd_sig_lastcmd[`WCMD_STAT_Gen]            <= #`adly 1'b1;
                wcmd_sig_lastcmd[`WCMD_STAT_Genrun]       <= #`adly 1'b1;
                bramw_dout                                  <= #`adly {24'd0,gen_run_w_ltch} ;
                bramw_addr_10bit                            <= #`adly WBRAMADDR_GEN_RUN;
                bramw_web                                   <= #`adly {1'b0,1'b0,1'b0,1'b1};
                state_wcmd                                  <= #`adly ST_WCMD_SIG;             
            end  
             else if (gen_opmodvld_w_ltch) begin
                wcmd_sig_hld[`WCMD_STAT_Gen]                <= #`adly 1'b1;
                wcmd_sig_hld[`WCMD_STAT_Genopmod]           <= #`adly 1'b1;
                wcmd_sig_lastcmd[`WCMD_STAT_Gen]            <= #`adly 1'b1;
                wcmd_sig_lastcmd[`WCMD_STAT_Genopmod]       <= #`adly 1'b1;
                bramw_dout                                  <= #`adly {16'd0,gen_opmod_w_ltch,8'd0} ;
                bramw_addr_10bit                            <= #`adly WBRAMADDR_GEN_OPMOD;
                bramw_web                                   <= #`adly {1'b0,1'b0,1'b1,1'b0};
                state_wcmd                                  <= #`adly ST_WCMD_SIG;             
            end  
            //Add more else if statements here for other commands. See Note 2
            else if ((wcmd_sig_hld!=64'd0) & (~pspl_wcmd_bsy) & pspl_wcmd_bsyreg) begin
                state_wcmd                              <= #`adly ST_WCMD_SIG;
            end                
            else begin
                state_wcmd                              <= #`adly ST_WCMD_LOOP;
            end                            
        end
        ST_WCMD_SIG:
        begin
            if (~pspl_wcmd_bsy) begin
                wcmd_sig[63:1]      <=  #`adly wcmd_sig_hld[63:1]; //passing commands to PS
                wcmd_sig[0]        <=  #`adly ~wcmd_sig[0];      //toggling to ensure interrupt is generated even if same command is sent
                wcmd_sig_lastcmd    <=  #`adly 64'd0;
                bramw_web           <=  #`adly 4'd0;
                state_wcmd          <=  #`adly ST_WCMD_LOOP;
            end
            else if (pspl_wcmd_bsy & (~pspl_wcmd_bsyreg) ) begin //executes when pspl_wcmd_bsy asserts for first time
                wcmd_sig_hld        <=  #`adly wcmd_sig_hld & wcmd_sig_lastcmd; //zero out all the bits except last command since earlier commands have already been sent to PS
                wcmd_sig_lastcmd    <=  #`adly 64'd0;
                bramw_web           <=  #`adly 4'd0;
                state_wcmd          <=  #`adly ST_WCMD_LOOP;
            end
            else begin 
                bramw_web           <=  #`adly 4'd0;
                wcmd_sig_lastcmd    <=  #`adly 64'd0;
                state_wcmd          <=  #`adly ST_WCMD_LOOP;
            end

        end
        endcase
    end    
end  


// //Write Command BRAM state machine
// always @ (posedge clkin or negedge arst_n)
// begin
//     if (~arst_n)
//     begin
//         state_wcmd          <= #`adly ST_WCMD_LOOP;
//         bramw_enb           <= #`adly 1'b1;
//         bramw_web           <= #`adly 4'd0;
//         wcmd_sig            <= #`adly 32'd0;        
//         wcmd_sig_hld        <= #`adly 32'd0;
//         wcmd_sig_lastcmd    <= #`adly 32'd0;
//     end
//     else
//     begin
//         (* parallel_case *)
//         case (state_wcmd)
//         ST_WCMD_LOOP:
//         begin
//             if (bess_pvld_wltch) begin
//                 wcmd_sig_hld[`WCMD_STAT_BESS]           <= #`adly 1'b1;
//                 wcmd_sig_hld[`WCMD_STAT_BESSp]          <= #`adly 1'b1;
//                 wcmd_sig_lastcmd[`WCMD_STAT_BESS]       <= #`adly 1'b1;
//                 wcmd_sig_lastcmd[`WCMD_STAT_BESSp]      <= #`adly 1'b1;
//                 bramw_dout                              <= #`adly bess_p_w_ltch;
//                 bramw_addr_10bit                        <= #`adly WBRAMADDR_BESS_P;
//                 bramw_web                               <= #`adly {1'b1,1'b1,1'b1,1'b1};
//                 state_wcmd                              <= #`adly ST_WCMD_SIG;
//             end
//             else if (pv_pvld_wltch) begin
//                 wcmd_sig_hld[`WCMD_STAT_PV]             <= #`adly 1'b1;
//                 wcmd_sig_hld[`WCMD_STAT_PVp]            <= #`adly 1'b1;
//                 wcmd_sig_lastcmd[`WCMD_STAT_PV]         <= #`adly 1'b1;
//                 wcmd_sig_lastcmd[`WCMD_STAT_PVp]        <= #`adly 1'b1;
//                 bramw_dout                              <= #`adly pv_p_w_ltch;
//                 bramw_addr_10bit                        <= #`adly WBRAMADDR_PV_P;
//                 bramw_web                               <= #`adly {1'b1,1'b1,1'b1,1'b1};
//                 state_wcmd                              <= #`adly ST_WCMD_SIG;                
                
//             end    
//             //Add more else if statements here for other commands                                
//         end
//         ST_WCMD_SIG:
//         begin
//             if (~pspl_wcmd_bsy) begin
//                 wcmd_sig[30:0]      <=  #`adly wcmd_sig_hld[30:0]; //passing commands to PS
//                 wcmd_sig[31]        <=  #`adly ~wcmd_sig[31];      //toggling to ensure interrupt is generated even if same command is sent
//                 wcmd_sig_lastcmd    <=  #`adly 32'd0;
//                 bramw_web           <=  #`adly 4'd0;
//                 state_wcmd          <=  #`adly ST_WCMD_LOOP;
//             end
//             else if (pspl_wcmd_bsy&(~pspl_wcmd_bsyreg)) begin //executes when pspl_wcmd_bsy asserts for first time
//                 wcmd_sig_hld        <=  #`adly wcmd_sig_hld & wcmd_sig_lastcmd; //zero out all the bits except last command since earlier commands have already been sent to PS
//                 wcmd_sig_lastcmd    <=  #`adly 32'd0;
//                 bramw_web           <=  #`adly 4'd0;
//                 state_wcmd          <=  #`adly ST_WCMD_LOOP;
//             end
//             else if (pspl_wcmd_bsy) begin //executes if pspl_wcmd_bsy remains asserted next time 
//                 wcmd_sig_lastcmd    <=  #`adly 32'd0;
//                 bramw_web           <=  #`adly 4'd0;
//                 state_wcmd          <=  #`adly ST_WCMD_LOOP;
//             end

//         end
//         endcase
//     end    
// end  





endmodule