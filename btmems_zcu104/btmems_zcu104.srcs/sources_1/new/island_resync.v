`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Syed Fahad Akhtar 
// 
// Create Date: 3/17/2023 10:28:00 PM
// Design Name: 
// Module Name: island_resync
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description:  Islanding and Grid Resync Module
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created

//Logic Description:
//This code is for islanding from the grid and resynchronization to the grid 

// Additional Comments: 
// 1- Min Wh to island with BESS. This number is computed in PS using RHS of following equation:
//    BESS Wh >  (BESS Wh @ min SoC (Wh corresponding to usr_bess_minsoc below which BESS not allowed  to discharge) + 
//                BESS Wh corresponding to BESS to GFM transfer margin (to allow smooth transfer to another GFM resource) + 
//                BESS Wh corresponding to minimum islanding duration with BESS)
// 2 - 1 highest priortiy, 3 lowest. If set to 0, the asset will not be used for islanding
// 3 - Island command from PS domain is generated either when user issues a direct island command or based on user provided scehduled start time 
// 4 - Grid resync command is generated from PS domain either  when user issues a direct resync command or resync flag is genertaed based on user provided scheduled 
//     island end time or scheudled island duration
// 5 - Regarding unplanned islanding (POI CB Open), we dont write Vref and Fref during grid to island transition. This is because for unplanned, Vref and Fref needs to
//     be set to nominal values and as such we set Vref and Fref to nominal values only once via PS domain (TO BE IMPLEMENTED IN PS)
// 7-  This number is computed in PS using following equation:
//      BESS Wh @ min SoC (Wh corresponding to usr_bess_minsoc below which BESS not allowed  to discharge) + 
//      BESS Wh corresponding to BESS to GFM transfer margin (to allow smooth transfer to another GFM resource) 
// 8 -  Computed in PS domain. This can be for instance 90% of (BESS energy @ 100%SoE) for UL and 85% for LL        
// 9 - This will do seamless islanding if POI CB is not open by relay already. If seamless with genset not desired, insert another state to first open the POI CB
// 10 - Setting to zero only during transition to avoid exceess PV power and/or sudden variation (decrease) in load tripping genset when POI CB opens or when bess2genset
//      transition occurs. Assumption is genset can take up entire load
// 11 - Before commanding GFM exit for genset and turning off genset PV PID, you should turn off PV. Otherwise PV will shutoff when genset goes down (causing grid recon
//      timer to begin) which is also fine but if you want a controlled shutdown, you can insert a state to first turn off PV
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

`include "defines.vh"

module island_resync (
    input                               clkin,
    input                               arst_n,
    
    input                   [15:0]      sec_cntr,  
    //POI Meter Interface
    input                               meter_poi_rdatavld_crlgc,
    input signed            [31:0]      meter_poi_3p_crlgc,                 //sign convention: -ve for export to utility
    input                   [31:0]      meter_poi_vab_crlgc,                //Volts         
    input                   [31:0]      meter_poi_freq_crlgc,               //mHz (i.e. scale Hz by x1000 in PS domain)

    //BESS Meter Interface
    input  signed           [31:0]      meter_bess_3p_crlgc,  
    input                               meter_bess_rdatavld_crlgc,

    //Genset Meter Interface
    input signed            [31:0]      meter_gen_3p_crlgc,
    input                               meter_gen_rdatavld_crlgc,              

    //PV Meter Interface
    input signed            [31:0]      meter_pv_3p_crlgc,    
    input                               meter_pv_rdatavld_crlgc,

    //POI Relay Interface       
    input                               rly_oc_prot_crlgc,           
    input                               poi_cb_op_crlgc,   
    input                               poi_cb_cl_crlgc,     

    output  reg                         rly_poibrkop_crlgc,                 //POI breaker open command - 1shot
    output  reg                         rly_poibrkcl_crlgc,                 //POI breaker close command - 1shot
    output  reg                         rly_brkopvld_w_crlgc,
    output  reg                         rly_brkclvld_w_crlgc,

    //User Parameter Interface
    input                   [31:0]      usr_bessislnd_minwh,                //min wh for island with BESS. Note 1 
    input                   [31:0]      usr_bessislnd_maxwh_ul,             //max wh in island upper limit deadband. Note 8
    input                   [31:0]      usr_bessislnd_maxwh_ll,             //max wh in island lower limit deadband. Note 8
    input                   [31:0]      usr_bessislndext_minwh,             //Min wh before exiting island with BESS. Note 7
    input                   [31:0]      usr_maxld_islnd,                    //Peak load expected in island (Watts)
    input                               usr_poibrkcl_cmd,                   //Breaker Close command
    input                               usr_islnd_cmd,                      //Island command, Note 3
    input                               usr_bess_en,        
    input                   [1:0]       usr_bess_gfmprio,                   //Note 2
    input                   [1:0]       usr_gen_gfmprio,
    input                   [31:0]      usr_grdhlthy_vmin,                  //Min voltage for healthy grid criterion (x100 scaled)
    input                   [31:0]      usr_grdhlthy_vmax,                  //Max voltage for healthy grid criterion (x100 scaled)
    input                   [31:0]      usr_grdhlthy_fmin,                  //Min frequency for healthy grid criterion (x100 scaled)
    input                   [31:0]      usr_grdhlthy_fmax,                  //Max frequency for healthy grid criterion (x100 scaled)      
    input                   [15:0]      usr_grdhlthy_dur,                   //Minimum duration for healthy grid criterion (in seconds)
    input                               usr_gen_en,
    input                               usr_grid_resync,                    //Grid Resync Command, Note 4
    input                               usr_autoislnd_en,                   //Automatic Islanding Enable
    input                               usr_bess2gen_trnsf,                 //BESS to Genset Island tranfer
    input                               usr_gen2bess_trnsf,                 //Genset to BESS Island tranfer
    input                               usr_auto_resync,                    //auto resync enable when grid returns
    input                               usr_cltrns_resync,                  //seamless or close transition grid resync enable
    input signed            [31:0]      usr_pv_max,                         //Max PV Power in Watts
    input signed            [31:0]      usr_gen_baseld,                     //Minimum genset base load in Watts
    input                               usr_pv_en,                          //PV Enable
    input signed            [31:0]      usr_pv_kp,                          //sign convention: +ve values.
    input signed            [31:0]      usr_pv_ki,                          //sign convention: +ve values.
    input signed            [31:0]      usr_pv_kd,                          //sign convention: +ve values.
    input                               usr_param_vld,                      //this is 1-shot

    //BESS Interface
    input                   [31:0]      bess_wh_r_crlgc,                    //BESS Energy in Wh @ current BESS SoC/SoE 
    input                               bess_flt_crlgc,
    input                               bess_gfm_stat_crlgc,  
    input                   [31:0]      bess_maxdschgpwr_r_crlgc,   
    input   signed          [31:0]      bess_maxchgpwr_r_crlgc,
    input   signed          [15:0]      bess_islandmodevolt_r_crlgc,
    input   signed          [15:0]      bess_islandmodefrq_r_crlgc,
    output  reg                         bess_gfmcmd_crlgc,                  //BESS Grid Forming Command
    output  reg                         bess_gfmexit_crlgc,                 //BESS Grid Forming Exit Command

    output reg              [15:0]      bess_islandmodefrq_w_crlgc,         //mHz
    output reg                          bess_islandmodefrqvld_w_crlgc,      

    output reg              [15:0]      bess_islandmodevolt_w_crlgc,        //Volts
    output reg                          bess_islandmodevoltvld_w_crlgc,

    //Genset Interface  
    input                               gen_flt_crlgc,
    input                               gen_gfm_stat_crlgc,        
    output reg                          gen_gfmcmd,                   //Genset Grid Forming Command
    output reg                          gen_gfmshut,               //Genset shutdown command

    //PV Interface  
    output reg signed       [31:0]      pv_p_isl,
    output reg                          pv_pisl_vld,

    //Internal Inputs
    input                               usr_shutdown_1shot,                 //To asset_dispatch module
    output  reg                         island_state_sig                    //To asset_dispatch module   
    );

wire                    islnd_trig_1shot;
wire                    usr_islnd_cmd1shot;
wire                    usr_grid_resync1shot;
wire                    usr_bess2gen_trnsf1shot;
wire                    usr_gen2bess_trnsf1shot;
wire                    pps; //pulse per second
wire                    bess_gfm_cnd;
wire                    gen_gfm_cnd;
wire signed [31:0]      meter_gen3p_crlgc_fxp;    
wire signed [31:0]      usr_pvmax_fxp;  

wire signed [31:0]      pvgen_p_werr;      


wire signed [31:0]      bess_chrg_lmtfxp;
wire signed [31:0]      meter_bess_3p_crlgc_fxp;   
wire signed [31:0]      usr_pvbessmax_fxp;
wire signed [31:0]      usr_pvbessmaxerr_fxp;
wire signed [31:0]      meter_bess3p_pvbess_fxp;
wire signed [31:0]      dout_0_PVbesserr_tmp;
wire signed [31:0]      pvisl_pid_output;
wire signed [31:0]      pvisl_dout_1_V;
wire                    pvisl_ap_done; 
wire                    pvisl_ap_ready; 

reg         [4:0]   state_island;
reg         [4:0]   state_island_reg;
reg         [4:0]   state_prv;
reg                 bess_islnd_rdy;
reg                 gen_islnd_rdy;
reg                 islnd_trig;
reg                 islnd_trig_reg;
reg         [15:0]  sec_cnt_initval;  
reg                 bess_gfm_fail;
reg                 gen_gfm_fail;
reg         [7:0]   sec_cntr_ghlthy;
reg                 trig_cnt_ghlthy;
reg         [26:0]  accum;
reg                 gen_gfmcexit_crlgc;
reg                 auto_resync;
reg                 usr_islnd_cmdltch;
reg        [31:0]   usr_pv_ki_reg;
reg                 pvgen_pid_rst;
reg                 pvgen_pid_en;
reg      [31:0]     pvgen_pisl_trns;
reg                 pvgen_pisl_trns_vld;  
reg signed  [31:0]  pvgen_pisl_pid;
reg                 pvgen_pisl_pid_vld;  
reg signed  [31:0]  pvgen_pisl;
reg                 pvgen_pisl_vld;
reg                 pvbess_pid_rst;   
reg  signed [31:0]  bess_chrg_lmt;
reg  signed [31:0]  usr_pvbessmax;
reg  signed [31:0]  meter_bess3p_pvbess;
reg  signed [31:0]  usr_pvbess_ki;
reg                 meter_bess_rdatavldcrlgc_reg;
reg signed  [31:0]  pvbess_p_werr;
reg signed  [31:0]  pvbess_pisl;
reg                 pvbess_ap_done_reg;
reg signed  [31:0]  pvbess_p_w_prv;
reg                 pvbess_pisl_vld;
reg signed [31:0]   dout_0_PVbesserr;

reg                 pvisl_pid_rst;   
reg                 pvisl_pid_en;       
reg         [31:0]  pvisl_pid_ki;    
reg signed  [31:0]  pvisl_pid_ul;    
reg signed  [31:0]  pvisl_pid_ll;   
reg signed  [31:0]  pvisl_piderr_ul; 
reg signed  [31:0]  pvisl_piderr_ll; 
reg signed  [31:0]  pvisl_pid_ref;   
reg signed  [31:0]  pvisl_pid_fbk;   

reg signed  [31:0]  dout_0_PVgenerr;
reg                 pvbess_ap_done;
reg                 pvbess_ap_ready;
reg                 pvgen_ap_done;
reg                 pvgen_ap_ready;
reg                 grid_hlthy;
reg                 pvbess_pid_en;
reg signed   [31:0] pvgen_p_w_prv;
reg                 usr_pv_ki_reg_init;
reg                 usr_pvbess_ki_init;
reg signed   [31:0] pvbessisl_dout_1_V;
reg signed   [31:0] pvbessisl_dout_1_V_reg;
reg signed   [31:0] pvgenisl_dout_1_V;
reg                 pvgen_p_trg;
reg                 pvbess_p_trg;

 localparam   

    //BESS Meter read state machine
	ST_ISLND_IDLE		            = 5'd0,
    ST_ISLND_TRG		            = 5'd1,
    ST_ISLND_BESS_CHK               = 5'd2,
    ST_ISLND_GENSET_CHK             = 5'd3,
    ST_ISLND_BESS                   = 5'd4,
    ST_ISLND_GENSET                 = 5'd5,    
    ST_ISLND_BESS_RESYNC            = 5'd6,
    ST_ISLND_GENSET_CHK2            = 5'd7,
    ST_ISLND_BESS_RESYNC2           = 5'd8,
    ST_ISLND_BESS_CLTRNSRESYNC      = 5'd9,
    ST_ISLND_BESS_OPTRNSRESYNC      = 5'd10,
    ST_ISLND_GENSET_OPTRNSRESYNC    = 5'd11,
    ST_ISLND_BESS_CHK2              = 5'd12,    
    ST_ISLND_BESS_GFM               = 5'd13,
    ST_ISLND_BRKOP_CHK              = 5'd14,

    GFM_STAT_TIME                   = 8'd5, //max time in sec to receive GFM status confirmation from a GFM asset
    REFVF_STAT_TIME                 = 8'd5, //max wait time in sec to match vref and fref readback to write values 
    BRKOP_STAT_TIME                 = 8'd5, //max time to wait for breaker open status after open command
    BRKCL_STAT_TIME                 = 8'd5, //max time to wait for breaker close status after close command   
    MISC_STAT_TIME                  = 8'd5, //max time to wait for miscllaneous events


    GRDSYNC_FRQSLP                  = 16'd20; //grid resync frequency slip 20mHz

assign usr_islnd_cmd1shot = usr_islnd_cmd && usr_param_vld;
assign usr_poibrkcl_cmd1shot = usr_poibrkcl_cmd && usr_param_vld; 
assign usr_grid_resync1shot = usr_grid_resync && usr_param_vld;
assign usr_bess2gen_trnsf1shot = usr_bess2gen_trnsf && usr_param_vld;
assign usr_gen2bess_trnsf1shot = usr_gen2bess_trnsf && usr_param_vld;

assign islnd_trig_1shot = islnd_trig && ~islnd_trig_reg; 
assign pps = (accum == 27'd`PL_CLOCK_FREQ);
assign bess_gfm_cnd = bess_islnd_rdy && ( (usr_bess_gfmprio==2'd1) || ((usr_bess_gfmprio==2'd2)&&(usr_gen_gfmprio!=2'd1)) || 
                                          ((usr_bess_gfmprio==2'd3)&&(usr_gen_gfmprio!=2'd2)) ); //you can register this logic if it causes timing violation
assign gen_gfm_cnd = gen_islnd_rdy && (usr_gen_gfmprio!=2'd0);       

assign meter_gen3p_crlgc_fxp = {meter_gen_3p_crlgc[24:0],7'd0};
assign usr_pvmax_fxp = {usr_pv_max[24:0],7'd0};

assign bess_chrg_lmtfxp = {bess_chrg_lmt[24:0],7'd0};

assign meter_bess_3p_crlgc_fxp = {meter_bess_3p_crlgc[24:0],7'd0};

assign usr_pvbessmax_fxp = {usr_pvbessmax[24:0],7'd0};
assign usr_pvbessmaxerr_fxp = usr_pvmax_fxp;

assign meter_bess3p_pvbess_fxp = {meter_bess3p_pvbess[24:0],7'd0};

//state_island_reg
always @ (posedge clkin, negedge arst_n)
begin
    if (~arst_n)
        state_island_reg         <= #`adly 5'd0;
    else
        state_island_reg         <= #`adly state_island;
end

//auto resync - disable upon manual user islanding command 
always @ (posedge clkin, negedge arst_n)
begin
    if (~arst_n)
    begin
        auto_resync         <= #`adly 1'b0;
        usr_islnd_cmdltch   <= #`adly 1'b0;
    end
    else if ((islnd_trig_1shot && rly_oc_prot_crlgc) || ((state_island==ST_ISLND_IDLE)&&(state_island_reg!=ST_ISLND_IDLE)) )
    begin
        auto_resync         <= #`adly usr_auto_resync;  //re-enable auto resync if islanding state machine returns to idle or islanding fails due to OC
        usr_islnd_cmdltch   <= #`adly 1'b0;
    end  
    else if (usr_islnd_cmd1shot || usr_islnd_cmdltch)
    begin
        auto_resync         <= #`adly 1'b0; //disable auto resync
        usr_islnd_cmdltch   <= #`adly 1'b1;
    end
    else
    begin
        auto_resync         <= #`adly usr_auto_resync;
        usr_islnd_cmdltch   <= #`adly 1'b0;
    end
end


//Islanding Trigger - here slow islanding logic can also be incorporated for e.g. following pickup of delayed UV/OV elements
always @ (posedge clkin, negedge arst_n)
begin
    if (~arst_n)
    begin
        islnd_trig         <= #`adly 1'b0;
        islnd_trig_reg     <= #`adly 1'b0;
    end
    else
    begin
        islnd_trig         <= #`adly ( (poi_cb_op_crlgc & usr_autoislnd_en) || usr_islnd_cmd1shot );
        islnd_trig_reg     <= #`adly islnd_trig;
    end
end

//BESS Island Ready - This signal will only be checked to initiate islanding with BESS. Its value is irrelevant during islanding
always @ (posedge clkin, negedge arst_n)
begin
    if (~arst_n)
        bess_islnd_rdy         <= #`adly 1'b0;
    else if ((bess_wh_r_crlgc > usr_bessislnd_minwh) && (bess_maxdschgpwr_r_crlgc > usr_maxld_islnd) && (~bess_flt_crlgc) && usr_bess_en)
        bess_islnd_rdy         <= #`adly 1'b1;
    else
        bess_islnd_rdy         <= #`adly 1'b0; 
end

//gen Island Ready
always @ (posedge clkin, negedge arst_n)
begin
    if (~arst_n)
        gen_islnd_rdy         <= #`adly 1'b0;
    else if ((~gen_flt_crlgc) && usr_gen_en)
        gen_islnd_rdy         <= #`adly 1'b1;
    else
        gen_islnd_rdy         <= #`adly 1'b0; 
end

//Island State Machine
always @ (posedge clkin, negedge arst_n)
begin
    if (~arst_n)
    begin
        state_island                <= #`adly ST_ISLND_IDLE;
        bess_gfmcmd_crlgc           <= #`adly 1'b0;
        gen_gfmcmd            <= #`adly 1'b0;
        bess_gfmexit_crlgc          <= #`adly 1'b0;
        gen_gfmcexit_crlgc          <= #`adly 1'b0; 
        pvgen_pisl_trns_vld         <= #`adly 1'b0;
        pvgen_pid_rst               <= #`adly 1'b0;      
        pvbess_pid_rst              <= #`adly 1'b0;
        bess_gfm_fail               <= #`adly 1'b0;
        gen_gfm_fail                <= #`adly 1'b0;
        sec_cnt_initval             <= #`adly 8'd0;
        rly_poibrkop_crlgc          <= #`adly 1'b0;
        rly_brkopvld_w_crlgc        <= #`adly 1'b0;
        rly_poibrkcl_crlgc          <= #`adly 1'b0;
        rly_brkclvld_w_crlgc        <= #`adly 1'b0;
        island_state_sig            <= #`adly 1'b0;
        state_prv                   <= #`adly ST_ISLND_IDLE;
    end    
    else
    begin
        (* parallel_case *)
        case (state_island)
        ST_ISLND_IDLE:
        begin
            gen_gfm_fail                <= #`adly 1'b0;
            bess_gfm_fail               <= #`adly 1'b0;
            bess_gfmexit_crlgc          <= #`adly 1'b0;
            gen_gfmcexit_crlgc          <= #`adly 1'b0;
            pvgen_pisl_trns_vld         <= #`adly 1'b0;
            pvgen_pid_rst               <= #`adly 1'b0;
            pvbess_pid_rst              <= #`adly 1'b0;
            rly_poibrkcl_crlgc          <= #`adly 1'b0;
            rly_brkclvld_w_crlgc        <= #`adly 1'b0;
            island_state_sig            <= #`adly 1'b0;
            if(islnd_trig_1shot && (~rly_oc_prot_crlgc))
                state_island      <= #`adly ST_ISLND_TRG;
            else 
                state_island      <= #`adly ST_ISLND_IDLE;
        end
        ST_ISLND_TRG:
        begin
            island_state_sig                <= #`adly 1'b1;
            if(bess_gfm_cnd)
            begin
                if (poi_cb_op_crlgc) //unplanned islanding, Note 5 
                begin
                    bess_gfmcmd_crlgc       <= #`adly 1'b1;
                    sec_cnt_initval         <= #`adly sec_cntr;
                    state_island            <= #`adly ST_ISLND_BESS_CHK;
                end
                else //planned islanding 
                begin
                    bess_islandmodevolt_w_crlgc            <= #`adly meter_poi_vab_crlgc[15:0]; 
                    bess_islandmodefrq_w_crlgc             <= #`adly meter_poi_freq_crlgc[15:0];
                    bess_islandmodevoltvld_w_crlgc        <= #`adly 1'b1;
                    bess_islandmodefrqvld_w_crlgc         <= #`adly 1'b1;
                    sec_cnt_initval                        <= #`adly sec_cntr;
                    state_island                           <= #`adly ST_ISLND_BESS_GFM;
                end
            end
            else if(gen_gfm_cnd)
            begin                
                gen_gfmcmd        <= #`adly 1'b1; // Note 9
                pvgen_pisl_trns_vld         <= #`adly 1'b1;
                pvgen_pisl_trns            <= #`adly 32'd0;//Note 10 
                sec_cnt_initval         <= #`adly sec_cntr;
                state_island            <= #`adly ST_ISLND_GENSET_CHK;
            end
            else 
                state_island        <= #`adly ST_ISLND_IDLE;
        end
        ST_ISLND_BESS_GFM:
        begin
            if( (bess_islandmodevolt_r_crlgc==bess_islandmodevolt_w_crlgc) && (bess_islandmodefrq_r_crlgc==bess_islandmodefrq_w_crlgc) )
            begin
                bess_gfmcmd_crlgc       <= #`adly 1'b1;
                sec_cnt_initval         <= #`adly sec_cntr;
                state_island            <= #`adly ST_ISLND_BESS_CHK;
            end 
            else if (sec_cntr != (sec_cnt_initval+REFVF_STAT_TIME))
            begin 
                state_island        <= #`adly ST_ISLND_BESS_GFM;
            end                  
            else
            begin
                state_island        <= #`adly ST_ISLND_IDLE;
            end 
        end 
        ST_ISLND_BESS_CHK:
        begin
            if(bess_gfm_stat_crlgc)
            begin
                bess_gfmcmd_crlgc       <= #`adly 1'b0; //for 1shot command
                rly_poibrkop_crlgc      <= #`adly 1'b1;
                rly_brkopvld_w_crlgc    <= #`adly 1'b1;
                sec_cnt_initval         <= #`adly sec_cntr;
                state_prv               <= #`adly ST_ISLND_BESS_CHK;
                state_island            <= #`adly ST_ISLND_BRKOP_CHK;
            end    
            else if (sec_cntr != (sec_cnt_initval+GFM_STAT_TIME))
            begin
                bess_gfmcmd_crlgc   <= #`adly 1'b0; 
                state_island        <= #`adly ST_ISLND_BESS_CHK; //wait for GFM status
            end    
            else if (gen_islnd_rdy && ~gen_gfm_fail) 
            begin
                bess_gfmcmd_crlgc       <= #`adly 1'b0;
                bess_gfm_fail           <= #`adly 1'b1;//fail flag to avoid re-attempt until state machine cycles back to ideal    
                gen_gfmcmd        <= #`adly 1'b1;//Attempt GFM with genset
                pvgen_pisl_trns_vld         <= #`adly 1'b1;
                pvgen_pisl_trns            <= #`adly 32'd0;//Note 10                  
                sec_cnt_initval         <= #`adly sec_cntr;
                state_island            <= #`adly ST_ISLND_GENSET_CHK; 
            end 
            else
            begin
                bess_gfmcmd_crlgc   <= #`adly 1'b0; 
                state_island        <= #`adly ST_ISLND_IDLE;
            end 
        end  
        ST_ISLND_GENSET_CHK:
        begin
            gen_gfmcmd            <= #`adly 1'b0; //for 1shot command
            pvgen_pisl_trns_vld             <= #`adly 1'b0;// 1-shot
            if(gen_gfm_stat_crlgc && (meter_pv_3p_crlgc==32'd0))    //if you dont get strict 0 pv power due to noise, adjust it 
            begin
                rly_poibrkop_crlgc      <= #`adly 1'b1;
                rly_brkopvld_w_crlgc    <= #`adly 1'b1;           
                sec_cnt_initval         <= #`adly sec_cntr;
                state_prv               <= #`adly ST_ISLND_GENSET_CHK;                
                state_island            <= #`adly ST_ISLND_BRKOP_CHK;
            end    
            else if (sec_cntr != (sec_cnt_initval+MISC_STAT_TIME))
            begin
                state_island          <= #`adly ST_ISLND_GENSET_CHK; //wait for GFM status
            end    
            else if (bess_islnd_rdy && ~bess_gfm_fail) 
            begin
                gen_gfm_fail       <= #`adly 1'b1;  
                if (poi_cb_op_crlgc) 
                begin
                    bess_gfmcmd_crlgc       <= #`adly 1'b1;
                    sec_cnt_initval         <= #`adly sec_cntr;
                    state_island            <= #`adly ST_ISLND_BESS_CHK;
                end
                else 
                begin                  
                    bess_islandmodevolt_w_crlgc            <= #`adly meter_poi_vab_crlgc[15:0]; 
                    bess_islandmodefrq_w_crlgc             <= #`adly meter_poi_freq_crlgc[15:0];
                    bess_islandmodevoltvld_w_crlgc        <= #`adly 1'b1;
                    bess_islandmodefrqvld_w_crlgc         <= #`adly 1'b1;
                    state_island                           <= #`adly ST_ISLND_BESS_GFM;
                end
            end 
            else
            begin
                state_island          <= #`adly ST_ISLND_IDLE;
            end  
        end  
        ST_ISLND_BRKOP_CHK:
        begin
            if(poi_cb_op_crlgc)
            begin
                rly_poibrkop_crlgc      <= #`adly 1'b0;//open cmd clear
                rly_brkopvld_w_crlgc    <= #`adly 1'b1;//clearing the open cmd after receiving open status
                if (state_prv==ST_ISLND_BESS_CHK)
                    begin
                        state_island      <= #`adly ST_ISLND_BESS;
                        pvbess_pid_rst    <= #`adly 1'b1;    //release PID reset (activate PID)
                    end
                else if (state_prv==ST_ISLND_GENSET_CHK)
                begin
                    state_island     <= #`adly ST_ISLND_GENSET;
                    pvgen_pid_rst    <= #`adly 1'b1;    //release PID reset (activate PID)
                end
            end 
            else if (sec_cntr != (sec_cnt_initval+BRKOP_STAT_TIME))
            begin 
                state_island            <= #`adly ST_ISLND_BRKOP_CHK; //wait for breaker to open
                rly_poibrkop_crlgc      <= #`adly 1'b0;
                rly_brkopvld_w_crlgc    <= #`adly 1'b0;//clearing for 1shot 
            end                  
            else
            begin
                if (state_prv==ST_ISLND_BESS_CHK)
                    bess_gfmexit_crlgc <= #`adly 1'b1; //exit grid forming upon breaker failure 
                else if (state_prv==ST_ISLND_GENSET_CHK)
                    gen_gfmcexit_crlgc <= #`adly 1'b1;
                state_island        <= #`adly ST_ISLND_IDLE;
            end 
        end         
        ST_ISLND_BESS:
        begin     
            gen_gfmshut             <= #`adly 1'b0; //for 1shot command

            if(usr_shutdown_1shot)
            begin
                bess_gfmexit_crlgc       <= #`adly 1'b1; //exit grid forming command
                pvbess_pid_rst           <= #`adly 1'b0;
                state_island             <= #`adly ST_ISLND_IDLE;
            end  
            else if (grid_hlthy && (auto_resync ||  usr_grid_resync1shot || usr_poibrkcl_cmd1shot))
            begin
                if (usr_cltrns_resync)  //seamless resync
                begin
                    bess_islandmodevolt_w_crlgc            <= #`adly meter_poi_vab_crlgc[15:0]; 
                    bess_islandmodefrq_w_crlgc             <= #`adly meter_poi_freq_crlgc[15:0] - GRDSYNC_FRQSLP; //introducing a slip of 0.02Hz (20mHz)
                    bess_islandmodevoltvld_w_crlgc         <= #`adly 1'b1;
                    bess_islandmodefrqvld_w_crlgc          <= #`adly 1'b1;
                    sec_cnt_initval                        <= #`adly sec_cntr;
                    state_island                           <= #`adly ST_ISLND_BESS_RESYNC;
                end
                else    //non-seamless resync
                begin
                    bess_gfmexit_crlgc       <= #`adly 1'b1;
                    pvbess_pid_rst           <= #`adly 1'b0;
                    sec_cnt_initval          <= #`adly sec_cntr;
                    state_island             <= #`adly ST_ISLND_BESS_OPTRNSRESYNC;
                end
            end
            else if ((bess_wh_r_crlgc < usr_bessislndext_minwh) || usr_bess2gen_trnsf1shot || ~usr_bess_en)
            begin
                if (gen_islnd_rdy && ~gen_gfm_fail) 
                begin
                    gen_gfmcmd         <= #`adly 1'b1;
                    pvgen_pisl_trns_vld      <= #`adly 1'b1;
                    pvgen_pisl_trns          <= #`adly 32'd0;//Note 10  
                    sec_cnt_initval          <= #`adly sec_cntr;
                    state_island             <= #`adly ST_ISLND_GENSET_CHK2;
                end
                else
                begin
                    bess_gfmexit_crlgc         <= #`adly 1'b1;
                    pvbess_pid_rst             <= #`adly 1'b0;
                    state_island               <= #`adly ST_ISLND_IDLE;
                end
            end
            else
            begin
                state_island          <= #`adly ST_ISLND_BESS;
            end

        end
        ST_ISLND_BESS_RESYNC:
        begin
            if( (bess_islandmodevolt_r_crlgc==bess_islandmodevolt_w_crlgc) && (bess_islandmodefrq_r_crlgc==bess_islandmodefrq_w_crlgc) )
            begin
                rly_poibrkcl_crlgc          <= #`adly 1'b1;
                rly_brkclvld_w_crlgc        <= #`adly 1'b1;
                sec_cnt_initval             <= #`adly sec_cntr;
                state_island                <= #`adly ST_ISLND_BESS_CLTRNSRESYNC;
            end 
            else if (sec_cntr != (sec_cnt_initval+REFVF_STAT_TIME))
            begin 
                state_island            <= #`adly ST_ISLND_BESS_RESYNC;
            end                  
            else
            begin
                bess_gfmexit_crlgc         <= #`adly 1'b1;
                pvbess_pid_rst             <= #`adly 1'b0;
                sec_cnt_initval            <= #`adly sec_cntr;
                state_island               <= #`adly ST_ISLND_BESS_OPTRNSRESYNC;
            end             
        end
        ST_ISLND_BESS_OPTRNSRESYNC:
        begin
            bess_gfmexit_crlgc             <= #`adly 1'b0;
            if (~bess_gfm_stat_crlgc) //confirmation that bess has exited gfm
            begin
                rly_poibrkcl_crlgc          <= #`adly 1'b1;
                rly_brkclvld_w_crlgc        <= #`adly 1'b1;
                state_island                <= #`adly ST_ISLND_IDLE;
            end
            else if (sec_cntr != (sec_cnt_initval+GFM_STAT_TIME))
            begin 
                state_island            <= #`adly ST_ISLND_BESS_OPTRNSRESYNC;
            end 
            else
            begin
                state_island            <= #`adly ST_ISLND_IDLE; //go back to to idle without closing the POI breaker if gfm exit status was not received 
            end             
        end
        ST_ISLND_BESS_CLTRNSRESYNC:
        begin
            
            if (poi_cb_cl_crlgc)
            begin
                bess_gfmexit_crlgc          <= #`adly 1'b1;         //exiting gfm after receiving poi breaker close status (seamless resync)
                pvbess_pid_rst              <= #`adly 1'b0;
                state_island                <= #`adly ST_ISLND_IDLE;
                rly_poibrkcl_crlgc          <= #`adly 1'b0;// clear close cmd
                rly_brkclvld_w_crlgc        <= #`adly 1'b1;//clearing close command after receiving close status
            end     
            else if (sec_cntr != (sec_cnt_initval+BRKCL_STAT_TIME))
            begin 
                state_island                <= #`adly ST_ISLND_BESS_CLTRNSRESYNC;
                rly_poibrkcl_crlgc          <= #`adly 1'b0;// 
                rly_brkclvld_w_crlgc        <= #`adly 1'b0;//clearing for 1shot
            end 
            else
            begin
                bess_gfmexit_crlgc     <= #`adly 1'b1;         //exiting gfm even if breaker close status is not received after timer expiry 
                pvbess_pid_rst         <= #`adly 1'b0;
                state_island           <= #`adly ST_ISLND_IDLE;
            end             
        end
        ST_ISLND_GENSET_CHK2:
        begin
            gen_gfmcmd         <= #`adly 1'b0; //for 1shot command    
            pvgen_pisl_trns_vld          <= #`adly 1'b0;
            if(gen_gfm_stat_crlgc && (meter_pv_3p_crlgc==32'd0))
            begin
                bess_gfmexit_crlgc   <= #`adly 1'b1; 
                pvbess_pid_rst       <= #`adly 1'b0;  
                pvgen_pid_rst        <= #`adly 1'b1; 
                state_island          <= #`adly ST_ISLND_GENSET;
            end    
            else if (sec_cntr != (sec_cnt_initval+MISC_STAT_TIME))
            begin
                state_island          <= #`adly ST_ISLND_GENSET_CHK2; //wait for GFM status
            end    
            else
            begin 
                gen_gfm_fail       <= #`adly 1'b1;  
                state_island          <= #`adly ST_ISLND_BESS;
            end  
        end 
        ST_ISLND_GENSET:
        begin     
            bess_gfmexit_crlgc             <= #`adly 1'b0; //for 1shot command
            if(usr_shutdown_1shot)
            begin
                gen_gfmcexit_crlgc          <= #`adly 1'b1; //exit grid forming command
                pvgen_pid_rst               <= #`adly 1'b0; 
                state_island                <= #`adly ST_ISLND_IDLE;
            end  
            else if (grid_hlthy && (auto_resync ||  usr_grid_resync1shot || usr_poibrkcl_cmd1shot))
            //here you can also include code to do a seamless resync by first transfering gfm to bess and then resync which will be same as usr_gen2bess_trnsf1shot
            //below. Also see Note 11
            begin
                gen_gfmcexit_crlgc          <= #`adly 1'b1;
                pvgen_pid_rst               <= #`adly 1'b0; 
                sec_cnt_initval             <= #`adly sec_cntr;
                state_island                <= #`adly ST_ISLND_GENSET_OPTRNSRESYNC;
            end
            else if (usr_gen2bess_trnsf1shot || ~usr_gen_en)
            begin
                if (bess_islnd_rdy && ~bess_gfm_fail) 
                begin
                    bess_gfmcmd_crlgc           <= #`adly 1'b1;
                    sec_cnt_initval             <= #`adly sec_cntr;
                    state_island                <= #`adly ST_ISLND_BESS_CHK2;
                end
                else if (~usr_gen_en)
                begin
                    gen_gfmcexit_crlgc          <= #`adly 1'b1;
                    pvgen_pid_rst               <= #`adly 1'b0; 
                    state_island                <= #`adly ST_ISLND_IDLE;
                end
            end
            else
            begin
                state_island          <= #`adly ST_ISLND_GENSET;
            end
        end   
        ST_ISLND_GENSET_OPTRNSRESYNC:
        begin
            gen_gfmshut             <= #`adly 1'b0;
            if (~gen_gfm_stat_crlgc) //confirmation that genset has exited gfm
            begin
                rly_poibrkcl_crlgc          <= #`adly 1'b1;
                rly_brkclvld_w_crlgc        <= #`adly 1'b1;
                state_island                <= #`adly ST_ISLND_IDLE;
            end
            else if (sec_cntr != (sec_cnt_initval+GFM_STAT_TIME))
            begin 
                state_island            <= #`adly ST_ISLND_GENSET_OPTRNSRESYNC;
            end 
            else
            begin
                state_island            <= #`adly ST_ISLND_IDLE; //go back to to idle without closing the POI breaker if gfm exit status was not received 
            end             
        end
        ST_ISLND_BESS_CHK2:
        begin
            bess_gfmcmd_crlgc   <= #`adly 1'b0; //for 1shot command    
            if(bess_gfm_stat_crlgc)
            begin
                gen_gfmshut   <= #`adly 1'b1; 
                pvgen_pid_rst           <= #`adly 1'b0;
                pvbess_pid_rst           <= #`adly 1'b1;
                state_island            <= #`adly ST_ISLND_BESS;
            end    
            else if (sec_cntr != (sec_cnt_initval+GFM_STAT_TIME))
            begin
                state_island          <= #`adly ST_ISLND_BESS_CHK2; //wait for GFM status
            end    
            else
            begin 
                bess_gfm_fail         <= #`adly 1'b1;  
                state_island          <= #`adly ST_ISLND_GENSET;
            end  
        end            
        endcase
    end
end

//Grid Healthy Signal
always @ (posedge clkin, negedge arst_n)
begin
    if (~arst_n)
    begin
        grid_hlthy                  <= #`adly 1'b0;
        trig_cnt_ghlthy             <= #`adly 1'b0;
    end
    else if ( (meter_poi_vab_crlgc<usr_grdhlthy_vmin) || (meter_poi_vab_crlgc>usr_grdhlthy_vmax) || (meter_poi_freq_crlgc<usr_grdhlthy_fmin) || 
              (meter_poi_freq_crlgc>usr_grdhlthy_fmax) )
    begin
        grid_hlthy                  <= #`adly 1'b0;
        trig_cnt_ghlthy             <= #`adly 1'b0;
    end
    else if ( sec_cntr_ghlthy > usr_grdhlthy_dur)
    begin
        grid_hlthy                  <= #`adly 1'b1;
        trig_cnt_ghlthy             <= #`adly 1'b0;
    end
    else
    begin
        grid_hlthy                  <= #`adly grid_hlthy;
        trig_cnt_ghlthy             <= #`adly 1'b1;
    end
end


//Grid Healthy Second Counter 
always @ (posedge clkin, negedge arst_n)
begin
    if (~arst_n)
    begin
        sec_cntr_ghlthy                 <= #`adly 8'd0;
        accum                           <= #`adly 27'd0;
    end   
    else if (~trig_cnt_ghlthy)
    begin
        sec_cntr_ghlthy                 <= #`adly 8'd0;
        accum                           <= #`adly 27'd0;
    end
    else 
    begin
        accum                           <= #`adly  (pps ? 27'd0 : accum) + 27'd1; //reset clock cycle counter every second
        sec_cntr_ghlthy                 <= #`adly  sec_cntr_ghlthy + (pps ? 8'd1 : 8'd0);//increment seconds count every second  
    end  
end 
///////////////////////////////////////
// Multiplexed PID (BESS or GENSET depending upon GFM Asset)
always @(posedge clkin or negedge arst_n) begin
    if (~arst_n)
    begin
        pvisl_pid_rst       <= #`adly 1'b0;
        pvisl_pid_en        <= #`adly 1'b0;
    end
    else if (pvbess_pid_rst)
    begin
        pvisl_pid_rst           <= #`adly pvbess_pid_rst;
        pvisl_pid_en            <= #`adly pvbess_pid_en;
        pvisl_pid_ki            <= #`adly usr_pvbess_ki;
        pvisl_pid_ul            <= #`adly 32'd0;
        pvisl_pid_ll            <= #`adly usr_pvbessmax_fxp;
        pvisl_piderr_ul         <= #`adly usr_pvbessmaxerr_fxp;
        pvisl_piderr_ll         <= #`adly usr_pvbessmax_fxp;    
        pvisl_pid_ref           <= #`adly bess_chrg_lmtfxp;
        pvisl_pid_fbk           <= #`adly meter_bess3p_pvbess_fxp;
    end
    else
    begin
        pvisl_pid_rst           <= #`adly pvgen_pid_rst;
        pvisl_pid_en            <= #`adly pvgen_pid_en;
        pvisl_pid_ki            <= #`adly usr_pv_ki_reg;
        pvisl_pid_ul            <= #`adly usr_pvmax_fxp;
        pvisl_pid_ll            <= #`adly 32'd0;
        pvisl_piderr_ul         <= #`adly usr_pvmax_fxp;
        pvisl_piderr_ll         <= #`adly 32'd0;    
        pvisl_pid_ref           <= #`adly usr_gen_baseld;
        pvisl_pid_fbk           <= #`adly meter_gen3p_crlgc_fxp;
    end   

end

    PID_Fxd7bFr PID_instPV_ISL (
        .ap_start   (pvisl_pid_en),                  
        .ap_done    (pvisl_ap_done),
        .ap_idle    (),
        .ap_ready   (pvisl_ap_ready),
        .ap_clk     (clkin),
        .ap_rst     (~pvisl_pid_rst),
        .ap_ce      (1'b1),
        .InitN      (pvisl_pid_rst),
        .coeff_0_V  (pvisl_pid_ki),             //Ki
        .coeff_1_V  (usr_pv_kd),                //Kd
        .coeff_2_V  (32'd0),                    //Constant (initial value)
        .coeff_3_V  (usr_pv_kp),                //Kp
        .coeff_4_V  (pvisl_pid_ul),                    //max limit for output
        .coeff_5_V  (pvisl_pid_ll),        //min limit for output (pv rating)
        .coeff_6_V  (pvisl_piderr_ul),     //max limit for error and integrator
        .coeff_7_V  (pvisl_piderr_ll),        //min limit for error and integrator
        .din_0_V    (pvisl_pid_ref),         //reference  
        .din_1_V    (pvisl_pid_fbk),  //feedback
        .dout_0_V   (pvisl_pid_output),         //control signal output
        .dout_1_V   (pvisl_dout_1_V)                          //error signal output 

    ); 


always @(posedge clkin or negedge arst_n) begin
    if (~arst_n)
    begin
        dout_0_PVbesserr     <= #`adly 32'sd0;
        pvbess_ap_done       <= #`adly 1'b0;
        pvbess_ap_ready      <= #`adly 1'b0;
        dout_0_PVgenerr      <= #`adly 32'sd0;
        pvgen_ap_done        <= #`adly 1'b0;
        pvgen_ap_ready       <= #`adly 1'b0;
    end
    else if (pvbess_pid_rst)
    begin
        dout_0_PVbesserr     <= #`adly pvisl_pid_output;
        pvbess_ap_done       <= #`adly pvisl_ap_done;
        pvbess_ap_ready      <= #`adly pvisl_ap_ready;
        //dout_0_PVgenerr      <= #`adly 32'sd0; //dont care
        pvgen_ap_done        <= #`adly 1'b0;
        pvgen_ap_ready       <= #`adly 1'b0;
    end  
    else if (pvgen_pid_rst)
    begin
       // dout_0_PVbesserr     <= #`adly 32'sd0; //dont care
        pvbess_ap_done       <= #`adly 1'b0;
        pvbess_ap_ready      <= #`adly 1'b0;
        dout_0_PVgenerr      <= #`adly pvisl_pid_output;
        pvgen_ap_done        <= #`adly pvisl_ap_done;
        pvgen_ap_ready       <= #`adly pvisl_ap_ready;
    end       
    else
    begin
        pvbess_ap_done       <= #`adly 1'b0;
        pvbess_ap_ready      <= #`adly 1'b0;
        pvgen_ap_done        <= #`adly 1'b0;
        pvgen_ap_ready       <= #`adly 1'b0;
    end    
end

//////////////////////PID PV BESS//////////////////////
//Changing to -ve value for PID
always @(posedge clkin or negedge arst_n) begin
    if (~arst_n)
        usr_pvbessmax <= #`adly 32'sd0;
    else 
        usr_pvbessmax <= #`adly (~usr_pv_max) + 32'sd1;
end

//BESS Charge Limit
always @(posedge clkin or negedge arst_n) begin
    if (~arst_n)
        bess_chrg_lmt <= #`adly 32'd0;
    else if (bess_wh_r_crlgc >= usr_bessislnd_maxwh_ul) 
        bess_chrg_lmt <= #`adly 32'd0;
    else if (bess_wh_r_crlgc < usr_bessislnd_maxwh_ll)
        bess_chrg_lmt <= #`adly bess_maxchgpwr_r_crlgc;
end

//Flipping sign (battery charging needs to be +ve value going into the PID)  
always @(posedge clkin or negedge arst_n) begin
    if (~arst_n)
        meter_bess3p_pvbess <= #`adly 32'sd0;
    else 
        meter_bess3p_pvbess <= #`adly (~meter_bess_3p_crlgc) + 32'sd1;//meter_poi_3p * (-32'sd1);
end

always @(posedge clkin or negedge arst_n) begin
    if (~arst_n)
    begin
        usr_pvbess_ki       <= #`adly 32'sd0;
        usr_pvbess_ki_init  <= #`adly 1'b0;
    end
    else if (~usr_pvbess_ki_init)
    begin
        usr_pvbess_ki <= #`adly usr_pv_ki;
        usr_pvbess_ki_init  <= #`adly 1'b1;
    end    
    else if (pvbess_ap_done)
        usr_pvbess_ki <= #`adly ((dout_0_PVbesserr==32'd0) || (dout_0_PVbesserr==usr_pvbessmax_fxp)) ? 32'sd0 : usr_pv_ki; //disabling Integral whenn output saturates (an alternative way to implement anti-windup)
end



always @ (posedge clkin or negedge arst_n)
begin
    if (~arst_n)
        pvbess_pid_en   <= #`adly 1'b0;
    else if (pvbess_ap_ready || ~usr_pv_en || ~pvbess_pid_rst)
        pvbess_pid_en   <= #`adly 1'b0;    
    else if (meter_bess_rdatavldcrlgc_reg)
        pvbess_pid_en   <= #`adly meter_bess_rdatavldcrlgc_reg;   
end

always @ (posedge clkin or negedge arst_n)
begin
    if (~arst_n)
        meter_bess_rdatavldcrlgc_reg   <= #`adly 1'b0;
    else
        meter_bess_rdatavldcrlgc_reg   <= #`adly meter_bess_rdatavld_crlgc;
end

    // PID_Fxd7bFr PID_instPV_BESSGFM ( 
    //     .ap_start   (pvbess_pid_en),                  
    //     .ap_done    (pvbess_ap_done),
    //     .ap_idle    (),
    //     .ap_ready   (pvbess_ap_ready),
    //     .ap_clk     (clkin),
    //     .ap_rst     (~pvbess_pid_rst),
    //     .ap_ce      (1'b1),
    //     .InitN      (pvbess_pid_rst),
    //     .coeff_0_V  (usr_pvbess_ki),            //Ki
    //     .coeff_1_V  (usr_pv_kd),                //Kd
    //     .coeff_2_V  (32'd0),                    //Constant (initial value)
    //     .coeff_3_V  (usr_pv_kp),                //Kp
    //     .coeff_4_V  (32'd0),                    //max limit for output
    //     .coeff_5_V  (usr_pvbessmax_fxp),        //min limit for output (pv rating)
    //     .coeff_6_V  (usr_pvbessmaxerr_fxp),     //max limit for error and integrator
    //     .coeff_7_V  (usr_pvbessmax_fxp),        //min limit for error and integrator
    //     .din_0_V    (bess_chrg_lmtfxp),         //reference  
    //     .din_1_V    (meter_bess3p_pvbess_fxp),  //feedback
    //     .dout_0_V   (dout_0_PVbesserr),         //control signal output
    //     .dout_1_V   ()                          //error signal output 

    // ); 

//- Truncating decimal part (accuracy loss is neglibigble since command is in Watts (not kw))
//- Changing from fixed point represenation back to normal integer represenation (for CPU)
assign dout_0_PVbesserr_tmp[24:0] = dout_0_PVbesserr[31:7]; 
genvar j;
generate
    for (j = 25; j < 32; j = j + 1) begin: genj
        assign dout_0_PVbesserr_tmp[j] = dout_0_PVbesserr[31]; //padding remaining bits with sign bit
    end
endgenerate 


//changing to 2's complement representation where required (if decimal part is non-zero and interger part is -ve, integer part from PID is in 1's complement)
always @(posedge clkin or negedge arst_n) begin
    if (~arst_n)
        pvbess_p_werr <= #`adly 32'sd0;
    else if ((dout_0_PVbesserr[6:0]!=7'sd0) && (dout_0_PVbesserr[31]==1'sb1))
        pvbess_p_werr <= #`adly dout_0_PVbesserr_tmp + 32'sd1;  //adding to convert to 2's complement representation 
    else
        pvbess_p_werr <= #`adly dout_0_PVbesserr_tmp;
end

//Regulating PV setpoint to keep bess charge below max threshold
always @(posedge clkin or negedge arst_n) begin
    if (~arst_n)
        pvbess_pisl <= #`adly 32'sd0;
    else
        pvbess_pisl <= #`adly usr_pv_max + pvbess_p_werr; //note that pvbess_p_werr will either be zero or -ve, never +ve non-zero
end

always @(posedge clkin or negedge arst_n) begin
    if (~arst_n)
        pvbess_ap_done_reg <= #`adly 1'b0;
    else
        pvbess_ap_done_reg <= #`adly pvbess_ap_done; 
end

always @(posedge clkin or negedge arst_n) begin
    if (~arst_n)
        pvbess_p_w_prv <= #`adly 32'sd0;
    else if(pvbess_pisl_vld)
        pvbess_p_w_prv <= #`adly pvbess_pisl;
    else
        pvbess_p_w_prv <= #`adly pvbess_p_w_prv;
end

always @(posedge clkin or negedge arst_n) begin
    if (~arst_n)
    begin
        pvbessisl_dout_1_V      <= #`adly 32'sd0;
        pvbessisl_dout_1_V_reg  <= #`adly 32'sd0;
    end
    else
    begin
        pvbessisl_dout_1_V      <= #`adly pvisl_dout_1_V;
        pvbessisl_dout_1_V_reg  <= #`adly pvbessisl_dout_1_V;
    end 
end

//used to send initial setpoint to PV
always @(posedge clkin or negedge arst_n) begin
    if (~arst_n)
        pvbess_p_trg <= #`adly 1'b0;
    else if(pvbess_ap_done_reg)
        pvbess_p_trg <= #`adly 1'b1;
    else
        pvbess_p_trg <= #`adly pvbess_p_trg;
end

always @(posedge clkin or negedge arst_n) begin
    if (~arst_n)
        pvbess_pisl_vld <= #`adly 1'b0;
    else
        pvbess_pisl_vld <= #`adly ((pvbessisl_dout_1_V_reg<32'sd0) || ((pvbessisl_dout_1_V_reg>32'sd0)&&((usr_pv_max+pvbess_p_werr)!=pvbess_p_w_prv)) || (~pvbess_p_trg)) & pvbess_ap_done_reg;
end

////////////////////// PV GEN PID///////////////////////////////////
always @(posedge clkin or negedge arst_n) begin
    if (~arst_n)
    begin
        usr_pv_ki_reg       <= #`adly 32'sd0;
        usr_pv_ki_reg_init  <= #`adly 1'b0;
    end
    else if (~usr_pv_ki_reg_init)
    begin
        usr_pv_ki_reg <= #`adly usr_pv_ki;
        usr_pv_ki_reg_init  <= #`adly 1'b1;
    end    
    else if (pvgen_ap_done)
        usr_pv_ki_reg <= #`adly ((dout_0_PVgenerr==32'd0) || (dout_0_PVgenerr==usr_pvmax_fxp)) ? 32'sd0 : usr_pv_ki; //disabling Integral whenn output saturates (an alternative way to implement anti-windup)
end

always @ (posedge clkin or negedge arst_n)
begin
    if (~arst_n)
        pvgen_pid_en   <= #`adly 1'b0;
    else if (pvgen_ap_ready || ~usr_pv_en || ~pvgen_pid_rst)
        pvgen_pid_en   <= #`adly 1'b0;    
    else if (meter_gen_rdatavld_crlgc)
        pvgen_pid_en   <= #`adly meter_gen_rdatavld_crlgc;   
end

// PID_Fxd7bFr PID_instPV_GENSETGFM ( 
// .ap_start   (pvgen_pid_en),                         
// .ap_done    (pvgen_ap_done),
// .ap_idle    (),
// .ap_ready   (pvgen_ap_ready),
// .ap_clk     (clkin),
// .ap_rst     (~pvgen_pid_rst),
// .ap_ce      (1'b1),
// .InitN      (pvgen_pid_rst),
// .coeff_0_V  (usr_pv_ki_reg),            //Ki
// .coeff_1_V  (usr_pv_kd),                //Kd
// .coeff_2_V  (32'd0),                    //Constant (initial value)
// .coeff_3_V  (usr_pv_kp),                //Kp
// .coeff_4_V  (usr_pvmax_fxp),            //max limit for output
// .coeff_5_V  (32'd0),                    //min limit for output (pv rating)////////?????????????? error limit shouldnt be zero FIXX ITTTT LIKE OTHERS????????????????
// .coeff_6_V  (usr_pvmax_fxp),            //max limit for error and integrator
// .coeff_7_V  (32'd0),                    //min limit for error and integrator
// .din_0_V    (usr_gen_baseld),           //reference  
// .din_1_V    (meter_gen3p_crlgc_fxp),    //feedback
// .dout_0_V   (dout_0_PVgenerr),          //control signal output
// .dout_1_V   ()                          //error signal output 
// ); 


//- Truncating decimal part (accuracy loss is neglibigble since command is in Watts (not kw))
//- Changing from fixed point represenation back to normal integer represenation (for CPU)
assign pvgen_p_werr[24:0] = dout_0_PVgenerr[31:7]; 
genvar k;
generate
    for (k = 25; k < 32; k = k + 1) begin: genk
        assign pvgen_p_werr[k] = dout_0_PVgenerr[31]; //padding remaining bits with sign bit
    end
endgenerate 

//Regulating PV setpoint to keep required minimum load on genset
always @(posedge clkin or negedge arst_n) begin
    if (~arst_n)
        pvgen_pisl_pid <= #`adly 32'sd0;
    else
        pvgen_pisl_pid <= #`adly usr_pv_max - pvgen_p_werr; //note that pvgen_p_werr will either be zero or +ve, never -ve non-zero. Also error is capped to a max of usr_pv_max
                                                            //so the pvgen_pisl_pid will never be -ve
end

always @(posedge clkin or negedge arst_n) begin
    if (~arst_n)
        pvgen_p_w_prv <= #`adly 32'sd0;
    else if(pvgen_pisl_pid_vld)
        pvgen_p_w_prv <= #`adly pvgen_pisl_pid;
    else
        pvgen_p_w_prv <= #`adly pvgen_p_w_prv;
end

always @(posedge clkin or negedge arst_n) begin
    if (~arst_n)
        pvgenisl_dout_1_V      <= #`adly 32'sd0;
    else
        pvgenisl_dout_1_V      <= #`adly pvisl_dout_1_V;
end

//used to send initial setpoint to PV 
always @(posedge clkin or negedge arst_n) begin
    if (~arst_n)
        pvgen_p_trg <= #`adly 1'b0;
    else if(pvgen_ap_done)
        pvgen_p_trg <= #`adly 1'b1;
    else
        pvgen_p_trg <= #`adly pvgen_p_trg;
end

always @(posedge clkin or negedge arst_n) begin
    if (~arst_n)
        pvgen_pisl_pid_vld <= #`adly 1'b0;
    else
        pvgen_pisl_pid_vld <= #`adly ((pvgenisl_dout_1_V>32'sd0) || ((pvgenisl_dout_1_V<32'sd0)&&((usr_pv_max - pvgen_p_werr)!=pvgen_p_w_prv)) || (~pvgen_p_trg)) & pvgen_ap_done; 
end

always @(posedge clkin or negedge arst_n) begin
    if (~arst_n)
    begin
        pvgen_pisl_vld  <= #`adly 1'b0;
        pvgen_pisl      <= #`adly 32'sd0;
    end
    else if (~pvgen_pid_rst)
    begin
        pvgen_pisl_vld  <= #`adly pvgen_pisl_trns_vld;
        pvgen_pisl      <= #`adly pvgen_pisl_trns;
    end
    else 
    begin
        pvgen_pisl_vld  <= #`adly pvgen_pisl_pid_vld;
        pvgen_pisl      <= #`adly pvgen_pisl_pid;
    end

end

//PV Command Output
always @(posedge clkin or negedge arst_n) begin
    if (~arst_n)
    begin
        pv_pisl_vld  <= #`adly 1'b0;
        pv_p_isl      <= #`adly 32'sd0;
    end
    else if (pvbess_pisl_vld)
    begin
        pv_pisl_vld  <= #`adly pvbess_pisl_vld;
        pv_p_isl      <= #`adly pvbess_pisl;
    end
    else if (pvgen_pisl_vld)
    begin
        pv_pisl_vld  <= #`adly pvgen_pisl_vld;
        pv_p_isl      <= #`adly pvgen_pisl;
    end
    else
    begin
        pv_pisl_vld  <= #`adly 1'b0;
    end    

end

endmodule
 