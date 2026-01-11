#if defined(STCH_MG_ACTUAL) || defined(STCH_MG_ACTUAL_EIT_HIL_HYBRID)
	#define STCHMGPLC_SRVR_IP "192.168.0.12"
#elif  defined(STCH_MG_HIL)
	#define STCHMGPLC_SRVR_IP "192.168.0.24"
#endif


#define STCHMGPLC_SRVR_MBPORT 502
#define STCHMGPLC_SRVR_DBG_MSG FALSE //switch for modbus debug messages
