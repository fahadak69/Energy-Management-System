// *************************** MODBUS READ Code for Server 6 - Modify as required *********************************************************************

//------ Thread waiting for server 6 read data to arrive -------------------
void* mbsrvr6_rwait_thread (void* args)
{
	unsigned int meter_bess_3p_plr;
	unsigned int meter_bess_3q_plr;
	unsigned int meter_bess_3s_plr;
	unsigned int meter_bess_pf_plr;
	unsigned int meter_bess_ia_plr;
	unsigned int meter_bess_ib_plr;
	unsigned int meter_bess_ic_plr;
	unsigned int meter_bess_in_plr;
	unsigned int meter_bess_vab_plr;
	unsigned int meter_bess_vbc_plr;
	unsigned int meter_bess_vca_plr;
	unsigned int meter_bess_freq_plr;

	srvr6_rdbk_waitloop:
	//waiting for server 6 readback data to arrive
	sem_wait(&srvr6_rdbk_sem);

	//***********************************************************
	//here you can map modbus read register data to fpga msi interface signals for this server

	//***********************************************************

	meter_bess_3p_plr 	= server6_rregs[0] << 16;
	meter_bess_3p_plr   	= meter_bess_3p_plr | (server6_rregs[1]); //Note here LSB is in register 1 (as coming from modbus server simulator), update accordingly for specific modbus server


	meter_bess_3q_plr 		= server6_rregs[2] << 16;
	meter_bess_3q_plr   	= meter_bess_3q_plr | (server6_rregs[3]);

	meter_bess_3s_plr 	= server6_rregs[4] << 16;
	meter_bess_3s_plr   	= meter_bess_3s_plr | (server6_rregs[5]);

	meter_bess_pf_plr 	= server6_rregs[6] << 16;
	meter_bess_pf_plr   = meter_bess_pf_plr | (server6_rregs[7]);

	meter_bess_ia_plr 	= server6_rregs[8] << 16;
	meter_bess_ia_plr   	= meter_bess_ia_plr | (server6_rregs[9]);

	meter_bess_ib_plr 	= server6_rregs[10] << 16;
	meter_bess_ib_plr   	= meter_bess_ib_plr | (server6_rregs[11]);

	meter_bess_ic_plr 	= server6_rregs[12] << 16;
	meter_bess_ic_plr   	= meter_bess_ic_plr | (server6_rregs[13]);

	meter_bess_in_plr 	= server6_rregs[14] << 16;
	meter_bess_in_plr   	= meter_bess_in_plr | (server6_rregs[15]);

	meter_bess_vab_plr 	= server6_rregs[16] << 16;
	meter_bess_vab_plr   = meter_bess_vab_plr | (server6_rregs[17]);

	meter_bess_vbc_plr 	= server6_rregs[18] << 16;
	meter_bess_vbc_plr   = meter_bess_vbc_plr | (server6_rregs[19]);

	meter_bess_vca_plr 	= server6_rregs[20] << 16;
	meter_bess_vca_plr   = meter_bess_vca_plr | (server6_rregs[21]);

	meter_bess_freq_plr 	= server6_rregs[22] << 16;
	meter_bess_freq_plr   = meter_bess_freq_plr | (server6_rregs[23]);


	//--------------- Writing Data to PS DDR --------------------------------------------

	  //POI Active Power
	  vadd_psddr[SRVR6_READ_PSDDR_OFFSET] = meter_bess_3p_plr;

	  //POI Reactive Power
	  vadd_psddr[SRVR6_READ_PSDDR_OFFSET+1] = meter_bess_3q_plr;

	  //POI Apparent Power
	  vadd_psddr[SRVR6_READ_PSDDR_OFFSET+2] = meter_bess_3s_plr;

	  //POI PF
	  vadd_psddr[SRVR6_READ_PSDDR_OFFSET+3] = meter_bess_pf_plr;

	  //POI Phase A Current
	  vadd_psddr[SRVR6_READ_PSDDR_OFFSET+4] = meter_bess_ia_plr;

	  //POI Phase B Current
	  vadd_psddr[SRVR6_READ_PSDDR_OFFSET+5] = meter_bess_ib_plr;

	  //POI Phase C Current
	  vadd_psddr[SRVR6_READ_PSDDR_OFFSET+6] = meter_bess_ic_plr;

	  //POI Neutral Current
	  vadd_psddr[SRVR6_READ_PSDDR_OFFSET+7] = meter_bess_in_plr;

	  //POI VAB
	  vadd_psddr[SRVR6_READ_PSDDR_OFFSET+8] = meter_bess_vab_plr;

	  //POI VBC
	  vadd_psddr[SRVR6_READ_PSDDR_OFFSET+9] = meter_bess_vbc_plr;

	  //POI VCA
	  vadd_psddr[SRVR6_READ_PSDDR_OFFSET+10] = meter_bess_vca_plr;

	  //POI Frequency
	  vadd_psddr[SRVR6_READ_PSDDR_OFFSET+11] = meter_bess_freq_plr;


	//request CDMA transfer
	reacquire_srvr6_rmutex:
	pthread_mutex_lock(&mutex_cdma_trnsf);
	if (cdma_trnsf_chk==TRUE)
	{
		pthread_mutex_unlock(&mutex_cdma_trnsf);
		goto reacquire_srvr6_rmutex;
	}
	cdma_trnsf_chk = TRUE;

	//Requesting CDMA transfer
	cdma_src_addr = PSDDR_PBASE + (SRVR6_READ_PSDDR_OFFSET*0x4);
    cdma_dest_addr = BRAM_PBASE + (SRVR6_READ_BRAM_OFFSET*0x4);
    cdma_trnsf_length = 0x30; //32bit*12locations = 48bytes. Note Max space reserved is 32bit*40locations = 160bytes

	pthread_cond_signal(&cond_cdma_trnsf);
	pthread_mutex_unlock(&mutex_cdma_trnsf);

	//loop back to wait state.
	goto srvr6_rdbk_waitloop;

	return 0;
}

// ------------------ Server6 MODBUS polling thread -----------------------
void* mbsrvr6_thread (void* args)
{
	//Server 6 variable initialization
	int rc;
	int i;

	ctx_srvr6 = modbus_new_tcp(SERVER6_IP, SERVER6_MBPORT);
	modbus_set_debug(ctx_srvr6, SERVER6_DBG_MSG);

server6_mb_connec:
	if (modbus_connect(ctx_srvr6) == -1) {
		//printf("Modbus Server 6 Connection Failed - Retrying\n");
		goto server6_mb_connec;
	}

server6_mb_read:

	/*reading multiple registers values*/
	rc = modbus_read_registers(ctx_srvr6, SERVER6_START_RADDR, SERVER6_NREAD_REGS, server6_rregs);
	if (rc != SERVER6_NREAD_REGS)
	{
		printf("ERROR Reading Server 6 Registers - Re-establishing Connection\n");
		modbus_close(ctx_srvr6);
		goto server6_mb_connec;
	}

	//sending signal to a waiting thread that read data has arrived
	sem_post(&srvr6_rdbk_sem);

	goto server6_mb_read; //continuous read

	return 0;
}
