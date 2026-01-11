// *************************** MODBUS READ AND WRITE Code for Server 5 - Modify as required *********************************************************************

//------ Thread waiting for server 5 read data to arrive -------------------
void* mbsrvr5_rwait_thread (void* args)
{
	unsigned int rly_prot_stat = 0;
	unsigned int rly_io_ltchsv_stat = 0;
	unsigned int rly_hw_err = 0;
	unsigned int rly_lvab_lvbc;
	unsigned int rly_lvca_bvab;
	unsigned int rly_bvbc_bvca;
	unsigned int rly_lfrq_bfrq;

	uint16_t rly_poi_cbstat = 0;
	uint16_t rly_mgmain_cbstat = 0;

	uint16_t rly_evnt_typ = 0;

	srvr5_rdbk_waitloop:

	//waiting for server 5 readback data to arrive
	sem_wait(&srvr5_rdbk_sem);

	//***********************************************************
	//here you can map modbus read register data to fpga msi interface signals for this server
	rly_evnt_typ			= (*(server5_rregs_ptr+106));
	//printf ("Relay Event Type %d \n",rly_evnt_typ);
	rly_poi_cbstat			= (((*(server5_rregs_ptr+111))>>4) & 0x0001);
	rly_mgmain_cbstat		= (((*(server5_rregs_ptr+113))>>7) & 0x0001);

	if (((rly_evnt_typ>0) && (rly_evnt_typ<13)) || ((rly_evnt_typ>27) && (rly_evnt_typ<56)))
		rly_prot_stat		= rly_prot_stat | 0x00000001;
	else
		rly_prot_stat		= rly_prot_stat & 0xFFFFFFFE;

	if (rly_poi_cbstat!=0)
		rly_io_ltchsv_stat		= rly_io_ltchsv_stat | 0x00000001;
	else
		rly_io_ltchsv_stat		= rly_io_ltchsv_stat & 0xFFFFFFFE;

	//Not mapping these for now as they are not being used in PL currently
//	rly_hw_err				= server5_rregs[3];
//	rly_lvab_lvbc			= (server5_rregs[5] << 16) | server5_rregs[2];  //lvab is LSW
//	rly_lvca_bvab			= (server5_rregs[7] << 16) | server5_rregs[4];  //lvca is LSW
//	rly_bvbc_bvca			= (server5_rregs[9] << 16) | server5_rregs[6];  //bvbc is LSW
//	rly_lfrq_bfrq			= (server5_rregs[11] << 16) | server5_rregs[8]; //line freq is LSW

	//***********************************************************


	//--------------- Writing Data to PS DDR --------------------------------------------
	//Note below that relative location of each data wrt each other in PS DDR must match with data mapping in PL BRAM

	  //Relay protection elements status
	  //printf ("Relay Protection Status %d \n",rly_prot_stat);
	  vadd_psddr[SRVR5_READ_PSDDR_OFFSET] = rly_prot_stat;

	  //Relay inputs, outputs, latches and logic variables status
	  //printf ("Relay CB Status %d \n",rly_io_ltchsv_stat);
	  vadd_psddr[SRVR5_READ_PSDDR_OFFSET+1] = rly_io_ltchsv_stat;

	  //Relay hardware status/errors
	  vadd_psddr[SRVR5_READ_PSDDR_OFFSET+2] = rly_hw_err;

	  //Relay Line Side VAB and VBC
	  vadd_psddr[SRVR5_READ_PSDDR_OFFSET+3] = rly_lvab_lvbc;

	  //Relay Line Side VCA and Bus Side VAB
	  vadd_psddr[SRVR5_READ_PSDDR_OFFSET+4] = rly_lvca_bvab;

	  //Relay Bus Side VBC and VCA
	  vadd_psddr[SRVR5_READ_PSDDR_OFFSET+5] = rly_bvbc_bvca;

	  //Relay Line Side Frequency and Bus Side Frequency
	  vadd_psddr[SRVR5_READ_PSDDR_OFFSET+6] = rly_lfrq_bfrq;

	  //request CDMA transfer
	  reacquire_srvr5_rmutex:
	  pthread_mutex_lock(&mutex_cdma_trnsf);
	  if (cdma_trnsf_chk==TRUE)
	  {
		  pthread_mutex_unlock(&mutex_cdma_trnsf);
		  goto reacquire_srvr5_rmutex;
	  }
	  cdma_trnsf_chk = TRUE;

	//Requesting CDMA transfer
	cdma_src_addr = PSDDR_PBASE + (SRVR5_READ_PSDDR_OFFSET*0x4); //multiplying by 4 as this is byte level addressing
    cdma_dest_addr = BRAM_PBASE + (SRVR5_READ_BRAM_OFFSET*0x4);
    cdma_trnsf_length = 0x1C; //32bit*7locations = 28bytes. Note Max space reserved is 32bit*40locations = 160bytes

	pthread_cond_signal(&cond_cdma_trnsf);
	pthread_mutex_unlock(&mutex_cdma_trnsf);

#ifdef ENABLE_ADER_PILOT
	atomic_store(&atomic_poi_cbstat, rly_poi_cbstat); //atomic operation to synchronize between read and write across different threads
	atomic_store(&atomic_mgmain_cbstat, rly_mgmain_cbstat);
#endif

	//loop back to wait state.
	goto srvr5_rdbk_waitloop;

	return 0;
}

// ------------------ Server5 MODBUS polling thread -----------------------
void* mbsrvr5_thread (void* args)
{
	//Server 5 variable initialization
	int rc[5];

	ctx_srvr5 = modbus_new_tcp(SERVER5_IP, SERVER5_MBPORT);
	modbus_set_debug(ctx_srvr5, SERVER5_DBG_MSG);

server5_mb_connec:
	if (modbus_connect(ctx_srvr5) == -1) {
		printf("Modbus Server 5 Connection Failed - Retrying\n");
		goto server5_mb_connec;
	}


server5_mb_read:
	if (srvr5_wsig!=0)
		sem_wait(&srvr5_rw_sem);

    pthread_mutex_lock(&srvr5_rw);
    /*reading multiple registers values*/
	rc[0] = modbus_read_registers(ctx_srvr5, 280, 98, server5_rregs_ptr);
	rc[1] = modbus_read_registers(ctx_srvr5, 434, 6, server5_rregs_ptr+98);
	rc[2] = modbus_read_registers(ctx_srvr5, 470, 2, server5_rregs_ptr+104);
	rc[3] = modbus_read_registers(ctx_srvr5, 1699, 1, server5_rregs_ptr+106);
	rc[4] = modbus_read_registers(ctx_srvr5, 182, 16, server5_rregs_ptr+107);

	pthread_mutex_unlock(&srvr5_rw);

	if ((rc[0] != 98) || (rc[1] != 6) || (rc[2] != 2) || (rc[3] != 1) || (rc[4] != 16))
	{
		printf("ERROR Reading Server 5 Registers - Re-establishing Connection\n");
		modbus_close(ctx_srvr5);
		goto server5_mb_connec;
	}

	//sending signal to a waiting thread that read data has arrived
	sem_post(&srvr5_rdbk_sem);

	usleep(250000); //250msec
	goto server5_mb_read; //continuous read

	return 0;
}

// ------------------ Server5 (Relay) MODBUS write thread -----------------------

void* mbsrvr5_wthread (void* args)
{
	//Note Relay will be server 5
	uint64_t srvr5_brkop_wcmdchk; 		//check for Breaker Open command
	uint64_t srvr5_brkcl_wcmdchk;		//check for Breaker Close command

server5_wmb_loop:
	//waiting for server 5 write command to be received from PL
	sem_wait(&srvr5_wcmd_sem);


	//signaling srvr5 modbus write thread if server5 command was sent from PL to PS

	srvr5_brkop_wcmdchk = mbsrvr_wcmd_stat & 0x8000000; //bit 27 is for srvr5 breaker open cmd
	if (srvr5_brkop_wcmdchk>0)
	{
		sem_post(&srvr5_wcmd_brkopsem);
	}
	srvr5_brkcl_wcmdchk = mbsrvr_wcmd_stat & 0x10000000; //bit 28 is for srvr5 breaker close cmd
	if (srvr5_brkcl_wcmdchk>0)
	{
		sem_post(&srvr5_wcmd_brkclsem);
	}

	goto server5_wmb_loop;
	return 0;
}

// ------------------ Server 5 Breaker Open Command write thread -----------------------
//Note that since command is a single bit, you may need to use modbus coil to write single bit, depends upon server modbus implementation. Change below accordingly
void* mbsrvr5_brkop_wthread (void* args)
{
	int srvr5brkop_mbreg_wchk = 0;
	uint16_t srvr5_brkop_regval = 0;
	unsigned int srvr5_brkop_regaddr = 29;
	bool rly_brkop_bit = FALSE;
	unsigned int rly_brkop_plw = 0;
	int rc[5];


server5brkop_wmb_loop:
	//waiting for server 5 write command to be received from PL
	sem_wait(&srvr5_wcmd_brkopsem);

	pthread_mutex_lock(&srvr5_wsig_lck);//Locking to avoid race condition when one thread is trying to increment and other decrementing
	srvr5_wsig++;
	pthread_mutex_unlock(&srvr5_wsig_lck);

	//Relay Breaker open command from PL
	rly_brkop_bit 			= ((vadd_psddr[WCMD_PSDDR_OFFSET+12] & 0x00000001) > 0) ? 1 : 0; //this mapping needs to match with PL

	//*******************
	//here you can map commands received to specific MODBUS write registers for the device
	rly_brkop_plw = rly_brkop_bit;
	srvr5_brkop_regval = rly_brkop_plw;

	//**********************

	pthread_mutex_lock(&srvr5_rw);

	//since breaker open is a single bit, you may need to use modbus coil instead of modbus register, depends on implementation in relay modbus server, change accordingly
	//srvr5brkop_mbreg_wchk = modbus_write_and_read_registers(ctx_srvr5, srvr5_brkop_regaddr, 1, &srvr5_brkop_regval, SERVER5_START_RADDR, SERVER5_NREAD_REGS, server5_rregs);
	srvr5brkop_mbreg_wchk = modbus_write_bit (ctx_srvr5, srvr5_brkop_regaddr, srvr5_brkop_regval);

	rc[0] = modbus_read_registers(ctx_srvr5, 280, 98, server5_rregs_ptr);
	rc[1] = modbus_read_registers(ctx_srvr5, 434, 6, server5_rregs_ptr+98);
	rc[2] = modbus_read_registers(ctx_srvr5, 470, 2, server5_rregs_ptr+104);
	rc[3] = modbus_read_registers(ctx_srvr5, 1699, 1, server5_rregs_ptr+106);
	rc[4] = modbus_read_registers(ctx_srvr5, 182, 16, server5_rregs_ptr+107);


	pthread_mutex_unlock(&srvr5_rw);

	//sending signal to a waiting thread that read data has arrived
	sem_post(&srvr5_rdbk_sem);

	pthread_mutex_lock(&srvr5_wsig_lck);
	srvr5_wsig--;
	pthread_mutex_unlock(&srvr5_wsig_lck);

	if (srvr5_wsig==0) //condition tries to ensure that read thread is signaled only after for all write threads have finished processing
		sem_post(&srvr5_rw_sem);

    if ((srvr5brkop_mbreg_wchk == (-1)) || (rc[0] != 98) || (rc[1] != 6) || (rc[2] != 2) || (rc[3] != 1) || (rc[4] != 16))
    	printf("ERROR modbus_write_bit Server 5 Breaker Open Command Reset (%d)\n", srvr5brkop_mbreg_wchk);

	goto server5brkop_wmb_loop;
	return 0;
}

// ------------------ Server 5 Breaker Close Command write thread -----------------------
//Note that since command is a single bit, you may need to use modbus coil to write single bit, depends upon server modbus implementation. Change below accordingly
void* mbsrvr5_brkcl_wthread (void* args)
{
	int srvr5brkcl_mbreg_wchk = 0;
	uint16_t srvr5_brkcl_regval = 0;
	unsigned int srvr5_brkcl_regaddr = 30;
	_Bool rly_brkcl_bit = 0;
	unsigned int rly_brkcl_plw = 0;
	int rc[5];


server5brkcl_wmb_loop:
	//waiting for server 5 write command to be received from PL
	sem_wait(&srvr5_wcmd_brkclsem);

	pthread_mutex_lock(&srvr5_wsig_lck);//Locking to avoid race condition when one thread is trying to increment and other decrementing
	srvr5_wsig++;
	pthread_mutex_unlock(&srvr5_wsig_lck);

	//Relay Breaker close command from PL
	rly_brkcl_bit 			= ((vadd_psddr[WCMD_PSDDR_OFFSET+12] & 0x00000002) > 0) ? 1 : 0; //this mapping needs to match with PL

	//*******************
	//here you can map commands received to specific MODBUS write registers for the device
	rly_brkcl_plw = rly_brkcl_bit;
	srvr5_brkcl_regval = rly_brkcl_plw;

	//**********************

	pthread_mutex_lock(&srvr5_rw);

	//since breaker close is a single bit, you may need to use modbus coil instead of modbus register, depends on implementation in relay modbus server, change accordingly
	//srvr5brkcl_mbreg_wchk = modbus_write_and_read_registers(ctx_srvr5, srvr5_brkcl_regaddr, 1, &srvr5_brkcl_regval, SERVER5_START_RADDR, SERVER5_NREAD_REGS, server5_rregs);

	srvr5brkcl_mbreg_wchk = modbus_write_bit (ctx_srvr5, srvr5_brkcl_regaddr, srvr5_brkcl_regval);

	rc[0] = modbus_read_registers(ctx_srvr5, 280, 98, server5_rregs_ptr);
	rc[1] = modbus_read_registers(ctx_srvr5, 434, 6, server5_rregs_ptr+98);
	rc[2] = modbus_read_registers(ctx_srvr5, 470, 2, server5_rregs_ptr+104);
	rc[3] = modbus_read_registers(ctx_srvr5, 1699, 1, server5_rregs_ptr+106);
	rc[4] = modbus_read_registers(ctx_srvr5, 182, 16, server5_rregs_ptr+107);

	pthread_mutex_unlock(&srvr5_rw);

	//sending signal to a waiting thread that read data has arrived
	sem_post(&srvr5_rdbk_sem);

	pthread_mutex_lock(&srvr5_wsig_lck);
	srvr5_wsig--;
	pthread_mutex_unlock(&srvr5_wsig_lck);

	if (srvr5_wsig==0) //condition tries to ensure that read thread is signaled only after for all write threads have finished processing
		sem_post(&srvr5_rw_sem);

    if (srvr5brkcl_mbreg_wchk == (-1) || (rc[0] != 98) || (rc[1] != 6) || (rc[2] != 2) || (rc[3] != 1) || (rc[4] != 16))
    	printf("ERROR modbus_write_register Server 5 Breaker Close Command Reset (%d)\n", srvr5brkcl_mbreg_wchk);

	goto server5brkcl_wmb_loop;
	return 0;
}
