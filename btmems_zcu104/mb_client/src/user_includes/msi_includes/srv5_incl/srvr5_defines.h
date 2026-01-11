#ifdef STCH_MG_ACTUAL
	#define SERVER5_IP "192.168.0.6"
#else  STCH_MG_HIL
	#define SERVER5_IP "192.168.0.13"
#endif


#define SERVER5_MBPORT 503
#define SERVER5_DBG_MSG FALSE //switch for modbus debug messages
#define SERVER5_NREAD_REGS 123
#define SERVER5_START_RADDR 10//1 //starting read register address

