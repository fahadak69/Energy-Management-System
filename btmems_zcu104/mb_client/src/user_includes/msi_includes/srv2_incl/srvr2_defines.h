#ifdef STCH_MG_ACTUAL
	#define SERVER2_IP "192.168.0.5"
#else  STCH_MG_HIL
	#define SERVER2_IP "192.168.0.65"
#endif

#ifdef STCH_MG_Actual
	#define SERVER2_MBPORT 503
#else  STCH_MG_HIL
	#define SERVER2_MBPORT 502
#endif

#define SERVER2_DBG_MSG FALSE //switch for modbus debug messages
#define SERVER2_NREAD_REGS 24 //read registers for server 2.This can be any number
#define SERVER2_START_RADDR 10 //starting read register address

