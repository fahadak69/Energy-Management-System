// *************************** MODBUS READ AND WRITE Code for Server 1 - Modify as required *********************************************************************

//------ Thread waiting for server 1 read data to arrive -------------------
void* mbsrvr1_rwait_thread (void* args)
{
	unsigned int bess_stat_islnd_flt_r;
	unsigned int bess_soc_r;
	unsigned int bess_wh_r;
	unsigned int bess_wh_max_r;
	unsigned int bess_maxdschgpwr_r;
	unsigned int bess_maxchgpwr_r;

	float 		bess_wh_fltr;
	float 		bess_wh_max_fltr;
	float 		 bess_soc_flt;

	float bess_maxdschgpwr_r_flt;
	float bess_maxchgpwr_r_flt;
	float bess_wh_r_flt;
	float bess_wh_max_r_flt;

	//*******Shared memory and file lock creation for sharing BESS Wh with Python BESS Dispatch Optimz code***********
	#define SHM_SIZE sizeof(unsigned int)  // Size of an integer (4 bytes)
	#define LOCK_FILE "/usr/my_lock" //this path needs to match lock file path in Python BESS dispatch code

    // Open a file for reading and writing (create if it doesn't exist)
	int shm_fd = open("/usr/bess_opt_schd", O_RDWR | O_CREAT, 0666); //#this path needs to match shared memory object path in Python BESS dispatch code
    if (shm_fd == -1) {
        perror("open: Shared Memory BESS Wh");
        return EXIT_FAILURE;
    }
    // Ensure the file is the correct size
    if (ftruncate(shm_fd, SHM_SIZE) == -1) {
        perror("ftruncate: File Lock BESS Wh");
        close(shm_fd);
        return EXIT_FAILURE;
    }

    // Map the file into memory
    unsigned int *shm = mmap(NULL, SHM_SIZE, PROT_READ | PROT_WRITE, MAP_SHARED, shm_fd, 0);
    if (shm == MAP_FAILED) {
        perror("mmap: Shared Memory BESS Wh");
        close(shm_fd);
        return EXIT_FAILURE;
    }

    // Open the lock file
    int lock_fd = open(LOCK_FILE, O_CREAT | O_RDWR, 0666);
    if (lock_fd == -1) {
        perror("open lock file: File Lock BESS Wh");
        munmap(shm, SHM_SIZE);
        close(shm_fd);
        return EXIT_FAILURE;
    }
    //********************************************************************************

	srvr1_rdbk_waitloop:
//	sem_getvalue(&srvr1_rdbk_sem, &test_value);
//	printf ("Sem Value Before is %d\n",test_value);

	//waiting for server 1 readback data to arrive
	sem_wait(&srvr1_rdbk_sem);

	//***********************************************************
	//here you can map modbus read register data to fpga msi interface signals for this server


#ifdef EIT_TESLA_MEGAPACK

	bess_stat_islnd_flt_r 	= 0;

	//HIL Tesla Megapack Server: 20109/2010
	bess_wh_max_r_flt 			= combineRegistersToFloat(server1_rregs_ptr);
	bess_wh_max_r   			= bess_wh_max_r_flt;
	//printf("BESS - Max Available Energy %d Wh\n",bess_wh_max_r);

	//HIL Tesla Megapack Server: 25003/25004
	bess_wh_r_flt 			= combineRegistersToFloat(server1_rregs_ptr+2);
	bess_wh_r 				= bess_wh_r_flt;
	//printf("BESS - Available Energy %d Wh\n",bess_wh_r);

	//Note that SoC change is very slow so the latency added by this multiplication in PS domain wouldnt matter much. Also it will add latency to other BESS readback data as well but all those variables
	//also change very slow so again it doesnt matter much
	bess_wh_max_fltr		= bess_wh_max_r;
	bess_wh_fltr			= bess_wh_r;
	bess_soc_flt			= 100 * (bess_wh_fltr/bess_wh_max_fltr);
	bess_soc_r				= bess_soc_flt;
	//printf("BESS - SoE %d \n",bess_soc_r);

	//HIL Tesla Megapack Server: 25005/25006
	bess_maxchgpwr_r_flt 		= combineRegistersToFloat(server1_rregs_ptr+4);
	bess_maxchgpwr_r   			= (bess_maxchgpwr_r_flt*(-1)); //flipping -ve sign coming from server before converting to uint
	//printf("BESS - Max Charge Power %d Watt\n",bess_maxchgpwr_r);

	//HIL Tesla Megapack Server: 25007/25008
	bess_maxdschgpwr_r_flt 		= combineRegistersToFloat(server1_rregs_ptr+6);
	bess_maxdschgpwr_r 			= bess_maxdschgpwr_r_flt;
	//printf("BESS - Max Discharge Power %d Watt\n",bess_maxdschgpwr_r);

#elif defined(STCH_MG_ACTUAL) || defined (STCH_MG_ACTUAL_EIT_HIL_HYBRID)

	bess_stat_islnd_flt_r 	= 0;//not available over PLC

	//STCH MG PLC Server: 6120/6121
	bess_wh_max_r 				= (*(server1_rregs_ptr+4)) << 16;
	bess_wh_max_r   			= bess_wh_max_r | (*(server1_rregs_ptr+3));
	bess_wh_max_r				= bess_wh_max_r *10;
	//printf("BESS - Max Available Energy %d Wh\n",bess_wh_max_r);

	//STCH MG PLC Server: 6122/6123
	bess_wh_r 				= (*(server1_rregs_ptr+6)) << 16;
	bess_wh_r   			= bess_wh_r | (*(server1_rregs_ptr+5));
	bess_wh_r				= bess_wh_r * 10;
	//printf("BESS - Available Energy %d Wh\n",bess_wh_r);

	//Note that SoC change is very slow so the latency added by this multiplication in PS domain wouldnt matter much. Also it will add latency to other BESS readback data as well but all those variables
	//also change very slow so again it doesnt matter much
	bess_wh_max_fltr		= bess_wh_max_r;
	bess_wh_fltr			= bess_wh_r;
	bess_soc_flt			= 100 * (bess_wh_fltr/bess_wh_max_fltr);
	bess_soc_r				= bess_soc_flt;
	//printf("BESS - SoE %d \n",bess_soc_r);

	//STCH MG PLC Server: 6118
	bess_maxdschgpwr_r 		= (*(server1_rregs_ptr+1));
	bess_maxdschgpwr_r		= bess_maxdschgpwr_r * 10;
	//printf("BESS - Max Discharge Power %d Watt\n",bess_maxdschgpwr_r);

	//STCH MG PLC Server: 6117
	bess_maxchgpwr_r 		= (*(server1_rregs_ptr));
	bess_maxchgpwr_r		= bess_maxchgpwr_r * 10;
	//printf("BESS - Max Charge Power %d Watt\n",bess_maxchgpwr_r);

#else //for STCH_MG_HIL, reading directly from Tesla model
	//STCH MG : 2501/2502
	//assumption here is that server has each parameter contained in a 32bit register. This can vary from server to server, so update accordingly
	bess_stat_islnd_flt_r 	= (*(server1_rregs_ptr+21)) << 16;
	bess_stat_islnd_flt_r   = bess_stat_islnd_flt_r | (*(server1_rregs_ptr+22));
	//printf("BESS - Loss of Meter Comms %d \n",(*(server1_rregs_ptr+21)));
	//printf("BESS - Fault %d \n",(*(server1_rregs_ptr+22)));

	//STCH MG : 205/206
	bess_wh_max_r 				= (*(server1_rregs_ptr+5)) << 16;
	bess_wh_max_r   			= bess_wh_max_r | (*(server1_rregs_ptr+6));
	//printf("BESS - Max Available Energy %d Wh\n",bess_wh_max_r);

	//STCH MG : 209/210
	bess_wh_r 				= (*(server1_rregs_ptr+9)) << 16;
	bess_wh_r   			= bess_wh_r | (*(server1_rregs_ptr+10));
	//printf("BESS - Available Energy %d Wh\n",bess_wh_r);

	//Note that SoC change is very slow so the latency added by this multiplication in PS domain wouldnt matter much. Also it will add latency to other BESS readback data as well but all those variables
	//also change very slow so again it doesnt matter much
	bess_wh_max_fltr		= bess_wh_max_r;
	bess_wh_fltr			= bess_wh_r;
	bess_soc_flt			= 100 * (bess_wh_fltr/bess_wh_max_fltr);
	bess_soc_r				= bess_soc_flt;
	//printf("BESS - SoE %d \n",bess_soc_r);

	//STCH MG: 213/214
	bess_maxdschgpwr_r 		= (*(server1_rregs_ptr+13)) << 16;
	bess_maxdschgpwr_r   	= bess_maxdschgpwr_r | (*(server1_rregs_ptr+14));
	//printf("BESS - Max Discharge Power %d Watt\n",bess_maxdschgpwr_r);

	//STCH MG : 211/212
	bess_maxchgpwr_r 		= (*(server1_rregs_ptr+11)) << 16;
	bess_maxchgpwr_r   		= bess_maxchgpwr_r | (*(server1_rregs_ptr+12));
	//printf("BESS - Max Charge Power %d Watt\n",bess_maxchgpwr_r);
#endif
	//***********************************************************

	//Sending Wh to Python BESS Dispatch Optimization Code
    // Lock the file
    struct flock lock;
    lock.l_type = F_WRLCK;
    lock.l_whence = SEEK_SET;
    lock.l_start = 0;
    lock.l_len = 0;
    fcntl(lock_fd, F_SETLKW, &lock);
    // Write an integer to the shared memory
    *shm = bess_wh_r;
    // Unlock the file
    lock.l_type = F_UNLCK;
    fcntl(lock_fd, F_SETLK, &lock);


	//--------------- Writing Data to PS DDR --------------------------------------------
	//Note below that relative location of each bess data wrt each other in PS DDR must match with bess data mapping in PL BRAM

	  //BESS status/island/fault read data
	  vadd_psddr[SRVR1_READ_PSDDR_OFFSET] = bess_stat_islnd_flt_r;

	  //BESS SoC
	  vadd_psddr[SRVR1_READ_PSDDR_OFFSET+1] = bess_soc_r;

	  //BESS max available discharge power
	  vadd_psddr[SRVR1_READ_PSDDR_OFFSET+2] = bess_maxdschgpwr_r;

	  //BESS max available charge power
	  vadd_psddr[SRVR1_READ_PSDDR_OFFSET+3] = bess_maxchgpwr_r;

	  //BESS Wh @ BESS SoC
	  vadd_psddr[SRVR1_READ_PSDDR_OFFSET+4] = bess_wh_r;


	  //request CDMA transfer : Note that if condition on mutex is necessary because when mutex is unlocked by this thread after signaling cond variable, another thread waiting on
	  //						same mutex (such as srvr 3) can immediately acquire it even before cpu reaches to cond_wait in cdma code. In such a case, cdma src/dest address will be
	  //						changed by that 2nd thread (srvr3 for example)
	  reacquire_srvr1_rmutex:
	  pthread_mutex_lock(&mutex_cdma_trnsf);
	  if (cdma_trnsf_chk==TRUE)
	  {
		  pthread_mutex_unlock(&mutex_cdma_trnsf);
		  goto reacquire_srvr1_rmutex;
	  }
	  cdma_trnsf_chk = TRUE;

	//Requesting CDMA transfer
	cdma_src_addr = PSDDR_PBASE + (SRVR1_READ_PSDDR_OFFSET*0x4); //multiplying by 4 as this is byte level addressing
    cdma_dest_addr = BRAM_PBASE + (SRVR1_READ_BRAM_OFFSET*0x4);
    cdma_trnsf_length = 0x10; //32bit*4locations = 16bytes. Note Max space reserved is 32bit*40locations = 160bytes

	pthread_cond_signal(&cond_cdma_trnsf);
	pthread_mutex_unlock(&mutex_cdma_trnsf);

#ifdef ENABLE_ADER_PILOT
	atomic_store(&atomic_bess_maxdschgpwr, bess_maxdschgpwr_r); //atomic operation to synchronize between read and write across different threads
	atomic_store(&atomic_bess_maxchgpwr, bess_maxchgpwr_r);
	atomic_store(&atomic_bess_socr, bess_soc_r);
#endif

	//loop back to wait state.
	goto srvr1_rdbk_waitloop;

    // Cleanup
    munmap(shm, SHM_SIZE);
    close(shm_fd);
    close(lock_fd);

	return 0;
}

// ------------------ Server1 MODBUS polling thread -----------------------
//This thread is not created if STCH_MG_ACTUAL or STCH_MG_ACTUAL_EIT_HIL_HYBRID is defined

void* mbsrvr1_thread (void* args)
{
	//Server 1 variable initialization
	int rc;
	int rc2;
	int rc_w;
	int srvr1hb_mbreg_wchk = 0; //heartbeat write check
	uint32_t srvr1_hb_regval = 1;//random initial value for heartbeat
	uint16_t srvr1_hb_reg16b[2];
	FloatUnion heartbeat;
	float  heartbeat_flt =0;

	ctx_srvr1 = modbus_new_tcp(SERVER1_IP, SERVER1_MBPORT);
	modbus_set_debug(ctx_srvr1, SERVER1_DBG_MSG);

server1_mb_connec:
	if (modbus_connect(ctx_srvr1) == -1) {
		//fprintf(stderr, "Modbus Server 1 Connection Failed: %s : Retrying\n",
		//	   modbus_strerror(errno));
		printf("Modbus Server 1 Connection Failed - Retrying\n");
		goto server1_mb_connec;
	}


//	/* --- Code for checking thread priority ------------- */
//	 int ret;
//	 pthread_t this_thread = pthread_self();
//	 struct sched_param params;
//	 int policy = 0;
//
//	 ret = pthread_getschedparam(this_thread, &policy, &params);
//	 if(policy != SCHED_FIFO)
//		 printf ("Not Fifo for Server 1 Read Thread\n");
//	 printf ("Server 1 Read Thread Schedule Priority %d\n",params.sched_priority);
//
//	/* --------------------------------------------------- */


server1_mb_read:

	if (srvr1_wsig!=0)//if any of the server 1 write thread is triggered, forcing this read thread to wait for that thread to finish. Otherwise,
					  //CPU keeps prioritizing read thread and it takes many seconds for write thread to execute. I even tried setting schedule priority for write thread higher (see commented out section in p write thread),
					  //but it makes only small difference. Schedule priority should work (thats what its meant for) so do more research later to make it work, its better way to achieve priority than sem_wait
		sem_wait(&srvr1_rw_sem);

    pthread_mutex_lock(&srvr1_rw); //locking mutex to prevent read and write threads from trying to access modbus server 1 on same port simultaneously, otherwise it starts returning -1
    /*reading multiple registers values*/

#ifdef EIT_TESLA_MEGAPACK

	if (srvr1_hb_regval>65536)//can be any value as long as it fits in heartbeat register(s)
		srvr1_hb_regval 	= 1;
	else
		srvr1_hb_regval 	= srvr1_hb_regval >> 2; //just need to change value everytime, so any operation is ok, doing x2 as its less computationally intensive

	heartbeat_flt = (float)srvr1_hb_regval;
	heartbeat.value = heartbeat_flt;

    srvr1_hb_reg16b[0] = heartbeat.bits>>16;
    srvr1_hb_reg16b[1] = heartbeat.bits;
    rc_w = modbus_write_registers(ctx_srvr1, 20306, 2, srvr1_hb_reg16b);//writing heartbeat

    rc = modbus_read_registers(ctx_srvr1, 20109, 2, server1_rregs_ptr);
	//server1_rregs_ptr += 21;
	rc2 = modbus_read_registers(ctx_srvr1, 25003, 6, (server1_rregs_ptr+2));
	pthread_mutex_unlock(&srvr1_rw);

	if ((rc != 2)|| (rc2 != 6))
	{
		printf("ERROR Reading Server 1 Registers Re-establishing Connection\n");
		modbus_close(ctx_srvr1);
		goto server1_mb_connec;
	}
	else if (rc_w==(-1))
	{
		printf("ERROR Writing Server 1 Heartbeat Registers Re-establishing Connection\n");
		modbus_close(ctx_srvr1);
		goto server1_mb_connec;
	}

#else //this is for STCH_MG_HIL case
    rc = modbus_read_registers(ctx_srvr1, 200, 21, server1_rregs_ptr);
	//server1_rregs_ptr += 21;
	rc2 = modbus_read_registers(ctx_srvr1, 2501, 2, (server1_rregs_ptr+21));
	pthread_mutex_unlock(&srvr1_rw);

	if ((rc != 21)|| (rc2 != 2))
	{
		printf("ERROR Reading Server 1 Registers - Re-establishing Connection\n");
		modbus_close(ctx_srvr1);
		goto server1_mb_connec;
	}
#endif

	//sending signal to a waiting thread that read data has arrived
	sem_post(&srvr1_rdbk_sem);

	/*to print multiple read register values*/
//	for (i=0; i<SERVER1_NREAD_REGS; i++)
//		printf("The %d register value is %d\n", i, server1_rregs[i]);

	goto server1_mb_read; //continuous read

	return 0;
}

// ------------------ Server1 (BESS) MODBUS write thread -----------------------

void* mbsrvr1_wthread (void* args)
{
	//Note BESS will be server 1
	uint64_t srvr1_run_wcmdchk; 		//check for start/stop command
	uint64_t srvr1_p_wcmdchk; 			//check for P setpoint
	uint64_t srvr1_q_wcmdchk;			//check for q setpoint
	uint64_t srvr1_pf_wcmdchk;			//check for power factor setpoint
	uint64_t srvr1_qtyp_wcmdchk;		//check for var type setting
	uint64_t srvr1_island_wcmdchk;		//check for island (grid forming) command
	uint64_t srvr1_islndfrq_wcmdchk;	//check for island freq reference command
	uint64_t srvr1_islndvlt_wcmdchk;	//check for island volt reference command

server1_wmb_loop:
	//waiting for server 1 write command to be received from PL
	sem_wait(&srvr1_wcmd_sem);

	//signaling srvr1 modbus write thread if server1 command was sent from PL to PS
	srvr1_run_wcmdchk = mbsrvr_wcmd_stat & 0x400; //bit 10 is for srvr1 run cmd
	if (srvr1_run_wcmdchk>0)
	{
		sem_post(&srvr1_wcmd_runsem);

	}
	srvr1_p_wcmdchk = mbsrvr_wcmd_stat & 0x800; //bit 11 is for srvr1 P cmd
	if (srvr1_p_wcmdchk>0)//see Note 1 on userparam_thread.h
	{
		pl_besssp_flg = (usr_ctrl_mode==3); //see Note 2 on stchmg_plcsrvr_thread.h
		#if defined(STCH_MG_HIL) || defined(STCH_MG_ACTUAL) || defined (STCH_MG_ACTUAL_EIT_HIL_HYBRID)
		sem_post(&stchmgplc_tesla_psem);
		#else
		sem_post(&srvr1_wcmd_psem); //signaling server 1 modbus write thread for P command
		#endif
	}
	srvr1_q_wcmdchk = mbsrvr_wcmd_stat & 0x1000; //bit 12 is for srvr1 Q cmd
	if (srvr1_q_wcmdchk>0)
	{
		sem_post(&srvr1_wcmd_qsem);
	}
	srvr1_pf_wcmdchk = mbsrvr_wcmd_stat & 0x2000; //bit 13 is for srvr1 PF cmd
	if (srvr1_pf_wcmdchk>0)
	{
		sem_post(&srvr1_wcmd_pfsem);
	}
	srvr1_qtyp_wcmdchk = mbsrvr_wcmd_stat & 0x4000; //bit 14 is for srvr1 Q type cmd
	if (srvr1_qtyp_wcmdchk>0)
	{
		sem_post(&srvr1_wcmd_qtypsem);
	}
	srvr1_island_wcmdchk = mbsrvr_wcmd_stat & 0x8000; //bit 15 is for srvr1 island cmd
	if (srvr1_island_wcmdchk>0)
	{
		sem_post(&srvr1_wcmd_islandsem);
	}
	srvr1_islndfrq_wcmdchk = mbsrvr_wcmd_stat & 0x10000; //bit 16 is for srvr1 island freq cmd
	if (srvr1_islndfrq_wcmdchk>0)
	{
		sem_post(&srvr1_wcmd_islndfrqsem);
	}
	srvr1_islndvlt_wcmdchk = mbsrvr_wcmd_stat & 0x20000; //bit 17 is for srvr1 island volt cmd
	if (srvr1_islndvlt_wcmdchk>0)
	{
		sem_post(&srvr1_wcmd_islndvltsem);

	}


	goto server1_wmb_loop;
	return 0;
}

// ------------------ Server1 P Command write thread -----------------------

void* mbsrvr1_p_wthread (void* args)
{
	int srvr1p_mbreg_wchk = 0;
	uint16_t srvr1_p_regval[2];
	unsigned int srvr1_p_regaddr = 1020;
	unsigned int bess_p_plw = 0;
	int rc[2];
	int bess_p_int = 0;
	float bess_p_flt = 0;
	FloatUnion bess_p;

	/* --- Code for setting thread priority ------------- */
//	 int ret;
//	 pthread_t this_thread = pthread_self();
//	 struct sched_param params;
//	 int policy = 0;

//	 ret = pthread_getschedparam(this_thread, &policy, &params);
//	 if(policy != SCHED_FIFO)
//		 printf ("Not Fifo for Server 1 P Thread\n");
//	 printf ("Server 1 P Thread Policy %d\n",params.sched_priority);

//	 params.sched_priority = sched_get_priority_max(SCHED_FIFO);
//     ret = pthread_setschedparam(this_thread, SCHED_FIFO, &params);
//     if (ret != 0)
//         printf ("Unsuccessful in setting Server 1 P Write Thread Priority Realtime\n");

	/* ----------------------------------------------------- */

server1p_wmb_loop:
	//waiting for server 1 write command to be received from PL
	sem_wait(&srvr1_wcmd_psem);

	pthread_mutex_lock(&srvr1_wsig_lck);//Locking to avoid race condition when one thread is trying to increment and other decrementing
	srvr1_wsig++;
	pthread_mutex_unlock(&srvr1_wsig_lck);

	//BESS P command from PL
	bess_p_plw 			= vadd_psddr[WCMD_PSDDR_OFFSET+1];


	//*******************
	//here you can map commands received to specific MODBUS write registers for the device
#ifdef EIT_TESLA_MEGAPACK
	bess_p_int = (int)bess_p_plw;
	bess_p_flt = bess_p_int;
	bess_p.value = bess_p_flt;

	srvr1_p_regval[0] 	= bess_p.bits>>16;
	srvr1_p_regval[1] 	= bess_p.bits;
#else
	bess_p_plw			= (bess_p_plw/100); //Changing to kW with x10 scaling (10/1000)
	srvr1_p_regval[0] 	= bess_p_plw;
#endif
	//**********************

	pthread_mutex_lock(&srvr1_rw);
#ifdef EIT_TESLA_MEGAPACK
	srvr1p_mbreg_wchk = modbus_write_registers(ctx_srvr1, 20201, 2, srvr1_p_regval);
    rc[0] = modbus_read_registers(ctx_srvr1, 20109, 2, server1_rregs_ptr);
    rc[1] = modbus_read_registers(ctx_srvr1, 25003, 6, (server1_rregs_ptr+2));
#else
	srvr1p_mbreg_wchk = modbus_write_registers(ctx_srvr1, srvr1_p_regaddr, 1, srvr1_p_regval);
	//srvr1p_mbreg_wchk = modbus_write_and_read_registers(ctx_srvr1, srvr1_p_regaddr, 2, srvr1_p_regval, 200, 21, server1_rregs_ptr);
    rc[0] = modbus_read_registers(ctx_srvr1, 200, 21, server1_rregs_ptr);
    rc[1] = modbus_read_registers(ctx_srvr1, 2501, 2, (server1_rregs_ptr+21));
#endif
	pthread_mutex_unlock(&srvr1_rw);

	pthread_mutex_lock(&srvr1_wsig_lck);
	srvr1_wsig--;
	pthread_mutex_unlock(&srvr1_wsig_lck);

	if (srvr1_wsig==0) //condition tries to ensure that read thread is signaled only after for all write threads have finished processing
		sem_post(&srvr1_rw_sem);

#ifdef EIT_TESLA_MEGAPACK
    if ((srvr1p_mbreg_wchk == (-1)) || (rc[0] != 2) || (rc[1] != 6))
    	printf("ERROR modbus_write_read_register Server 1 P (%d) (%d) (%d)\n", srvr1p_mbreg_wchk, rc[0], rc[1]);
#else
    if ((srvr1p_mbreg_wchk == (-1)) || (rc[0] != 21) || (rc[1] != 2))
    	printf("ERROR modbus_write_read_register Server 1 P (%d) (%d) (%d)\n", srvr1p_mbreg_wchk, rc[0], rc[1]);
#endif

	//sending signal to a waiting thread that read data has arrived
	sem_post(&srvr1_rdbk_sem);

	goto server1p_wmb_loop;
	return 0;
}

// ------------------ Server1 Q Command write thread -----------------------

void* mbsrvr1_q_wthread (void* args)
{
	int srvr1q_mbreg_wchk = 0;
	uint16_t srvr1_q_regval = 0;
	unsigned int srvr1_q_regaddr = 1;

server1q_wmb_loop:
	//waiting for server 1 write command to be received from PL
	sem_wait(&srvr1_wcmd_qsem);

	pthread_mutex_lock(&srvr1_wsig_lck);
	srvr1_wsig++;
	pthread_mutex_unlock(&srvr1_wsig_lck);

	//***here you can map commands received into PS DDR to specific MODBUS write registers for the device***

	pthread_mutex_lock(&srvr1_rw);
	//srvr1q_mbreg_wchk = modbus_write_register(ctx_srvr1, srvr1_q_regaddr, tmp_q_var/*srvr1_q_regval*/);
	srvr1q_mbreg_wchk = modbus_write_and_read_registers(ctx_srvr1, srvr1_q_regaddr, 1, &srvr1_q_regval, SERVER1_START_RADDR, SERVER1_NREAD_REGS, server1_rregs);
	pthread_mutex_unlock(&srvr1_rw);

	//sending signal to a waiting thread that read data has arrived
	sem_post(&srvr1_rdbk_sem);

	pthread_mutex_lock(&srvr1_wsig_lck);
	srvr1_wsig--;
	pthread_mutex_unlock(&srvr1_wsig_lck);

	if (srvr1_wsig==0)
		sem_post(&srvr1_rw_sem);

    if (srvr1q_mbreg_wchk == (-1))
    	printf("ERROR modbus_write_register Server 1 Q (%d)\n", srvr1q_mbreg_wchk);

	goto server1q_wmb_loop;
	return 0;
}

// ------------------ Server1 RUN Command write thread -----------------------

void* mbsrvr1_run_wthread (void* args)
{
	int srvr1run_mbreg_wchk = 0;
	uint16_t srvr1_run_regval = 0;
	unsigned int srvr1_run_regaddr = 0;

server1run_wmb_loop:
	//waiting for server 1 write command to be received from PL
	sem_wait(&srvr1_wcmd_runsem);

	pthread_mutex_lock(&srvr1_wsig_lck);
	srvr1_wsig++;
	pthread_mutex_unlock(&srvr1_wsig_lck);

	//***here you can map commands received into PS DDR to specific MODBUS write registers for the device***
	pthread_mutex_lock(&srvr1_rw);
	//srvr1run_mbreg_wchk = modbus_write_register(ctx_srvr1, srvr1_run_regaddr, srvr1_run_regval);
	srvr1run_mbreg_wchk = modbus_write_and_read_registers(ctx_srvr1, srvr1_run_regaddr, 1, &srvr1_run_regval, SERVER1_START_RADDR, SERVER1_NREAD_REGS, server1_rregs);
	pthread_mutex_unlock(&srvr1_rw);

	//sending signal to a waiting thread that read data has arrived
	sem_post(&srvr1_rdbk_sem);

	pthread_mutex_lock(&srvr1_wsig_lck);
	srvr1_wsig--;
	pthread_mutex_unlock(&srvr1_wsig_lck);

	if (srvr1_wsig==0)
		sem_post(&srvr1_rw_sem);

    if (srvr1run_mbreg_wchk == (-1))
    	printf("ERROR modbus_write_register Server 1 Run (%d)\n", srvr1run_mbreg_wchk);

	goto server1run_wmb_loop;
	return 0;
}

// ------------------ Server1 PF Command write thread -----------------------

void* mbsrvr1_pf_wthread (void* args)
{
	int srvr1pf_mbreg_wchk = 0;
	uint16_t srvr1_pf_regval = 0;
	unsigned int srvr1_pf_regaddr = 0;

server1pf_wmb_loop:
	//waiting for server 1 write command to be received from PL
	sem_wait(&srvr1_wcmd_pfsem);

	pthread_mutex_lock(&srvr1_wsig_lck);
	srvr1_wsig++;
	pthread_mutex_unlock(&srvr1_wsig_lck);

	//***here you can map commands received into PS DDR to specific MODBUS write registers for the device***
	pthread_mutex_lock(&srvr1_rw);
	//srvr1pf_mbreg_wchk = modbus_write_register(ctx_srvr1, srvr1_pf_regaddr, srvr1_pf_regval);
	srvr1pf_mbreg_wchk = modbus_write_and_read_registers(ctx_srvr1, srvr1_pf_regaddr, 1, &srvr1_pf_regval, SERVER1_START_RADDR, SERVER1_NREAD_REGS, server1_rregs);
	pthread_mutex_unlock(&srvr1_rw);

	//sending signal to a waiting thread that read data has arrived
	sem_post(&srvr1_rdbk_sem);

	pthread_mutex_lock(&srvr1_wsig_lck);
	srvr1_wsig--;
	pthread_mutex_unlock(&srvr1_wsig_lck);

	if (srvr1_wsig==0)
		sem_post(&srvr1_rw_sem);

    if (srvr1pf_mbreg_wchk == (-1))
    	printf("ERROR modbus_write_register Server 1 PF (%d)\n", srvr1pf_mbreg_wchk);

	goto server1pf_wmb_loop;
	return 0;
}

// ------------------ Server1 Qtyp Command write thread -----------------------

void* mbsrvr1_qtyp_wthread (void* args)
{
	int srvr1qtyp_mbreg_wchk = 0;
	uint16_t srvr1_qtyp_regval = 0;
	unsigned int srvr1_qtyp_regaddr = 0;

server1qtyp_wmb_loop:
	//waiting for server 1 write command to be received from PL
	sem_wait(&srvr1_wcmd_qtypsem);

	pthread_mutex_lock(&srvr1_wsig_lck);
	srvr1_wsig++;
	pthread_mutex_unlock(&srvr1_wsig_lck);

	//***here you can map commands received into PS DDR to specific MODBUS write registers for the device***
	pthread_mutex_lock(&srvr1_rw);
	//srvr1qtyp_mbreg_wchk = modbus_write_register(ctx_srvr1, srvr1_qtyp_regaddr, srvr1_qtyp_regval);
	srvr1qtyp_mbreg_wchk = modbus_write_and_read_registers(ctx_srvr1, srvr1_qtyp_regaddr, 1, &srvr1_qtyp_regval, SERVER1_START_RADDR, SERVER1_NREAD_REGS, server1_rregs);
	pthread_mutex_unlock(&srvr1_rw);

	//sending signal to a waiting thread that read data has arrived
	sem_post(&srvr1_rdbk_sem);

	pthread_mutex_lock(&srvr1_wsig_lck);
	srvr1_wsig--;
	pthread_mutex_unlock(&srvr1_wsig_lck);

	if (srvr1_wsig==0)
		sem_post(&srvr1_rw_sem);

    if (srvr1qtyp_mbreg_wchk == (-1))
    	printf("ERROR modbus_write_register Server 1 QTyp (%d)\n", srvr1qtyp_mbreg_wchk);

	goto server1qtyp_wmb_loop;
	return 0;
}

// ------------------ Server1 Island Command write thread -----------------------

void* mbsrvr1_island_wthread (void* args)
{
	int srvr1island_mbreg_wchk = 0;
	uint16_t srvr1_island_regval = 0;
	unsigned int srvr1_island_regaddr = 0;

server1island_wmb_loop:
	//waiting for server 1 write command to be received from PL
	sem_wait(&srvr1_wcmd_islandsem);

	pthread_mutex_lock(&srvr1_wsig_lck);
	srvr1_wsig++;
	pthread_mutex_unlock(&srvr1_wsig_lck);

	//***here you can map commands received into PS DDR to specific MODBUS write registers for the device***
	pthread_mutex_lock(&srvr1_rw);
	//srvr1island_mbreg_wchk = modbus_write_register(ctx_srvr1, srvr1_island_regaddr, srvr1_island_regval);
	srvr1island_mbreg_wchk = modbus_write_and_read_registers(ctx_srvr1, srvr1_island_regaddr, 1, &srvr1_island_regval, SERVER1_START_RADDR, SERVER1_NREAD_REGS, server1_rregs);
	pthread_mutex_unlock(&srvr1_rw);

	//sending signal to a waiting thread that read data has arrived
	sem_post(&srvr1_rdbk_sem);

	pthread_mutex_lock(&srvr1_wsig_lck);
	srvr1_wsig--;
	pthread_mutex_unlock(&srvr1_wsig_lck);

	if (srvr1_wsig==0)
		sem_post(&srvr1_rw_sem);

    if (srvr1island_mbreg_wchk == (-1))
    	printf("ERROR modbus_write_register Server 1 Island (%d)\n", srvr1island_mbreg_wchk);

	goto server1island_wmb_loop;
	return 0;
}

// ------------------ Server1 Island Freq Command write thread -----------------------

void* mbsrvr1_islndfrq_wthread (void* args)
{
	int srvr1islndfrq_mbreg_wchk = 0;
	uint16_t srvr1_islndfrq_regval = 0;
	unsigned int srvr1_islndfrq_regaddr = 0;

server1islndfrq_wmb_loop:
	//waiting for server 1 write command to be received from PL
	sem_wait(&srvr1_wcmd_islndfrqsem);

	pthread_mutex_lock(&srvr1_wsig_lck);
	srvr1_wsig++;
	pthread_mutex_unlock(&srvr1_wsig_lck);

	//***here you can map commands received into PS DDR to specific MODBUS write registers for the device***
	pthread_mutex_lock(&srvr1_rw);
	//srvr1islndfrq_mbreg_wchk = modbus_write_register(ctx_srvr1, srvr1_islndfrq_regaddr, srvr1_islndfrq_regval);
	srvr1islndfrq_mbreg_wchk = modbus_write_and_read_registers(ctx_srvr1, srvr1_islndfrq_regaddr, 1, &srvr1_islndfrq_regval, SERVER1_START_RADDR, SERVER1_NREAD_REGS, server1_rregs);
	pthread_mutex_unlock(&srvr1_rw);

	//sending signal to a waiting thread that read data has arrived
	sem_post(&srvr1_rdbk_sem);

	pthread_mutex_lock(&srvr1_wsig_lck);
	srvr1_wsig--;
	pthread_mutex_unlock(&srvr1_wsig_lck);

	if (srvr1_wsig==0)
		sem_post(&srvr1_rw_sem);

    if (srvr1islndfrq_mbreg_wchk == (-1))
    	printf("ERROR modbus_write_register Server 1 Freq (%d)\n", srvr1islndfrq_mbreg_wchk);

	goto server1islndfrq_wmb_loop;
	return 0;
}

// ------------------ Server1 Island Volt Command write thread -----------------------

void* mbsrvr1_islndvlt_wthread (void* args)
{
	int srvr1islndvlt_mbreg_wchk = 0;
	uint16_t srvr1_islndvlt_regval = 0;
	unsigned int srvr1_islndvlt_regaddr = 0;

server1islndvlt_wmb_loop:
	//waiting for server 1 write command to be received from PL
	sem_wait(&srvr1_wcmd_islndvltsem);

	pthread_mutex_lock(&srvr1_wsig_lck);
	srvr1_wsig++;
	pthread_mutex_unlock(&srvr1_wsig_lck);

	//***here you can map commands received into PS DDR to specific MODBUS write registers for the device***
	pthread_mutex_lock(&srvr1_rw);
	//srvr1islndvlt_mbreg_wchk = modbus_write_register(ctx_srvr1, srvr1_islndvlt_regaddr, srvr1_islndvlt_regval);
	srvr1islndvlt_mbreg_wchk = modbus_write_and_read_registers(ctx_srvr1, srvr1_islndvlt_regaddr, 1, &srvr1_islndvlt_regval, SERVER1_START_RADDR, SERVER1_NREAD_REGS, server1_rregs);
	pthread_mutex_unlock(&srvr1_rw);

	//sending signal to a waiting thread that read data has arrived
	sem_post(&srvr1_rdbk_sem);

	pthread_mutex_lock(&srvr1_wsig_lck);
	srvr1_wsig--;
	pthread_mutex_unlock(&srvr1_wsig_lck);

	if (srvr1_wsig==0)
		sem_post(&srvr1_rw_sem);

    if (srvr1islndvlt_mbreg_wchk == (-1))
    	printf("ERROR modbus_write_register Server 1 Volt (%d)\n", srvr1islndvlt_mbreg_wchk);

	goto server1islndvlt_wmb_loop;
	return 0;
}




