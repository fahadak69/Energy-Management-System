//This is main program including for modbus client as well as modbus server, file name is misleading

#include "user_includes/main_defines.h"
#include "user_includes/main_includes.h"

#include GLOBAL_VAR_INIT
#include MISC_FUNC
#include CDMA_THREAD

#ifdef ENABLE_MBSRVR_THREAD
#include MB_SRVR_THREAD
#endif

#ifdef ENABLE_PLC_THREAD
#include STCHMG_PLC_SRVR_THREAD
#endif

#ifdef ENABLE_SERVER1_THREAD
#include SERVER1_THREAD
#endif

#ifdef ENABLE_SERVER2_THREAD
#include SERVER2_THREAD
#endif

#ifdef ENABLE_SERVER3_THREAD
#include SERVER3_THREAD
#endif

#ifdef ENABLE_SERVER4_THREAD
#include SERVER4_THREAD
#endif

#ifdef ENABLE_SERVER5_THREAD
#include SERVER5_THREAD
#endif

#ifdef ENABLE_SERVER6_THREAD
#include SERVER6_THREAD
#endif

#ifdef ENABLE_SERVER7_THREAD
#include SERVER7_THREAD
#endif

#ifdef ENABLE_SERVER8_THREAD
#include SERVER8_THREAD
#endif

#ifdef ENABLE_SERVER9_THREAD
#include SERVER9_THREAD
#endif

#include SERVER_WTHREAD
#include USER_PARAM_THREAD

#ifdef ENABLE_PLC_THREAD
#include BESS_OPTMZ_THREAD
#endif

#ifdef ENABLE_ADER_PILOT
#include ADER_PILOT_STCHMG_THREAD
#endif

int main(void)
{
	printf ("********Starting MODBUS Client*************** \n");

	//Declaring EMIO for PL_PS direct GPIO signal
	system("echo 419 > /sys/class/gpio/export"); //PS to PL indicating PS busy fetching write command from PL. Note that for now I have enabled total 8
												  //EMIOs in Vivado PS block design with MSbit being used here for this write cmd busy flag

	system("echo out > /sys/class/gpio/gpio419/direction");//setting direction to output
	system("echo 0 > /sys/class/gpio/gpio419/value");//init to zero

	int cdma_thread_result = 0;
	int srvr_wthread_result = 0;
	int usr_param_result = 0;
	int bess_optmz_result = 0;
	int ader_pilot_result = 0;

    cdma_thread_result = pthread_create(&cdma_hndl, NULL, cdma_thread, NULL);
    if(cdma_thread_result != 0)
    {
 	   printf(stderr, "Could not Create CDMA Thread!\n");
 	   exit(1);
    }

	#ifdef ENABLE_MBSRVR_THREAD
	#include MB_SRVR_THREAD_INIT
	#endif

	#ifdef ENABLE_PLC_THREAD
	#include STCHMG_PLC_SRVR_THREAD_INIT
	#endif

	#ifdef ENABLE_SERVER1_THREAD
	#include SERVER1_THREAD_INIT
	#endif

	#ifdef ENABLE_SERVER2_THREAD
	#include SERVER2_THREAD_INIT
	#endif

	#ifdef ENABLE_SERVER3_THREAD
	#include SERVER3_THREAD_INIT
	#endif

	#ifdef ENABLE_SERVER4_THREAD
	#include SERVER4_THREAD_INIT
	#endif

	#ifdef ENABLE_SERVER5_THREAD
	#include SERVER5_THREAD_INIT
	#endif

	#ifdef ENABLE_SERVER6_THREAD
	#include SERVER6_THREAD_INIT
	#endif

	#ifdef ENABLE_SERVER7_THREAD
	#include SERVER7_THREAD_INIT
	#endif

	#ifdef ENABLE_SERVER8_THREAD
	#include SERVER8_THREAD_INIT
	#endif

	#ifdef ENABLE_SERVER9_THREAD
	#include SERVER9_THREAD_INIT
	#endif


    srvr_wthread_result = pthread_create(&mbsrvr_w, NULL, srvr_wthread, NULL);
    if(srvr_wthread_result != 0)
    {
 	   printf(stderr, "Could not Create Write Thread for MODBUS Server!\n");
 	   exit(1);
    }

    usr_param_result = pthread_create(&usr_param, NULL, usrparam_thread, NULL);
    if(usr_param_result != 0)
    {
 	   printf(stderr, "Could not Create User Parameter Thread!\n");
 	   exit(1);
    }

#ifdef ENABLE_PLC_THREAD
    bess_optmz_result = pthread_create(&bess_optmz, NULL, bess_optmize_thread, NULL);
    if(bess_optmz_result != 0)
    {
 	   printf(stderr, "Could not Create BESS Optimization Thread!\n");
 	   exit(1);
    }
#endif

#ifdef ENABLE_ADER_PILOT
    ader_pilot_result = pthread_create(&ader_pilot, NULL, ader_pilot_thread , NULL);
    if(ader_pilot_result != 0)
    {
 	   printf(stderr, "Could not Create ADER Pilot Thread!\n");
 	   exit(1);
    }
#endif



	#ifdef ENABLE_MBSRVR_THREAD
    pthread_join(mbsrvr_port502, NULL);
	#endif

	#ifdef ENABLE_PLC_THREAD
    pthread_join(mbplc_hb, NULL);
	#endif

	#ifdef ENABLE_SERVER1_THREAD
    pthread_join(mbsrvr1, NULL);
    pthread_join(mbsrvr1_rwait, NULL);
	#endif

	#ifdef ENABLE_SERVER2_THREAD
    pthread_join(mbsrvr2, NULL);
    pthread_join(mbsrvr2_rwait, NULL);
	#endif

	#ifdef ENABLE_SERVER3_THREAD
    pthread_join(mbsrvr3, NULL);
    pthread_join(mbsrvr3_rwait, NULL);
	#endif

	#ifdef ENABLE_SERVER4_THREAD
    pthread_join(mbsrvr4, NULL);
    pthread_join(mbsrvr4_rwait, NULL);
	#endif

	#ifdef ENABLE_SERVER5_THREAD
    pthread_join(mbsrvr5, NULL);
    pthread_join(mbsrvr5_rwait, NULL);
	#endif

	#ifdef ENABLE_SERVER6_THREAD
    pthread_join(mbsrvr6, NULL);
    pthread_join(mbsrvr6_rwait, NULL);
	#endif

	#ifdef ENABLE_SERVER7_THREAD
    pthread_join(mbsrvr7, NULL);
    pthread_join(mbsrvr7_rwait, NULL);
	#endif

	#ifdef ENABLE_SERVER8_THREAD
    pthread_join(mbsrvr8, NULL);
    pthread_join(mbsrvr8_rwait, NULL);
	#endif

	#ifdef ENABLE_SERVER9_THREAD
    pthread_join(mbsrvr9, NULL);
    pthread_join(mbsrvr9_rwait, NULL);
	#endif

    pthread_join(mbsrvr_w, NULL);
    pthread_join(usr_param, NULL);
    pthread_join(cdma_hndl, NULL);
    pthread_join(bess_optmz, NULL);

	#ifdef ENABLE_ADER_PILOT
    pthread_join(ader_pilot, NULL);
	#endif

    printf ("********Exiting Application*************** \n");

    return 0;
}



