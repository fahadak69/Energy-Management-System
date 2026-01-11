#ifdef STCH_MG_HIL
	#define SERVER3_IP "192.168.0.69"
#elif defined(EIT_TESLA_MEGAPACK) || defined (STCH_MG_ACTUAL_EIT_HIL_HYBRID)
	#define SERVER3_IP "192.168.0.79"
#else
	#define SERVER3_IP "192.168.0.8"
#endif

#ifdef STCH_MG_HIL
	#define SERVER3_MBPORT 503
#elif defined(EIT_TESLA_MEGAPACK) || defined (STCH_MG_ACTUAL_EIT_HIL_HYBRID)
	#define SERVER3_MBPORT 502
#else
	#define SERVER3_MBPORT 1025 //1024 is the port # for 2nd modbus servers in axion 2 at STCH MG
#endif

#define SERVER3_DBG_MSG FALSE //switch for modbus debug messages


#if defined(EIT_TESLA_MEGAPACK) || defined (STCH_MG_ACTUAL_EIT_HIL_HYBRID)
	#define SERVER3_NREAD_REGS 21 //
	#define SERVER3_START_RADDR 350 //starting read register address
#else
	#define SERVER3_NREAD_REGS 54 //
	#define SERVER3_START_RADDR 294 //starting read register address
#endif

