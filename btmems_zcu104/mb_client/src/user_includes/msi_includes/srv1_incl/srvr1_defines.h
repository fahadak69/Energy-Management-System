#ifdef EIT_TESLA_MEGAPACK
	#define SERVER1_IP "192.168.0.78"
	#define SERVER1_NREAD_REGS 10 //assuming 32 read registers for server 1.This can be any number

#elif defined(STCH_MG_HIL)
	#define SERVER1_IP "192.168.0.64"
	#define SERVER1_NREAD_REGS 23 //assuming 32 read registers for server 1.This can be any number
#else
	#define SERVER1_IP "192.168.0.18"
	#define SERVER1_NREAD_REGS 9 //assuming 32 read registers for server 1.This can be any number
#endif


#define SERVER1_MBPORT 503
#define SERVER1_DBG_MSG FALSE //switch for modbus debug messages


#define SERVER1_START_RADDR 0 // starting read register address
