#define MY_MAX(a, b) ((a) > (b) ? (a) : (b))
#define MY_MIN(c, d) ((c) < (d) ? (c) : (d))

#define ENABLE_MBSRVR_THREAD

#define ENABLE_SERVER1_THREAD
//#define ENABLE_SERVER2_THREAD
#define ENABLE_SERVER3_THREAD
//#define ENABLE_SERVER4_THREAD
#define ENABLE_SERVER5_THREAD
//#define ENABLE_SERVER6_THREAD
//#define ENABLE_SERVER7_THREAD
//#define ENABLE_SERVER8_THREAD
//#define ENABLE_SERVER9_THREAD
#define ENABLE_PLC_THREAD		//Undefine it for EIT_TESLA_MEGAPACK case or any other tests where PLC is not involved in testing

//EIT Model with Tesla Megapack "EIT_TESLA_MEGAPACK" or STCH MG HIL Model "STCH_MG_HIL" or Actual Site "STCH_MG_ACTUAL" or Hybrid "STCH_MG_ACTUAL_EIT_HIL_HYBRID"
//"STCH_MG_HIL" or "STCH_MG_ACTUAL" basically defines whether readback is done directly from modbus server of individual assets (bess, pv)
//or via plc, the latter is applicable for real stch mg (since tesla and sma dont allow polling by multiple clients) and former is for stch mg in hil\
//"STCH_MG_ACTUAL_EIT_HIL_HYBRID" is for hybrid testing where we control real tesla powerpack but read POI data from EIT Santa Clara HIL case (for PHIL testing)
#define STCH_MG_ACTUAL

//ADER Pilot : Undefine (comment out) if not using
#define ENABLE_ADER_PILOT

//STATUS PRINTS
#define STAT_CDMA_PRINT 1

//DEBUGS
//#define DBG_CDMA_TRNSF_DONE 1 //debug message
//#define DBG_WCMD_CDMA_TRNSF 1 //debug message
//#define DBG_CDMA_TRNSF_INIT 1 //debug message

//This indicates that testing is for STCH MG via PLC, whether at HIL or actual STCH MG. This define blocks initialization
//of write threads for each server, since all the writes are done via PLC
#ifdef ENABLE_PLC_THREAD
#define STCH_MG_PLC
#endif


//PL Read BRAM Relative Location from Base Address - This must match mapping in PL
//Note that starting addresses below have been assigned assuming 40 locations (40 bytes) for each asset (except meter which has 48 and user param has 160). If different # of locations required, adjust
//cdma transfer length in the respective code accordingly
#define SRVR1_READ_BRAM_OFFSET 		0X00000000 //BESS
#define SRVR2_READ_BRAM_OFFSET 		0X00000028 //PV
#define SRVR3_READ_BRAM_OFFSET 		0X00000050 //POI Meter
#define SRVR4_READ_BRAM_OFFSET 		0X00000080 //Genset
#define SRVR5_READ_BRAM_OFFSET 		0X000000A8 //Relay
#define SRVR6_READ_BRAM_OFFSET 		0X000000D0 //BESS Meter
#define SRVR7_READ_BRAM_OFFSET 		0X000000100 //PV Meter
#define SRVR8_READ_BRAM_OFFSET 		0X000000130 //Genset Meter
#define SRVR9_READ_BRAM_OFFSET 		0X000000160 //Load Meter
#define USRPARAM_READ_BRAM_OFFSET 	0X000000188 //User input parameters

//PS DDR Relative Location from Base Address
#define SRVR1_READ_PSDDR_OFFSET 	0X00000000  //BESS
#define SRVR2_READ_PSDDR_OFFSET 	0X00000028  //PV
#define SRVR3_READ_PSDDR_OFFSET 	0X00000050  //POI Meter
#define SRVR4_READ_PSDDR_OFFSET 	0X00000080  //Genset
#define SRVR5_READ_PSDDR_OFFSET 	0X000000A8  //Relay
#define SRVR6_READ_PSDDR_OFFSET 	0X000000D0  //BESS Meter
#define SRVR7_READ_PSDDR_OFFSET 	0X000000100 //PV Meter
#define SRVR8_READ_PSDDR_OFFSET 	0X000000130 //Genset Meter
#define SRVR9_READ_PSDDR_OFFSET 	0X000000160  //Load Meter
#define USRPARAM_READ_PSDDR_OFFSET 	0X000000188 //User input parameters
#define WCMD_PSDDR_OFFSET 			0X000000228 //PL to PS Write Commands

//Total number of write command registers. Adjust it based on # of assets being controlled and required # of write commands needed for each
#define TOTAL_W_REGISTERS			0X0000000D

//PATHS
#define GLOBAL_VAR_INIT "user_includes/global_var_init.h"

#define MB_SERVER_DEFINES "user_includes/msi_includes/mb_srvr/mb_srvr_defines.h"

#define STCHMG_PLCSRVR_DEFINES "user_includes/msi_includes/stchmgplc_srvr_incl/stchmg_plcsrvr_defines.h"

#define SERVER1_DEFINES "user_includes/msi_includes/srv1_incl/srvr1_defines.h"

#define SERVER2_DEFINES "user_includes/msi_includes/srv2_incl/srvr2_defines.h"

#define SERVER3_DEFINES "user_includes/msi_includes/srv3_incl/srvr3_defines.h"

#define SERVER4_DEFINES "user_includes/msi_includes/srv4_incl/srvr4_defines.h"

#define SERVER5_DEFINES "user_includes/msi_includes/srv5_incl/srvr5_defines.h"

#define SERVER6_DEFINES "user_includes/msi_includes/srv6_incl/srvr6_defines.h"

#define SERVER7_DEFINES "user_includes/msi_includes/srv7_incl/srvr7_defines.h"

#define SERVER8_DEFINES "user_includes/msi_includes/srv8_incl/srvr8_defines.h"

#define SERVER9_DEFINES "user_includes/msi_includes/srv9_incl/srvr9_defines.h"


#define MB_SRVR_THREAD "user_includes/msi_includes/mb_srvr/mb_srvr.h"
#define MB_SRVR_GLBLVAR_INIT "user_includes/msi_includes/mb_srvr/mbsrvr_glblvar_init.h"


#define STCHMG_PLC_SRVR_THREAD "user_includes/msi_includes/stchmgplc_srvr_incl/stchmg_plcsrvr_thread.h"
#define STCHMG_PLC_SRVR_GLBLVAR_INIT "user_includes/msi_includes/stchmgplc_srvr_incl/stchmg_plcsrvr_glblvar_init.h"

#define SERVER1_THREAD "user_includes/msi_includes/srv1_incl/mbsrvr1_thread.h"

#define SRVR1_GLBLVAR_INIT "user_includes/msi_includes/srv1_incl/srvr1_glblvar_init.h"


#define SERVER2_THREAD "user_includes/msi_includes/srv2_incl/mbsrvr2_thread.h"

#define SRVR2_GLBLVAR_INIT "user_includes/msi_includes/srv2_incl/srvr2_glblvar_init.h"


#define SERVER3_THREAD "user_includes/msi_includes/srv3_incl/mbsrvr3_thread.h"

#define SRVR3_GLBLVAR_INIT "user_includes/msi_includes/srv3_incl/srvr3_glblvar_init.h"

#define SERVER4_THREAD "user_includes/msi_includes/srv4_incl/mbsrvr4_thread.h"

#define SRVR4_GLBLVAR_INIT "user_includes/msi_includes/srv4_incl/srvr4_glblvar_init.h"

#define SERVER5_THREAD "user_includes/msi_includes/srv5_incl/mbsrvr5_thread.h"

#define SRVR5_GLBLVAR_INIT "user_includes/msi_includes/srv5_incl/srvr5_glblvar_init.h"

#define SERVER6_THREAD "user_includes/msi_includes/srv6_incl/mbsrvr6_thread.h"

#define SRVR6_GLBLVAR_INIT "user_includes/msi_includes/srv6_incl/srvr6_glblvar_init.h"

#define SERVER7_THREAD "user_includes/msi_includes/srv7_incl/mbsrvr7_thread.h"

#define SRVR7_GLBLVAR_INIT "user_includes/msi_includes/srv7_incl/srvr7_glblvar_init.h"

#define SERVER8_THREAD "user_includes/msi_includes/srv8_incl/mbsrvr8_thread.h"

#define SRVR8_GLBLVAR_INIT "user_includes/msi_includes/srv8_incl/srvr8_glblvar_init.h"

#define SERVER9_THREAD "user_includes/msi_includes/srv9_incl/mbsrvr9_thread.h"

#define SRVR9_GLBLVAR_INIT "user_includes/msi_includes/srv9_incl/srvr9_glblvar_init.h"



#define SRVR_WTHREADS_GLBLVAR_INIT "user_includes/msi_includes/srvr_wthread_glblvar_init.h"

#define CDMA_THREAD "user_includes/cdma_thread.h"

#define SERVER_WTHREAD "user_includes/msi_includes/server_wthread.h"

#define USER_PARAM_THREAD "user_includes/userparam_thread.h"

#define BESS_OPTMZ_THREAD "user_includes/bess_optmz_thread.h"

#define MB_SRVR_THREAD_INIT "user_includes/msi_includes/mb_srvr/mb_srvr_init.h"

#define ADER_PILOT_STCHMG_THREAD "user_includes/ader_pilot/ader_pilot_stchmg.h"
#define ADER_PILOT_DEFINES "user_includes/ader_pilot/ader_pilot_defines.h"
#define ADER_PILOT_GLBLVAR_INIT "user_includes/ader_pilot/ader_pilot_glblvar_init.h"



#define STCHMG_PLC_SRVR_THREAD_INIT "user_includes/msi_includes/stchmgplc_srvr_incl/stchmg_plcsrvr_thread_init.h"
#define SERVER1_THREAD_INIT "user_includes/msi_includes/srv1_incl/srvr1_thread_init.h"
#define SERVER2_THREAD_INIT "user_includes/msi_includes/srv2_incl/srvr2_thread_init.h"
#define SERVER3_THREAD_INIT "user_includes/msi_includes/srv3_incl/srvr3_thread_init.h"
#define SERVER4_THREAD_INIT "user_includes/msi_includes/srv4_incl/srvr4_thread_init.h"
#define SERVER5_THREAD_INIT "user_includes/msi_includes/srv5_incl/srvr5_thread_init.h"
#define SERVER6_THREAD_INIT "user_includes/msi_includes/srv6_incl/srvr6_thread_init.h"
#define SERVER7_THREAD_INIT "user_includes/msi_includes/srv7_incl/srvr7_thread_init.h"
#define SERVER8_THREAD_INIT "user_includes/msi_includes/srv8_incl/srvr8_thread_init.h"
#define SERVER9_THREAD_INIT "user_includes/msi_includes/srv9_incl/srvr9_thread_init.h"

#define MISC_FUNC "user_includes/misc_func.h"

