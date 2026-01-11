// *************************** MODBUS READ AND WRITE Code for Server 4 - Modify as required *********************************************************************

//------ Thread waiting for server 1 read data to arrive -------------------
void* mbsrvr4_rwait_thread (void* args)
{
	unsigned int gen_stat_r;
	unsigned int gen_flt_r;

	srvr4_rdbk_waitloop:

	//waiting for server 4 readback data to arrive
	sem_wait(&srvr4_rdbk_sem);

	//***********************************************************
	//here you can map modbus read register data to fpga msi interface signals for this server

	gen_stat_r			 	= server4_rregs[1]; //Note modbus server simulator sends upper 16bits first (so server4_rregs[1] contains value of  modbus reg0), update for specific modbus server
	gen_flt_r			 	= server4_rregs[0];

	//***********************************************************


	//--------------- Writing Data to PS DDR --------------------------------------------
	//Note below that relative location of each data wrt each other in PS DDR must match with data mapping in PL BRAM

	  //Genset status
	  vadd_psddr[SRVR4_READ_PSDDR_OFFSET] = gen_stat_r;

	  //Genset Fault
	  vadd_psddr[SRVR4_READ_PSDDR_OFFSET+1] = gen_flt_r;


	  //request CDMA transfer
	  reacquire_srvr4_rmutex:
	  pthread_mutex_lock(&mutex_cdma_trnsf);
	  if (cdma_trnsf_chk==TRUE)
	  {
		  pthread_mutex_unlock(&mutex_cdma_trnsf);
		  goto reacquire_srvr4_rmutex;
	  }
	  cdma_trnsf_chk = TRUE;

	//Requesting CDMA transfer
	cdma_src_addr = PSDDR_PBASE + (SRVR4_READ_PSDDR_OFFSET*0x4); //multiplying by 4 as this is byte level addressing
    cdma_dest_addr = BRAM_PBASE + (SRVR4_READ_BRAM_OFFSET*0x4);
    cdma_trnsf_length = 0x8; //32bit*2locations = 8bytes. Note Max space reserved is 32bit*40locations = 160bytes

	pthread_cond_signal(&cond_cdma_trnsf);
	pthread_mutex_unlock(&mutex_cdma_trnsf);

	//loop back to wait state.
	goto srvr4_rdbk_waitloop;

	return 0;
}

// ------------------ Server4 MODBUS polling thread -----------------------
void* mbsrvr4_thread (void* args)
{
	//Server 4 variable initialization
	int rc;
	int i;

	ctx_srvr4 = modbus_new_tcp(SERVER4_IP, SERVER4_MBPORT);
	modbus_set_debug(ctx_srvr4, SERVER4_DBG_MSG);

server4_mb_connec:
	if (modbus_connect(ctx_srvr4) == -1) {
		//fprintf(stderr, "Modbus Server 4 Connection Failed: %s : Retrying\n",
		//	   modbus_strerror(errno));
		//printf("Modbus Server 4 Connection Failed - Retrying\n");
		goto server4_mb_connec;
	}


server4_mb_read:
	if (srvr4_wsig!=0)
		sem_wait(&srvr4_rw_sem);

    pthread_mutex_lock(&srvr4_rw);
    /*reading multiple registers values*/
	rc = modbus_read_registers(ctx_srvr4, SERVER4_START_RADDR, SERVER4_NREAD_REGS, server4_rregs);
	pthread_mutex_unlock(&srvr4_rw);

	if (rc != SERVER4_NREAD_REGS)
	{
		printf("ERROR Reading Server 4 Registers - Re-establishing Connection\n");
		modbus_close(ctx_srvr4);
		goto server4_mb_connec;
	}

	//sending signal to a waiting thread that read data has arrived
	sem_post(&srvr4_rdbk_sem);

	goto server4_mb_read; //continuous read

	return 0;
}

// ------------------ Server4 (Genset) MODBUS write thread -----------------------

void* mbsrvr4_wthread (void* args)
{
	//Note Genset will be server 4
	uint64_t srvr4_run_wcmdchk; 		//check for start/stop command
	uint64_t srvr4_p_wcmdchk; 			//check for P setpoint
	uint64_t srvr4_q_wcmdchk;			//check for q setpoint
	uint64_t srvr4_opermode_wcmdchk;	//check for operating mode setpoint

server4_wmb_loop:
	//waiting for server 4 write command to be received from PL
	sem_wait(&srvr4_wcmd_sem);


	//signaling srvr4 modbus write thread if server4 command was sent from PL to PS
	srvr4_run_wcmdchk = mbsrvr_wcmd_stat & 0x800000; //bit 23 is for srvr4 Run cmd
	if (srvr4_run_wcmdchk>0)
	{
		sem_post(&srvr4_wcmd_runsem); //signaling server 4 modbus write thread for Run command
	}
	srvr4_p_wcmdchk = mbsrvr_wcmd_stat & 0x1000000; //bit 24 is for srvr4 P cmd
	if (srvr4_p_wcmdchk>0)
	{
		sem_post(&srvr4_wcmd_psem); //signaling server 4 modbus write thread for P command
	}
	srvr4_q_wcmdchk = mbsrvr_wcmd_stat & 0x2000000; //bit 25 is for srvr4 Q cmd
	if (srvr4_q_wcmdchk>0)
	{
		sem_post(&srvr4_wcmd_qsem); //signaling server 4 modbus write thread for Q command
	}
	srvr4_opermode_wcmdchk = mbsrvr_wcmd_stat & 0x4000000; //bit 26 is for srvr4 Operating Mode cmd
	if (srvr4_opermode_wcmdchk>0)
	{
		sem_post(&srvr4_wcmd_opermodesem); //signaling server 4 modbus write thread for Operating Mode command
	}
	goto server4_wmb_loop;
	return 0;
}

// ------------------ Server 4 P Command write thread -----------------------

void* mbsrvr4_p_wthread (void* args)
{
	int srvr4p_mbreg_wchk = 0;
	uint16_t srvr4_p_regval = 0;
	unsigned int srvr4_p_regaddr = 0;
	unsigned int gen_p_plw = 0;


server4p_wmb_loop:
	//waiting for server 4 write command to be received from PL
	sem_wait(&srvr4_wcmd_psem);

	pthread_mutex_lock(&srvr4_wsig_lck);//Locking to avoid race condition when one thread is trying to increment and other decrementing
	srvr4_wsig++;
	pthread_mutex_unlock(&srvr4_wsig_lck);

	//Genset P command from PL
	gen_p_plw 			= vadd_psddr[WCMD_PSDDR_OFFSET+10];

	//*******************
	//here you can map commands received to specific MODBUS write registers for the device
	srvr4_p_regval = gen_p_plw;
	//**********************

	pthread_mutex_lock(&srvr4_rw);

	//note that below assumes P write command to the server is only single register (16bit). If server has P mapped to 32bits, you will need to write to 2 registers and map gen_p_plw into an array of two locations with 16bit each before passing to modbus function
	srvr4p_mbreg_wchk = modbus_write_and_read_registers(ctx_srvr4, srvr4_p_regaddr, 1, &srvr4_p_regval, SERVER4_START_RADDR, SERVER4_NREAD_REGS, server4_rregs);

	pthread_mutex_unlock(&srvr4_rw);

	//sending signal to a waiting thread that read data has arrived
	sem_post(&srvr4_rdbk_sem);

	pthread_mutex_lock(&srvr4_wsig_lck);
	srvr4_wsig--;
	pthread_mutex_unlock(&srvr4_wsig_lck);

	if (srvr4_wsig==0) //condition tries to ensure that read thread is signaled only after for all write threads have finished processing
		sem_post(&srvr4_rw_sem);

    if (srvr4p_mbreg_wchk == (-1))
    	printf("ERROR modbus_write_register Server 4 P (%d)\n", srvr4p_mbreg_wchk);

	goto server4p_wmb_loop;
	return 0;
}

// ------------------ Server 4 Q Command write thread -----------------------

void* mbsrvr4_q_wthread (void* args)
{
	int srvr4q_mbreg_wchk = 0;
	uint16_t srvr4_q_regval = 0;
	unsigned int srvr4_q_regaddr = 1;
	unsigned int gen_q_plw = 0;


server4q_wmb_loop:
	//waiting for server 4 write command to be received from PL
	sem_wait(&srvr4_wcmd_qsem);

	pthread_mutex_lock(&srvr4_wsig_lck);//Locking to avoid race condition when one thread is trying to increment and other decrementing
	srvr4_wsig++;
	pthread_mutex_unlock(&srvr4_wsig_lck);

	//Genset Q command from PL
	gen_q_plw 			= vadd_psddr[WCMD_PSDDR_OFFSET+11];

	//*******************
	//here you can map commands received to specific MODBUS write registers for the device
	srvr4_q_regval = gen_q_plw;
	//**********************

	pthread_mutex_lock(&srvr4_rw);

	//note that below assumes Q write command to the server is only single register (16bit). If server has Q mapped to 32bits, you will need to write to 2 registers and map gen_p_plw into an array of two locations with 16bit each before passing to modbus function
	srvr4q_mbreg_wchk = modbus_write_and_read_registers(ctx_srvr4, srvr4_q_regaddr, 1, &srvr4_q_regval, SERVER4_START_RADDR, SERVER4_NREAD_REGS, server4_rregs);

	pthread_mutex_unlock(&srvr4_rw);

	//sending signal to a waiting thread that read data has arrived
	sem_post(&srvr4_rdbk_sem);

	pthread_mutex_lock(&srvr4_wsig_lck);
	srvr4_wsig--;
	pthread_mutex_unlock(&srvr4_wsig_lck);

	if (srvr4_wsig==0) //condition tries to ensure that read thread is signaled only after for all write threads have finished processing
		sem_post(&srvr4_rw_sem);

    if (srvr4q_mbreg_wchk == (-1))
    	printf("ERROR modbus_write_register Server 4 Q (%d)\n", srvr4q_mbreg_wchk);

	goto server4q_wmb_loop;
	return 0;
}

// ------------------ Server4 RUN Command write thread -----------------------

void* mbsrvr4_run_wthread (void* args)
{
	int srvr4run_mbreg_wchk = 0;
	uint16_t srvr4_run_regval = 0;
	unsigned int srvr4_run_regaddr = 0;

server4run_wmb_loop:
	//waiting for server 4 write command to be received from PL
	sem_wait(&srvr4_wcmd_runsem);

	pthread_mutex_lock(&srvr4_wsig_lck);
	srvr4_wsig++;
	pthread_mutex_unlock(&srvr4_wsig_lck);

	//***here you can map commands received into PS DDR to specific MODBUS write registers for the device***
	pthread_mutex_lock(&srvr4_rw);
	srvr4run_mbreg_wchk = modbus_write_and_read_registers(ctx_srvr4, srvr4_run_regaddr, 1, &srvr4_run_regval, SERVER4_START_RADDR, SERVER4_NREAD_REGS, server4_rregs);
	pthread_mutex_unlock(&srvr4_rw);

	//sending signal to a waiting thread that read data has arrived
	sem_post(&srvr4_rdbk_sem);

	pthread_mutex_lock(&srvr4_wsig_lck);
	srvr4_wsig--;
	pthread_mutex_unlock(&srvr4_wsig_lck);

	if (srvr4_wsig==0)
		sem_post(&srvr4_rw_sem);

    if (srvr4run_mbreg_wchk == (-1))
    	printf("ERROR modbus_write_register Server 4 Run (%d)\n", srvr4run_mbreg_wchk);

	goto server4run_wmb_loop;
	return 0;
}

// ------------------ Server4 Operating Mode Command write thread -----------------------

void* mbsrvr4_opermode_wthread (void* args)
{
	int srvr4opermode_mbreg_wchk = 0;
	uint16_t srvr4_opermode_regval = 0;
	unsigned int srvr4_opermode_regaddr = 0;

server4opermode_wmb_loop:
	//waiting for server 4 write command to be received from PL
	sem_wait(&srvr4_wcmd_opermodesem);

	pthread_mutex_lock(&srvr4_wsig_lck);
	srvr4_wsig++;
	pthread_mutex_unlock(&srvr4_wsig_lck);

	//***here you can map commands received into PS DDR to specific MODBUS write registers for the device***
	pthread_mutex_lock(&srvr4_rw);
	srvr4opermode_mbreg_wchk = modbus_write_and_read_registers(ctx_srvr4, srvr4_opermode_regaddr, 1, &srvr4_opermode_regval, SERVER4_START_RADDR, SERVER4_NREAD_REGS, server4_rregs);
	pthread_mutex_unlock(&srvr4_rw);

	//sending signal to a waiting thread that read data has arrived
	sem_post(&srvr4_rdbk_sem);

	pthread_mutex_lock(&srvr4_wsig_lck);
	srvr4_wsig--;
	pthread_mutex_unlock(&srvr4_wsig_lck);

	if (srvr4_wsig==0)
		sem_post(&srvr4_rw_sem);

    if (srvr4opermode_mbreg_wchk == (-1))
    	printf("ERROR modbus_write_register Server 4 Operating Mode (%d)\n", srvr4opermode_mbreg_wchk);

	goto server4opermode_wmb_loop;
	return 0;
}




