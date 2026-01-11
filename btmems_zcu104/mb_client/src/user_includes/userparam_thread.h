//Code for passing user parameters to PL. User parameters are read from a file which is updated by another program
//Make sure usr_param.txt file is present in the folder path as defined below

//Note 1: This is to enable peak shaving for optimization mode (control mode=3) as well to avoid importing power from utility > XF rating
//of 300KVA (the import limit should be set to 300000 or slightly less like 295000 on the webpage for optimization mode). This
//is needed as the dispatch optimz algorithm can ask battery to discharge at full power which when combined with no/low solar and high
//SR load can cause import to exceed XF rating (ive also added this as XF rating constraint in optimization to reduce/completely mitigate
//the occurence of this situation).
//Also instead of overriding control mode value here, a better way to handle this is to enable peak shaving in FPGA for control mode value of
//both 1 and 3 [This part is already in FPGA as default mode is peak shaving, so if user mode is not 2 or 1, it defaults to PkShv]

#define USRPARAM_FPATH "/usr/usr_param.txt" //file path from the root where user parameter file is residing

void* usrparam_thread (void* args)

/*This is the sample program to notify us for the file creation and file deletion takes place in “/tmp” directory*/


#define EVENT_SIZE  ( sizeof (struct inotify_event) )
#define EVENT_BUF_LEN     (  10/*1024*/ *  ( EVENT_SIZE + 16 ) ) //making buf len equal to just one event (had to * by 10, otherwise only up to par9 were being read)

{
  int post_length;
  int fd;
  int wd;
  char post_buffer[EVENT_BUF_LEN];
  char file_path[30] = USRPARAM_FPATH;
  FILE *file_hndl;

  float usr_bess_kp;
  float usr_bess_ki;
  float usr_bess_kd;
  float usr_bess_en;
  float usr_besschrg_lmt;
  float usr_bessdsch_lmt;
  float usr_bess_kwh_soc100;
  float usr_bess_maxsoc;
  float usr_bess_minsoc;
  float usr_maxld_islnd;			//maximum load expected in island
  float usr_bess2gfmtrnsf_mrgn;		//margin to transfer from bess to other GFM resource while islanded (in % of SoC) - higher level user access to configure (i.e. a normal user shouldnt be able to program this without a pswd or something in HMI)
  float usr_bessislnd_mindur;		//Min duration in island with BESS (in minutes)	- higher level user access to configure
  float usr_bess2gfmtrnsf_mrgn_wh;
  float usr_bessislnd_mindur_wh;

  float usr_pv_kp;
  float usr_pv_ki;
  float usr_pv_kd;
  float usr_pv_en;
  float usr_pv_max;

  float usr_imp_lmt;
  float usr_exp_lmt;
  float usr_exp_prio;
  float usr_bessgfm_prio;
  float usr_gensetgfm_prio;

  float usr_bessislnd_maxwh_ul;
  float usr_bessislnd_maxwh_ll;
  float usr_gen_baseld;
  float usr_grdhlthy_dur;
  float usr_grdhlthy_vmin;
  float usr_grdhlthy_vmax;
  float usr_grdhlthy_fmin;
  float usr_grdhlthy_fmax;

  float usr_net_load;


  float usr_bess_kp_plmul128;
  float usr_bess_ki_plmul128;
  float usr_bess_kd_plmul128;
  float usr_pv_kp_plmul128;
  float usr_pv_ki_plmul128;
  float usr_pv_kd_plmul128;

  float	usr_genset_en;

  float usr_autoislnd_en;
  float usr_auto_resync;
  float usr_cltrns_resync;
  float usr_islnd_cmd;
  float usr_grid_resync;
  float usr_bess2gen_trnsf;
  float usr_gen2bess_trnsf;
  float usr_poibrkcl_cmd;
  float usr_poibrkop_cmd;
  float usr_shut_down;

  float usr_ctrl_mode_flt;


  unsigned int  usr_imp_lmt_pl;
  unsigned int  usr_exp_lmt_pl;
  unsigned int  usr_besschrg_lmt_pl;
  unsigned int  usr_bessdsch_lmt_pl;
  unsigned int  usr_bess_kp_pltmp;
  unsigned int  usr_bess_kp_pl;
  unsigned int  usr_bess_ki_pltmp;
  unsigned int  usr_bess_ki_pl;
  unsigned int  usr_bess_kd_pltmp;
  unsigned int  usr_bess_kd_pl;
  unsigned int  usr_pv_kp_pltmp;
  unsigned int  usr_pv_kp_pl;
  unsigned int  usr_pv_ki_pltmp;
  unsigned int  usr_pv_ki_pl;
  unsigned int  usr_pv_kd_pltmp;
  unsigned int  usr_pv_kd_pl;
  unsigned int  usr_bessislnd_maxwh_ul_pl;
  unsigned int  usr_bessislnd_maxwh_ll_pl;
  unsigned int  usr_gen_baseld_pl;
  unsigned int  usr_grdhlthy_dur_pl;
  unsigned int  usr_grdhlthy_vmin_scld;
  unsigned int  usr_grdhlthy_vmax_scld;
  unsigned int  usr_grdhlthy_fmin_scld;
  unsigned int  usr_grdhlthy_fmax_scld;

  int			usr_net_load_pl; //this needs to be signed to accept -ve values
  unsigned int	usr_ctrl_mode_tmp;
  unsigned int usr_bessgfm_prio_tmp;
  unsigned int usr_gensetgfm_prio_tmp;

  //unsigned int  usr_bess_wh_soc100_pl; //this is declared with global variables
  unsigned int  usr_bess_maxsoc_pl;
  unsigned int  usr_bess_minsoc_pl;
  unsigned int  usr_bess_wh_minsoc_pl;
  unsigned int 	usr_bess2gfmtrnsf_mrgn_whpl;
  unsigned int 	usr_bessislnd_mindur_whpl;
  unsigned int 	usr_maxld_islnd_pl;

  unsigned int  usr_pv_max_pl;
  unsigned int  usr_exp_priotmp;
  unsigned int  usr_bess_entmp;
  unsigned int  usr_pv_entmp;
  unsigned int	usr_genset_entmp;

  unsigned int usr_autoislnd_entmp;
  unsigned int usr_auto_resynctmp;
  unsigned int usr_cltrns_resynctmp;
  unsigned int usr_islnd_cmdtmp;
  unsigned int usr_grid_resynctmp;
  unsigned int usr_bess2gen_trnsftmp;
  unsigned int usr_gen2bess_trnsftmp;
  unsigned int usr_poibrkcl_cmdtmp;
  unsigned int usr_poibrkop_cmdtmp;
  unsigned int usr_shut_downtmp;

  unsigned int  usr_cmd_pl = 0;

  //Declaring EMIO for PL_PS direct GPIO signal
  system("echo 418 > /sys/class/gpio/export"); //For user parameter data PS to PL indication into BRAM
  system("echo out > /sys/class/gpio/gpio418/direction");//setting direction to output
  system("echo 0 > /sys/class/gpio/gpio418/value");//init to zero


  /*creating the INOTIFY instance*/
  fd = inotify_init();
  if ( fd < 0 )
    perror( "inotify_init" );

  //adding watch on file
  wd = inotify_add_watch( fd, USRPARAM_FPATH, IN_MODIFY ); //notification to be provided whenever file is modified
  if (wd < 0)
	  perror ("inotify_add_watch");

usr_param_loop:

  /*read to determine the event change happens on “/tmp” directory. Actually this read blocks until the change event occurs*/
  post_length = read( fd, post_buffer, EVENT_BUF_LEN ); //read will block until atleast one event happens. Note that I have used buffer len equal to just one event. If there are more than one unread event present when CPU loops back to this line, the buffer will overflow and read() will report EINVAL error. Thats ok as I just need an indication that file has been modified. I am not using any info from event structure (code commented out below). However, if this EINVAL gives problems during testing, just increase buffer length (enable 1024 in the define above or instead, first try a lower value, say 10)

//  /*checking for error*/
//  if ( post_length == EINVAL ) {
//    perror( "read" );
//  } //in older kernel (2.6.21 or before), read would report zero on buffer overflow or any other error. In later kernel versions, it reports EINVAL
//
//  /*actually read return the list of change events happens. Here, read the change event one by one and process it accordingly.*/
//  while ( i < post_length ) {     struct inotify_event *event = ( struct inotify_event * ) &post_buffer[ i ];     if ( event->len ) {
//      if ( event->mask & IN_CREATE ) {
//        if ( event->mask & IN_ISDIR ) {
//          printf( "New directory %s created.\n", event->name );
//        }
//        else {
//          printf( "New file %s created.\n", event->name );
//        }
//      }
//      else if ( event->mask & IN_DELETE ) {
//        if ( event->mask & IN_ISDIR ) {
//          printf( "Directory %s deleted.\n", event->name );
//        }
//        else {
//          printf( "File %s deleted.\n", event->name );
//        }
//      }
//    }
//    i += EVENT_SIZE + event->len;
//  }
//  /*removing the “/tmp” directory from the watch list.*/
//   inotify_rm_watch( fd, wd );
//
//  /*closing the INOTIFY instance*/
//   close( fd );


// **********************************Reading User Parameters*********************************************
//Note that only kp/ki/kd need to be float. All other user inputs must be integer. However, they are all declared as float here incase user
//enter them as decimal number by mistake on webpage. Once values are read from post data, they are truncated back to integer as you can see
//below before passing to PL.
//Also this fscanf approach will cause problem if user leaves any field empty. Additionally, some browsers may not send back post data in exactly
//the format I expect here. For this reason, replace this code using github cgic library function which handles all kinds of cases and browsers

  //Open the file and write post value
  file_hndl = fopen(file_path, "r");
  if (!file_hndl)
  {
  printf("Failed to open user parameters file\n");
  exit(1);
  }
  fseek (file_hndl,5,SEEK_SET); //5 => "par1="
  fscanf(file_hndl,"%f",&usr_bess_en);
  fseek (file_hndl,6,SEEK_CUR); //6 => "&par2="
  fscanf(file_hndl,"%f",&usr_besschrg_lmt);
  //printf ("BESS Charge Limit %f\n",usr_besschrg_lmt);
  fseek (file_hndl,6,SEEK_CUR);
  fscanf(file_hndl,"%f",&usr_bessdsch_lmt);
  //printf ("BESS Discharge Limit %f\n",usr_bessdsch_lmt);
  fseek (file_hndl,7,SEEK_CUR);//"&par19="
  fscanf(file_hndl,"%f",&usr_bess_kwh_soc100);
  //printf ("BESS kWh at 100% SoC %f\n",usr_bess_kwh_soc100);
  fseek (file_hndl,6,SEEK_CUR);
  fscanf(file_hndl,"%f",&usr_bess_maxsoc);
  //printf ("BESS max SoC %f\n",usr_bess_maxsoc);
  fseek (file_hndl,6,SEEK_CUR);
  fscanf(file_hndl,"%f",&usr_bess_minsoc);
  //printf ("BESS min SoC %f\n",usr_bess_minsoc);
  fseek (file_hndl,6,SEEK_CUR);
  fscanf(file_hndl,"%f",&usr_bess_kp);
  //printf ("BESS kp %f\n",usr_bess_kp);
  fseek (file_hndl,6,SEEK_CUR);
  fscanf(file_hndl,"%f",&usr_bess_ki);
  //printf ("BESS ki %f\n",usr_bess_ki);
  fseek (file_hndl,6,SEEK_CUR);
  fscanf(file_hndl,"%f",&usr_bess_kd);
  //printf ("BESS kd %f\n",usr_bess_kd);

  fseek (file_hndl,6,SEEK_CUR);
  fscanf(file_hndl,"%f",&usr_pv_en);
  //printf ("PV en %f\n",usr_pv_en);
  fseek (file_hndl,7,SEEK_CUR);//7 => "&par10="
  fscanf(file_hndl,"%f",&usr_pv_max);
  //printf ("PV max %f\n",usr_pv_max);
  fseek (file_hndl,7,SEEK_CUR);
  fscanf(file_hndl,"%f",&usr_pv_kp);
  //printf ("PV kp %f\n",usr_pv_kp);
  fseek (file_hndl,7,SEEK_CUR);
  fscanf(file_hndl,"%f",&usr_pv_ki);
  //printf ("PV ki %f\n",usr_pv_ki);
  fseek (file_hndl,7,SEEK_CUR);
  fscanf(file_hndl,"%f",&usr_pv_kd);
  //printf ("PV kd %f\n",usr_pv_kd);

  fseek (file_hndl,7,SEEK_CUR);
  fscanf(file_hndl,"%f",&usr_genset_en);
  //printf ("Genset en %f\n",usr_genset_en);

  fseek (file_hndl,7,SEEK_CUR);
  fscanf(file_hndl,"%f",&usr_imp_lmt);
  //printf ("Usr Impt %f\n",usr_imp_lmt);
  fseek (file_hndl,7,SEEK_CUR);
  fscanf(file_hndl,"%f",&usr_exp_lmt);
  //printf ("Usr Exp %f\n",usr_exp_lmt);

  fseek (file_hndl,7,SEEK_CUR);
  fscanf(file_hndl,"%f",&usr_exp_prio);

  fseek (file_hndl,7,SEEK_CUR);
  fscanf(file_hndl,"%f",&usr_net_load);

  fseek (file_hndl,7,SEEK_CUR);
  fscanf(file_hndl,"%f",&usr_ctrl_mode_flt);

  fseek (file_hndl,7,SEEK_CUR);
  fscanf(file_hndl,"%f",&usr_bessgfm_prio);

  fseek (file_hndl,7,SEEK_CUR);
  fscanf(file_hndl,"%f",&usr_gensetgfm_prio);

  fseek (file_hndl,7,SEEK_CUR);
  fscanf(file_hndl,"%f",&usr_bess2gfmtrnsf_mrgn);

  fseek (file_hndl,7,SEEK_CUR);
  fscanf(file_hndl,"%f",&usr_bessislnd_mindur);

  fseek (file_hndl,7,SEEK_CUR);
  fscanf(file_hndl,"%f",&usr_maxld_islnd);

  fseek (file_hndl,7,SEEK_CUR);
  fscanf(file_hndl,"%f",&usr_bessislnd_maxwh_ul);

  fseek (file_hndl,7,SEEK_CUR);
  fscanf(file_hndl,"%f",&usr_bessislnd_maxwh_ll);

  fseek (file_hndl,7,SEEK_CUR);
  fscanf(file_hndl,"%f",&usr_gen_baseld);

  fseek (file_hndl,7,SEEK_CUR);
  fscanf(file_hndl,"%f",&usr_grdhlthy_vmin);

  fseek (file_hndl,7,SEEK_CUR);
  fscanf(file_hndl,"%f",&usr_grdhlthy_vmax);

  fseek (file_hndl,7,SEEK_CUR);
  fscanf(file_hndl,"%f",&usr_grdhlthy_fmin);

  fseek (file_hndl,7,SEEK_CUR);
  fscanf(file_hndl,"%f",&usr_grdhlthy_fmax);

  fseek (file_hndl,7,SEEK_CUR);
  fscanf(file_hndl,"%f",&usr_grdhlthy_dur);

  fseek (file_hndl,7,SEEK_CUR);
  fscanf(file_hndl,"%f",&usr_autoislnd_en);

  fseek (file_hndl,7,SEEK_CUR);
  fscanf(file_hndl,"%f",&usr_auto_resync);

  fseek (file_hndl,7,SEEK_CUR);
  fscanf(file_hndl,"%f",&usr_cltrns_resync);

  fseek (file_hndl,7,SEEK_CUR);
  fscanf(file_hndl,"%f",&usr_islnd_cmd);

  fseek (file_hndl,7,SEEK_CUR);
  fscanf(file_hndl,"%f",&usr_grid_resync);

  fseek (file_hndl,7,SEEK_CUR);
  fscanf(file_hndl,"%f",&usr_bess2gen_trnsf);

  fseek (file_hndl,7,SEEK_CUR);
  fscanf(file_hndl,"%f",&usr_gen2bess_trnsf);

  fseek (file_hndl,7,SEEK_CUR);
  fscanf(file_hndl,"%f",&usr_poibrkcl_cmd);

  fseek (file_hndl,7,SEEK_CUR);
  fscanf(file_hndl,"%f",&usr_poibrkop_cmd);

  fseek (file_hndl,7,SEEK_CUR);
  fscanf(file_hndl,"%f",&usr_shut_down);


  fclose (file_hndl);

//--------------- Writing Data to PS DDR --------------------------------------------
//Note below that relative location of each user parameter wrt each other in PS DDR must match with user parameter mapping in PL BRAM

  //Grid Import Limit
  usr_imp_lmt_pl = usr_imp_lmt;
  vadd_psddr[USRPARAM_READ_PSDDR_OFFSET] = usr_imp_lmt_pl;

  //Grid Export Limit
  usr_exp_lmt_pl = usr_exp_lmt;
  vadd_psddr[USRPARAM_READ_PSDDR_OFFSET+1] = usr_exp_lmt_pl;

  //BESS Charge Limit
  usr_besschrg_lmt_pl = usr_besschrg_lmt;
  vadd_psddr[USRPARAM_READ_PSDDR_OFFSET+2] = usr_besschrg_lmt_pl;

  //BESS Discharge Limit
  usr_bessdsch_lmt_pl = usr_bessdsch_lmt;
  vadd_psddr[USRPARAM_READ_PSDDR_OFFSET+3] = usr_bessdsch_lmt_pl;

  //BESS Kp
  usr_bess_kp_plmul128 = usr_bess_kp*128;
  usr_bess_kp_pltmp = usr_bess_kp_plmul128;
  usr_bess_kp_pl = usr_bess_kp_pltmp*128;
  vadd_psddr[USRPARAM_READ_PSDDR_OFFSET+4] = usr_bess_kp_pl;

  //BESS Ki
  usr_bess_ki_plmul128 = usr_bess_ki*128;
  usr_bess_ki_pltmp = usr_bess_ki_plmul128;
  usr_bess_ki_pl = usr_bess_ki_pltmp*128;
  vadd_psddr[USRPARAM_READ_PSDDR_OFFSET+5] = usr_bess_ki_pl;

  //BESS Kd
  usr_bess_kd_plmul128 = usr_bess_kd*128;
  usr_bess_kd_pltmp = usr_bess_kd_plmul128;
  usr_bess_kd_pl = usr_bess_kd_pltmp*128;
  vadd_psddr[USRPARAM_READ_PSDDR_OFFSET+6] = usr_bess_kd_pl;

  //PV Kp
  usr_pv_kp_plmul128 = usr_pv_kp*128;
  usr_pv_kp_pltmp = usr_pv_kp_plmul128;
  usr_pv_kp_pl = usr_pv_kp_pltmp*128;
  vadd_psddr[USRPARAM_READ_PSDDR_OFFSET+7] = usr_pv_kp_pl;

  //PV Ki
  usr_pv_ki_plmul128 = usr_pv_ki*128;
  usr_pv_ki_pltmp = usr_pv_ki_plmul128;
  usr_pv_ki_pl = usr_pv_ki_pltmp*128;
  vadd_psddr[USRPARAM_READ_PSDDR_OFFSET+8] = usr_pv_ki_pl;

  //PV Kd
  usr_pv_kd_plmul128 = usr_pv_kd*128;
  usr_pv_kd_pltmp = usr_pv_kd_plmul128;
  usr_pv_kd_pl = usr_pv_kd_pltmp*128;
  vadd_psddr[USRPARAM_READ_PSDDR_OFFSET+9] = usr_pv_kd_pl;

  //BESS Max SoC
  usr_bess_maxsoc_pl = usr_bess_maxsoc;
  vadd_psddr[USRPARAM_READ_PSDDR_OFFSET+10] = usr_bess_maxsoc_pl;

  //BESS Min SoC
  usr_bess_minsoc_pl = usr_bess_minsoc;
  vadd_psddr[USRPARAM_READ_PSDDR_OFFSET+11] = usr_bess_minsoc_pl;

  //Max PV
  usr_pv_max_pl = usr_pv_max;
  vadd_psddr[USRPARAM_READ_PSDDR_OFFSET+12] = usr_pv_max_pl;

  //Single Bit Commands Register Mapping - Must match with mapping in PL
  //Export Priority - Bit0
  usr_exp_priotmp = usr_exp_prio;
  usr_exp_priotmp = (usr_exp_priotmp>0) ? 1 : 0; //to handle case where user may enter any digit other than 1 or 0
  usr_cmd_pl = usr_cmd_pl |  usr_exp_priotmp;
  //BESS Enable - Bit1
  usr_bess_entmp = usr_bess_en;
  usr_bess_entmp = (usr_bess_entmp>0) ? 1 : 0;
  usr_bess_entmp = usr_bess_entmp *2; //bit shifting
  usr_cmd_pl = usr_cmd_pl |  usr_bess_entmp;
  //PV Enable - Bit2
  usr_pv_entmp = usr_pv_en;
  usr_pv_entmp = (usr_pv_entmp>0) ? 1 : 0;
  usr_pv_entmp = usr_pv_entmp *4;
  usr_cmd_pl = usr_cmd_pl |  usr_pv_entmp;
  //Genset Enable - Bit 3
  usr_genset_entmp = usr_genset_en;
  usr_genset_entmp = (usr_genset_entmp>0) ? 1 : 0;
  usr_genset_entmp = usr_genset_entmp *8;
  usr_cmd_pl = usr_cmd_pl |  usr_genset_entmp;


  //BESS GFM Priority - Bit4 to Bit5
  usr_bessgfm_prio_tmp = usr_bessgfm_prio;
  usr_bessgfm_prio_tmp = 3 & usr_bessgfm_prio_tmp; //to reduce it to two bits (i.e. zero out other bits) incase user enters a value >3
  usr_bessgfm_prio_tmp = usr_bessgfm_prio_tmp * 16; //bit shift to Bit4
  usr_cmd_pl = usr_cmd_pl |  usr_bessgfm_prio_tmp;

  //Genset GFM Priority - Bit6 to Bit7
  usr_gensetgfm_prio_tmp = usr_gensetgfm_prio;
  usr_gensetgfm_prio_tmp = 3 & usr_gensetgfm_prio_tmp; //to reduce it to two bits (i.e. zero out other bits) incase user enters a value >3
  usr_gensetgfm_prio_tmp = usr_gensetgfm_prio_tmp * 64;
  usr_cmd_pl = usr_cmd_pl |  usr_gensetgfm_prio_tmp;


  //Auto-Islanding Enable - Bit 8
  usr_autoislnd_entmp = usr_autoislnd_en;
  usr_autoislnd_entmp = (  usr_autoislnd_entmp>0) ? 1 : 0;
  usr_autoislnd_entmp =   usr_autoislnd_entmp * 256;
  usr_cmd_pl = usr_cmd_pl |    usr_autoislnd_entmp;

  //Auto-Resync to Grid Enable - Bit 9
  usr_auto_resynctmp = usr_auto_resync;
  usr_auto_resynctmp = (  usr_auto_resynctmp>0) ? 1 : 0;
  usr_auto_resynctmp =   usr_auto_resynctmp * 512;
  usr_cmd_pl = usr_cmd_pl |    usr_auto_resynctmp;

  //Close Transition Resync to Grid Enable - Bit 10
  usr_cltrns_resynctmp = usr_cltrns_resync;
  usr_cltrns_resynctmp = (  usr_cltrns_resynctmp>0) ? 1 : 0;
  usr_cltrns_resynctmp =   usr_cltrns_resynctmp * 1024;
  usr_cmd_pl = usr_cmd_pl |    usr_cltrns_resynctmp;

  //User Manual Islanding Command - Bit 11
  usr_islnd_cmdtmp = usr_islnd_cmd;
  usr_islnd_cmdtmp = (  usr_islnd_cmdtmp>0) ? 1 : 0;
  usr_islnd_cmdtmp =   usr_islnd_cmdtmp * 2048;
  usr_cmd_pl = usr_cmd_pl |    usr_islnd_cmdtmp;

  //User Resync to Grid Command - Bit 12
  usr_grid_resynctmp = usr_grid_resync;
  usr_grid_resynctmp = (  usr_grid_resynctmp>0) ? 1 : 0;
  usr_grid_resynctmp =   usr_grid_resynctmp * 4096;
  usr_cmd_pl = usr_cmd_pl |    usr_grid_resynctmp;

  //User BESS to Genset GFM Command - Bit 13
  usr_bess2gen_trnsftmp = usr_bess2gen_trnsf;
  usr_bess2gen_trnsftmp = (  usr_bess2gen_trnsftmp>0) ? 1 : 0;
  usr_bess2gen_trnsftmp =   usr_bess2gen_trnsftmp * 8192;
  usr_cmd_pl = usr_cmd_pl |    usr_bess2gen_trnsftmp;

  //User Genset to BESS GFM Command - Bit 14
  usr_gen2bess_trnsftmp = usr_gen2bess_trnsf;
  usr_gen2bess_trnsftmp = (  usr_gen2bess_trnsftmp>0) ? 1 : 0;
  usr_gen2bess_trnsftmp =   usr_gen2bess_trnsftmp * 16384;
  usr_cmd_pl = usr_cmd_pl |    usr_gen2bess_trnsftmp;

  //User POI Breaker Close Command - Bit 15
  usr_poibrkcl_cmdtmp = usr_poibrkcl_cmd;
  usr_poibrkcl_cmdtmp = (  usr_poibrkcl_cmdtmp>0) ? 1 : 0;
  usr_poibrkcl_cmdtmp =   usr_poibrkcl_cmdtmp * 32768;
  usr_cmd_pl = usr_cmd_pl |    usr_poibrkcl_cmdtmp;

  //User POI Breaker Open Command - Bit 16
  usr_poibrkop_cmdtmp = usr_poibrkop_cmd;
  usr_poibrkop_cmdtmp = (  usr_poibrkop_cmdtmp>0) ? 1 : 0;
  usr_poibrkop_cmdtmp =   usr_poibrkop_cmdtmp * 65536;
  usr_cmd_pl = usr_cmd_pl |    usr_poibrkop_cmdtmp;

  //User Shutdown Command - Bit 17
  usr_shut_downtmp = usr_shut_down;
  usr_shut_downtmp = (  usr_shut_downtmp>0) ? 1 : 0;
  usr_shut_downtmp =   usr_shut_downtmp * 131072;
  usr_cmd_pl = usr_cmd_pl |    usr_shut_downtmp;

  //Control Mode - Bit24 to Bit31
  usr_ctrl_mode	    = usr_ctrl_mode_flt;
  usr_ctrl_mode_tmp = usr_ctrl_mode;//(usr_ctrl_mode==2) ? 2 : 1; //Note 1
  usr_ctrl_mode_tmp = usr_ctrl_mode_tmp *(16777216); //LS by 24bits
  usr_cmd_pl = usr_cmd_pl |  usr_ctrl_mode_tmp;
  //***Similarly map other user commands to remaining bits of this register ***
  vadd_psddr[USRPARAM_READ_PSDDR_OFFSET+13] = usr_cmd_pl;

  //Net Load at POI (Load Following)
  usr_net_load_pl = usr_net_load;
  vadd_psddr[USRPARAM_READ_PSDDR_OFFSET+14] = usr_net_load_pl;


  //BESS Wh at 100% SoC
  usr_bess_wh_soc100_pl = (usr_bess_kwh_soc100)*1000;

  //BESS Wh at Min SoC
  usr_bess_wh_minsoc_pl = (usr_bess_minsoc_pl/100)*(usr_bess_wh_soc100_pl);

  //BESS 2 GFM Transfer Margin in Wh
  usr_bess2gfmtrnsf_mrgn_wh = (usr_bess2gfmtrnsf_mrgn/100) * usr_bess_wh_soc100_pl;
  usr_bess2gfmtrnsf_mrgn_whpl = usr_bess2gfmtrnsf_mrgn_wh; //truncating decimal

  //BESS Wh Required for Min Islanding Duration
  usr_bessislnd_mindur_wh = (usr_bessislnd_mindur/60) * usr_bessdsch_lmt_pl;
  usr_bessislnd_mindur_whpl = usr_bessislnd_mindur_wh; //truncating decimal

  //BESS Min Total Wh Required for Islanding
  vadd_psddr[USRPARAM_READ_PSDDR_OFFSET+15] = usr_bessislnd_mindur_whpl + usr_bess2gfmtrnsf_mrgn_whpl + usr_bess_wh_minsoc_pl;


  //Upper Limit of BESS Maximum SoE in GFM Mode
  usr_bessislnd_maxwh_ul_pl = usr_bessislnd_maxwh_ul;
  vadd_psddr[USRPARAM_READ_PSDDR_OFFSET+16] = usr_bessislnd_maxwh_ul_pl;

  //Lower Limit of BESS Maximum SoE in GFM Mode
  usr_bessislnd_maxwh_ll_pl = usr_bessislnd_maxwh_ll;
  vadd_psddr[USRPARAM_READ_PSDDR_OFFSET+17] = usr_bessislnd_maxwh_ll_pl;

  //BESS Min Total Wh to Exit GFM
  vadd_psddr[USRPARAM_READ_PSDDR_OFFSET+18] = usr_bess2gfmtrnsf_mrgn_whpl + usr_bess_wh_minsoc_pl;


  //Peak Load Expected in Island
  usr_maxld_islnd_pl = usr_maxld_islnd;
  vadd_psddr[USRPARAM_READ_PSDDR_OFFSET+19] = usr_maxld_islnd_pl;

  //Generator Base Load in Island
  usr_gen_baseld_pl = usr_gen_baseld;
  vadd_psddr[USRPARAM_READ_PSDDR_OFFSET+20] = usr_gen_baseld_pl;

  //Grid Healthy Voltage Lower Limit
  usr_grdhlthy_vmin_scld = (usr_grdhlthy_vmin*128);
  vadd_psddr[USRPARAM_READ_PSDDR_OFFSET+21] = usr_grdhlthy_vmin_scld;

  //Grid Healthy Voltage Upper Limit
  usr_grdhlthy_vmax_scld = (usr_grdhlthy_vmax*128);
  vadd_psddr[USRPARAM_READ_PSDDR_OFFSET+22] = usr_grdhlthy_vmax_scld;

  //Grid Healthy Frequency Lower Limit
  usr_grdhlthy_fmin_scld = (usr_grdhlthy_fmin*128);
  vadd_psddr[USRPARAM_READ_PSDDR_OFFSET+23] = usr_grdhlthy_fmin_scld;

  //Grid Healthy Frquency Upper Limit
  usr_grdhlthy_fmax_scld = (usr_grdhlthy_fmax*128);
  vadd_psddr[USRPARAM_READ_PSDDR_OFFSET+24] = usr_grdhlthy_fmax_scld;

  //Grid Healthy Duration
  usr_grdhlthy_dur_pl = usr_grdhlthy_dur;
  vadd_psddr[USRPARAM_READ_PSDDR_OFFSET+25] = usr_grdhlthy_dur_pl;
//---------------------------------------------------------------------------------------

//*******************************************************************************************************
  //request CDMA transfer
  reacquire_usrparam_rmutex:
  pthread_mutex_lock(&mutex_cdma_trnsf);
	if (cdma_trnsf_chk==TRUE)
	{
		pthread_mutex_unlock(&mutex_cdma_trnsf);
		goto reacquire_usrparam_rmutex;
	}
  cdma_trnsf_chk = TRUE;

  //update src addr, dest addr and transfer length
  cdma_src_addr = PSDDR_PBASE + (USRPARAM_READ_PSDDR_OFFSET*0x4);
  cdma_dest_addr = BRAM_PBASE + (USRPARAM_READ_BRAM_OFFSET*0x4);
  cdma_trnsf_length = 0xA0; //32bit*40registers = 160bytes

  pthread_cond_signal(&cond_cdma_trnsf);
  pthread_mutex_unlock(&mutex_cdma_trnsf);

  usr_cmd_pl = 0;

  goto usr_param_loop;

  return 0;
}
