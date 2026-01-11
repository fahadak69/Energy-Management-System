#include SRVR_WTHREADS_GLBLVAR_INIT
#include MB_SRVR_GLBLVAR_INIT

#ifdef ENABLE_PLC_THREAD
#include STCHMG_PLC_SRVR_GLBLVAR_INIT
#endif

#ifdef ENABLE_ADER_PILOT
#include ADER_PILOT_GLBLVAR_INIT
#endif


//#ifdef ENABLE_SERVER1_THREAD
#include SRVR1_GLBLVAR_INIT
//#endif

//#ifdef ENABLE_SERVER2_THREAD
#include SRVR2_GLBLVAR_INIT
//#endif

//#ifdef ENABLE_SERVER3_THREAD
#include SRVR3_GLBLVAR_INIT
//#endif

//#ifdef ENABLE_SERVER4_THREAD
#include SRVR4_GLBLVAR_INIT
//#endif

#ifdef ENABLE_SERVER5_THREAD
#include SRVR5_GLBLVAR_INIT
#endif

#ifdef ENABLE_SERVER6_THREAD
#include SRVR6_GLBLVAR_INIT
#endif


#ifdef ENABLE_SERVER7_THREAD
#include SRVR7_GLBLVAR_INIT
#endif

#ifdef ENABLE_SERVER8_THREAD
#include SRVR8_GLBLVAR_INIT
#endif

#ifdef ENABLE_SERVER9_THREAD
#include SRVR9_GLBLVAR_INIT
#endif

pthread_t usr_param;
pthread_t bess_optmz;
pthread_t ader_pilot;
unsigned int usr_ctrl_mode;
unsigned short int pl_besssp_flg = 0;
