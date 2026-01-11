// *************************** MODBUS READ Code for Server 8 - Modify as required *********************************************************************

//------ Thread waiting for server 8 read data to arrive -------------------
void* mbsrvr8_rwait_thread (void* args)
{
	unsigned int meter_gen_3p_plr;
	unsigned int meter_gen_3q_plr;
	unsigned int meter_gen_3s_plr;
	unsigned int meter_gen_pf_plr;
	unsigned int meter_gen_ia_plr;
	unsigned int meter_gen_ib_plr;
	unsigned int meter_gen_ic_plr;
	unsigned int meter_gen_in_plr;
	unsigned int meter_gen_vab_plr;
	unsigned int meter_gen_vbc_plr;
	unsigned int meter_gen_vca_plr;
	unsigned int meter_gen_freq_plr;

	srvr8_rdbk_waitloop:
	//waiting for server 8 readback data to arrive
	sem_wait(&srvr8_rdbk_sem);

	//***********************************************************
	//here you can map modbus read register data to fpga msi interface signals for this server

	//***********************************************************

	meter_gen_3p_plr 		= server8_rregs[0] << 16;
	meter_gen_3p_plr   		= meter_gen_3p_plr | (server8_rregs[1]); //Note here LSB is in register 1 (as coming from modbus server simulator), update accordingly for specific modbus server


	meter_gen_3q_plr 		= server8_rregs[2] << 16;
	meter_gen_3q_plr   		= meter_gen_3q_plr | (server8_rregs[3]);

	meter_gen_3s_plr 		= server8_rregs[4] << 16;
	meter_gen_3s_plr   		= meter_gen_3s_plr | (server8_rregs[5]);

	meter_gen_pf_plr 		= server8_rregs[6] << 16;
	meter_gen_pf_plr   		= meter_gen_pf_plr | (server8_rregs[7]);

	meter_gen_ia_plr 		= server8_rregs[8] << 16;
	meter_gen_ia_plr   		= meter_gen_ia_plr | (server8_rregs[9]);

	meter_gen_ib_plr 		= server8_rregs[10] << 16;
	meter_gen_ib_plr   		= meter_gen_ib_plr | (server8_rregs[11]);

	meter_gen_ic_plr 		= server8_rregs[12] << 16;
	meter_gen_ic_plr   		= meter_gen_ic_plr | (server8_rregs[13]);

	meter_gen_in_plr 		= server8_rregs[14] << 16;
	meter_gen_in_plr 	  	= meter_gen_in_plr | (server8_rregs[15]);

	meter_gen_vab_plr 		= server8_rregs[16] << 16;
	meter_gen_vab_plr   		= meter_gen_vab_plr | (server8_rregs[17]);

	meter_gen_vbc_plr 		= server8_rregs[18] << 16;
	meter_gen_vbc_plr  		= meter_gen_vbc_plr | (server8_rregs[19]);

	meter_gen_vca_plr 		= server8_rregs[20] << 16;
	meter_gen_vca_plr   		= meter_gen_vca_plr | (server8_rregs[21]);

	meter_gen_freq_plr 		= server8_rregs[22] << 16;
	meter_gen_freq_plr   	= meter_gen_freq_plr | (server8_rregs[23]);


	//--------------- Writing Data to PS DDR --------------------------------------------

	  //POI Active Power
	  vadd_psddr[SRVR8_READ_PSDDR_OFFSET] = meter_gen_3p_plr;

	  //POI Reactive Power
	  vadd_psddr[SRVR8_READ_PSDDR_OFFSET+1] = meter_gen_3q_plr;

	  //POI Apparent Power
	  vadd_psddr[SRVR8_READ_PSDDR_OFFSET+2] = meter_gen_3s_plr;

	  //POI PF
	  vadd_psddr[SRVR8_READ_PSDDR_OFFSET+3] = meter_gen_pf_plr;

	  //POI Phase A Current
	  vadd_psddr[SRVR8_READ_PSDDR_OFFSET+4] = meter_gen_ia_plr;

	  //POI Phase B Current
	  vadd_psddr[SRVR8_READ_PSDDR_OFFSET+5] = meter_gen_ib_plr;

	  //POI Phase C Current
	  vadd_psddr[SRVR8_READ_PSDDR_OFFSET+6] = meter_gen_ic_plr;

	  //POI Neutral Current
	  vadd_psddr[SRVR8_READ_PSDDR_OFFSET+7] = meter_gen_in_plr;

	  //POI VAB
	  vadd_psddr[SRVR8_READ_PSDDR_OFFSET+8] = meter_gen_vab_plr;

	  //POI VBC
	  vadd_psddr[SRVR8_READ_PSDDR_OFFSET+9] = meter_gen_vbc_plr;

	  //POI VCA
	  vadd_psddr[SRVR8_READ_PSDDR_OFFSET+10] = meter_gen_vca_plr;

	  //POI Frequency
	  vadd_psddr[SRVR8_READ_PSDDR_OFFSET+11] = meter_gen_freq_plr;


	//request CDMA transfer
	reacquire_srvr8_rmutex:
	pthread_mutex_lock(&mutex_cdma_trnsf);
	if (cdma_trnsf_chk==TRUE)
	{
		pthread_mutex_unlock(&mutex_cdma_trnsf);
		goto reacquire_srvr8_rmutex;
	}
	cdma_trnsf_chk = TRUE;

	//Requesting CDMA transfer
	cdma_src_addr = PSDDR_PBASE + (SRVR8_READ_PSDDR_OFFSET*0x4);
    cdma_dest_addr = BRAM_PBASE + (SRVR8_READ_BRAM_OFFSET*0x4);
    cdma_trnsf_length = 0x30; //32bit*12locations = 48bytes. Note Max space reserved is 32bit*40locations = 160bytes

	pthread_cond_signal(&cond_cdma_trnsf);
	pthread_mutex_unlock(&mutex_cdma_trnsf);

	//loop back to wait state.
	goto srvr8_rdbk_waitloop;

	return 0;
}

// ------------------ Server8 MODBUS polling thread -----------------------
void* mbsrvr8_thread (void* args)
{
	//Server 8 variable initialization
	int rc;
	int i;

	ctx_srvr8 = modbus_new_tcp(SERVER8_IP, SERVER8_MBPORT);
	modbus_set_debug(ctx_srvr8, SERVER8_DBG_MSG);

server8_mb_connec:
	if (modbus_connect(ctx_srvr8) == -1) {
		//printf("Modbus Server 8 Connection Failed - Retrying\n");
		goto server8_mb_connec;
	}

server8_mb_read:

	/*reading multiple registers values*/
	rc = modbus_read_registers(ctx_srvr8, SERVER8_START_RADDR, SERVER8_NREAD_REGS, server8_rregs);
	if (rc != SERVER8_NREAD_REGS)
	{
		printf("ERROR Reading Server 8 Registers - Re-establishing Connection\n");
		modbus_close(ctx_srvr8);
		goto server8_mb_connec;
	}

	//sending signal to a waiting thread that read data has arrived
	sem_post(&srvr8_rdbk_sem);

	goto server8_mb_read; //continuous read

	return 0;
}
