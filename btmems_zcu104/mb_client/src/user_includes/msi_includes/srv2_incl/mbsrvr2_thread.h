// *************************** MODBUS READ AND WRITE Code for Server 2 - Modify as required *********************************************************************

//------ Thread waiting for server 2 read data to arrive -------------------
void* mbsrvr2_rwait_thread (void* args)
{
	unsigned int pv_stat_plr;
	unsigned int pv_flt_plr;
	unsigned int pv_wattsp_plr;
	unsigned int pv_watt_plr;
	unsigned int pv_var_plr;
	unsigned int pv_yield_plr;

	unsigned int pv1_stat_flt_plr = 0;
	unsigned int pv2_stat_flt_plr = 0;
	unsigned int pv3_stat_flt_plr = 0;
	unsigned int pv4_stat_flt_plr = 0;
	unsigned int pv5_stat_flt_plr = 0;
	unsigned int pv6_stat_flt_plr = 0;

	unsigned int no_wrkng_inv = 0;


	//*******Shared memory and file lock creation for # of working inverters with Python BESS Dispatch Optimz code***********
	#define SHM_SIZE_PV sizeof(unsigned int)  // Size of an integer (4 bytes)
	#define LOCK_FILE_PV "/usr/my_lock_pv" //this path needs to match lock file path in Python BESS dispatch code

    // Open a file for reading and writing (create if it doesn't exist)
	int shm_fd = open("/usr/no_pv_inv", O_RDWR | O_CREAT, 0666); //#this path needs to match shared memory object path in Python BESS dispatch code
    if (shm_fd == -1) {
        perror("open: Shared Memory # of Working PV Inverters");
        return EXIT_FAILURE;
    }
    // Ensure the file is the correct size
    if (ftruncate(shm_fd, SHM_SIZE_PV) == -1) {
        perror("ftruncate: File Lock # of Working PV Inverters");
        close(shm_fd);
        return EXIT_FAILURE;
    }

    // Map the file into memory
    unsigned int *shm = mmap(NULL, SHM_SIZE_PV, PROT_READ | PROT_WRITE, MAP_SHARED, shm_fd, 0);
    if (shm == MAP_FAILED) {
        perror("mmap: Shared Memory # of Working PV Inverters");
        close(shm_fd);
        return EXIT_FAILURE;
    }

    // Open the lock file
    int lock_fd = open(LOCK_FILE_PV, O_CREAT | O_RDWR, 0666);
    if (lock_fd == -1) {
        perror("open lock file: File Lock # of Working PV Inverters");
        munmap(shm, SHM_SIZE_PV);
        close(shm_fd);
        return EXIT_FAILURE;
    }
    //********************************************************************************

	srvr2_rdbk_waitloop:
	//waiting for server 2 readback data to arrive
	sem_wait(&srvr2_rdbk_sem);

	//***********************************************************
	//here you can map modbus read register data to fpga msi interface signals for this server

#ifdef STCH_MG_ACTUAL
	pv1_stat_flt_plr 	= (*(server2_rregs_ptr));
	//printf ("PV1 Status Fault %d \n",pv1_stat_flt_plr);
	pv2_stat_flt_plr 	= (*(server2_rregs_ptr+1));
	//printf ("PV2 Status Fault %d \n",pv2_stat_flt_plr);
	pv3_stat_flt_plr 	= (*(server2_rregs_ptr+2));
	//printf ("PV3 Status Fault %d \n",pv3_stat_flt_plr);
	pv4_stat_flt_plr 	= (*(server2_rregs_ptr+3));
	//printf ("PV4 Status Fault %d \n",pv4_stat_flt_plr);
	pv5_stat_flt_plr 	= (*(server2_rregs_ptr+4));
	//printf ("PV5 Status Fault %d \n",pv5_stat_flt_plr);
	pv6_stat_flt_plr 	= (*(server2_rregs_ptr+5));
	//printf ("PV6 Status Fault %d \n",pv6_stat_flt_plr);
#else
	pv1_stat_flt_plr 	= (*(server2_rregs_ptr)) << 16;
	pv1_stat_flt_plr   = pv1_stat_flt_plr | (*(server2_rregs_ptr+1));
	//printf ("PV1 Status Fault %d \n",pv1_stat_flt_plr);
	pv2_stat_flt_plr 	= (*(server2_rregs_ptr+2)) << 16;
	pv2_stat_flt_plr   = pv2_stat_flt_plr | (*(server2_rregs_ptr+3));
	//printf ("PV2 Status Fault %d \n",pv2_stat_flt_plr);
	pv3_stat_flt_plr 	= (*(server2_rregs_ptr+4)) << 16;
	pv3_stat_flt_plr   = pv3_stat_flt_plr | (*(server2_rregs_ptr+5));
	//printf ("PV3 Status Fault %d \n",pv3_stat_flt_plr);
	pv4_stat_flt_plr 	= (*(server2_rregs_ptr+6)) << 16;
	pv4_stat_flt_plr   = pv4_stat_flt_plr | (*(server2_rregs_ptr+7));
	//printf ("PV4 Status Fault %d \n",pv4_stat_flt_plr);
	pv5_stat_flt_plr 	= (*(server2_rregs_ptr+8)) << 16;
	pv5_stat_flt_plr   = pv5_stat_flt_plr | (*(server2_rregs_ptr+9));
	//printf ("PV5 Status Fault %d \n",pv5_stat_flt_plr);
	pv6_stat_flt_plr 	= (*(server2_rregs_ptr+10)) << 16;
	pv6_stat_flt_plr   = pv6_stat_flt_plr | (*(server2_rregs_ptr+11));
	//printf ("PV6 Status Fault %d \n",pv6_stat_flt_plr);
#endif

	pv_stat_plr = 0;
	pv_flt_plr = 0;
	no_wrkng_inv = 6;

	if (pv1_stat_flt_plr==307) //307 = OK
	{
		pv_stat_plr = (pv_stat_plr | 0x1); //reserving 4bits for each inverter for status. Also assuming 1 means OK, 2 means OFF
		pv_flt_plr = (pv_flt_plr & 0xFFFFFFF0); //reserving 4bits for each inverter for fault
	}
	else if (pv1_stat_flt_plr==303) //303 = OFF
	{
		pv_stat_plr = (pv_stat_plr | 0x2);
		pv_flt_plr = (pv_flt_plr & 0xFFFFFFF0);
		no_wrkng_inv = no_wrkng_inv - 1;
	}
	else if (pv1_stat_flt_plr==35) // 35 = Fault
	{
		pv_stat_plr = (pv_stat_plr & 0xFFFFFFF0);
		pv_flt_plr = (pv_flt_plr | 0x1);//reserving 4bits for each inverter for fault. Also assuming 1 means fault, 2 means warning
		no_wrkng_inv = no_wrkng_inv - 1;
	}
	else if (pv1_stat_flt_plr==455) // 455 = Warning
	{
		pv_stat_plr = (pv_stat_plr & 0xFFFFFFF0);
		pv_flt_plr = (pv_flt_plr | 0x2);
	}


	if (pv2_stat_flt_plr==307)
	{
		pv_stat_plr = (pv_stat_plr | 0x10);
		pv_flt_plr = (pv_flt_plr & 0xFFFFFF0F);
	}
	else if (pv2_stat_flt_plr==303)
	{
		pv_stat_plr = (pv_stat_plr | 0x20);
		pv_flt_plr = (pv_flt_plr & 0xFFFFFF0F);
		no_wrkng_inv = no_wrkng_inv - 1;
	}
	else if (pv2_stat_flt_plr==35)
	{
		pv_stat_plr = (pv_stat_plr & 0xFFFFFF0F);
		pv_flt_plr = (pv_flt_plr | 0x10);
		no_wrkng_inv = no_wrkng_inv - 1;
	}
	else if (pv2_stat_flt_plr==455)
	{
		pv_stat_plr = (pv_stat_plr & 0xFFFFFF0F);
		pv_flt_plr = (pv_flt_plr | 0x20);
	}


	if (pv3_stat_flt_plr==307)
	{
		pv_stat_plr = (pv_stat_plr | 0x100);
		pv_flt_plr = (pv_flt_plr & 0xFFFFF0FF);
	}
	else if (pv3_stat_flt_plr==303)
	{
		pv_stat_plr = (pv_stat_plr | 0x200);
		pv_flt_plr = (pv_flt_plr & 0xFFFFF0FF);
		no_wrkng_inv = no_wrkng_inv - 1;
	}
	else if (pv3_stat_flt_plr==35)
	{
		pv_stat_plr = (pv_stat_plr & 0xFFFFF0FF);
		pv_flt_plr = (pv_flt_plr | 0x100);
		no_wrkng_inv = no_wrkng_inv - 1;
	}
	else if (pv3_stat_flt_plr==455)
	{
		pv_stat_plr = (pv_stat_plr & 0xFFFFF0FF);
		pv_flt_plr = (pv_flt_plr | 0x200);
	}


	if (pv4_stat_flt_plr==307)
	{
		pv_stat_plr = (pv_stat_plr | 0x1000);
		pv_flt_plr = (pv_flt_plr & 0xFFFF0FFF);
	}
	else if (pv4_stat_flt_plr==303)
	{
		pv_stat_plr = (pv_stat_plr | 0x2000);
		pv_flt_plr = (pv_flt_plr & 0xFFFF0FFF);
		no_wrkng_inv = no_wrkng_inv - 1;
	}
	else if (pv4_stat_flt_plr==35)
	{
		pv_stat_plr = (pv_stat_plr & 0xFFFF0FFF);
		pv_flt_plr = (pv_flt_plr | 0x1000);
		no_wrkng_inv = no_wrkng_inv - 1;
	}
	else if (pv4_stat_flt_plr==455)
	{
		pv_stat_plr = (pv_stat_plr & 0xFFFF0FFF);
		pv_flt_plr = (pv_flt_plr | 0x2000);
	}


	if (pv5_stat_flt_plr==307)
	{
		pv_stat_plr = (pv_stat_plr | 0x10000);
		pv_flt_plr = (pv_flt_plr & 0xFFF0FFFF);
	}
	else if (pv5_stat_flt_plr==303)
	{
		pv_stat_plr = (pv_stat_plr | 0x20000);
		pv_flt_plr = (pv_flt_plr & 0xFFF0FFFF);
		no_wrkng_inv = no_wrkng_inv - 1;
	}
	else if (pv5_stat_flt_plr==35)
	{
		pv_stat_plr = (pv_stat_plr & 0xFFF0FFFF);
		pv_flt_plr = (pv_flt_plr | 0x10000);
		no_wrkng_inv = no_wrkng_inv - 1;
	}
	else if (pv5_stat_flt_plr==455)
	{
		pv_stat_plr = (pv_stat_plr & 0xFFF0FFFF);
		pv_flt_plr = (pv_flt_plr | 0x20000);
	}

	if (pv6_stat_flt_plr==307)
	{
		pv_stat_plr = (pv_stat_plr | 0x100000);
		pv_flt_plr = (pv_flt_plr & 0xFF0FFFFF);
	}
	else if (pv6_stat_flt_plr==303)
	{
		pv_stat_plr = (pv_stat_plr | 0x200000);
		pv_flt_plr = (pv_flt_plr & 0xFF0FFFFF);
		no_wrkng_inv = no_wrkng_inv - 1;
	}
	else if (pv6_stat_flt_plr==35)
	{
		pv_stat_plr = (pv_stat_plr & 0xFF0FFFFF);
		pv_flt_plr = (pv_flt_plr | 0x100000);
		no_wrkng_inv = no_wrkng_inv - 1;
	}
	else if (pv6_stat_flt_plr==455)
	{
		pv_stat_plr = (pv_stat_plr & 0xFF0FFFFF);
		pv_flt_plr = (pv_flt_plr | 0x200000);
	}

	//Sending # of Working PV Inverters to Python BESS Dispatch Optimization Code
    // Lock the file
    struct flock lock;
    lock.l_type = F_WRLCK;
    lock.l_whence = SEEK_SET;
    lock.l_start = 0;
    lock.l_len = 0;
    fcntl(lock_fd, F_SETLKW, &lock);
    // Write an integer to the shared memory
    *shm = no_wrkng_inv;
    // Unlock the file
    lock.l_type = F_UNLCK;
    fcntl(lock_fd, F_SETLK, &lock);

	//--------------- Writing Data to PS DDR --------------------------------------------

	  //PV status/fault read data
	  vadd_psddr[SRVR2_READ_PSDDR_OFFSET] = pv_stat_plr;
	  vadd_psddr[SRVR2_READ_PSDDR_OFFSET+1] = pv_flt_plr;

	  //PV P setpoint read back
	  vadd_psddr[SRVR2_READ_PSDDR_OFFSET+2] = pv_wattsp_plr; //readback not available

	  //PV P output read back
	  vadd_psddr[SRVR2_READ_PSDDR_OFFSET+3] = pv_watt_plr; //readback not available

	  //PV Q output read back
	  vadd_psddr[SRVR2_READ_PSDDR_OFFSET+4] = pv_var_plr; //readback not available

	  //PV yield
	  vadd_psddr[SRVR2_READ_PSDDR_OFFSET+5] = pv_yield_plr; //not mapping yield for now

	  //request CDMA transfer
	reacquire_srvr2_rmutex:
	pthread_mutex_lock(&mutex_cdma_trnsf);
	if (cdma_trnsf_chk==TRUE)
	{
		pthread_mutex_unlock(&mutex_cdma_trnsf);
		goto reacquire_srvr2_rmutex;
	}
	cdma_trnsf_chk = TRUE;

	//Requesting CDMA transfer
	cdma_src_addr = PSDDR_PBASE + (SRVR2_READ_PSDDR_OFFSET*0x4);
    cdma_dest_addr = BRAM_PBASE + (SRVR2_READ_BRAM_OFFSET*0x4);
    cdma_trnsf_length = 0x18; //32bit*6locations = 24bytes. Note Max space reserved is 32bit*40locations = 160bytes

	pthread_cond_signal(&cond_cdma_trnsf);
	pthread_mutex_unlock(&mutex_cdma_trnsf);

	//loop back to wait state.
	goto srvr2_rdbk_waitloop;

	return 0;
}

// ------------------ Server2 MODBUS polling thread -----------------------
void* mbsrvr2_thread (void* args)
{
	//Server 2 variable initialization
	int rc[12];

	ctx_srvr2 = modbus_new_tcp(SERVER2_IP, SERVER2_MBPORT);
	modbus_set_debug(ctx_srvr2, SERVER2_DBG_MSG);

server2_mb_connec:
	if (modbus_connect(ctx_srvr2) == -1) {
		printf("Modbus Server 2 Connection Failed - Retrying\n");
		goto server2_mb_connec;
	}

server2_mb_read:
	if (srvr2_wsig!=0)
		sem_wait(&srvr2_rw_sem);

	/*reading multiple registers values*/
	pthread_mutex_lock(&srvr2_rw);
	rc[0] = modbus_read_input_registers(ctx_srvr2, 196, 2, server2_rregs_ptr);
	rc[1] = modbus_read_input_registers(ctx_srvr2, 316, 2, (server2_rregs_ptr+2));
	rc[2] = modbus_read_input_registers(ctx_srvr2, 16, 2, (server2_rregs_ptr+4));
	rc[3] = modbus_read_input_registers(ctx_srvr2, 256, 2, (server2_rregs_ptr+6));
	rc[4] = modbus_read_input_registers(ctx_srvr2, 76, 2, (server2_rregs_ptr+8));
	rc[5] = modbus_read_input_registers(ctx_srvr2, 136, 2, (server2_rregs_ptr+10));
	/*rc[6] = modbus_read_input_registers(ctx_srvr2, 200, 2, (server2_rregs_ptr+12));
	rc[7] = modbus_read_input_registers(ctx_srvr2, 320, 2, (server2_rregs_ptr+14));
	rc[8] = modbus_read_input_registers(ctx_srvr2, 20, 2, (server2_rregs_ptr+16));
	rc[9] = modbus_read_input_registers(ctx_srvr2, 260, 2, (server2_rregs_ptr+18));
	rc[10] = modbus_read_input_registers(ctx_srvr2, 80, 2, (server2_rregs_ptr+20));
	rc[11] = modbus_read_input_registers(ctx_srvr2, 140, 2, (server2_rregs_ptr+22));*/ //Not reading yield for now

	pthread_mutex_unlock(&srvr2_rw);
	if ((rc[0] != 2) || (rc[1] != 2) || (rc[2] != 2) || (rc[3] != 2) || (rc[4] != 2) || (rc[5] != 2) /*|| (rc[6] != 2) ||
			(rc[7] != 2) || (rc[8] != 2) || (rc[9] != 2) || (rc[10] != 2) || (rc[11] != 2)*/)
	{
		printf("ERROR Reading Server 2 Registers - Re-establishing Connection\n");
		modbus_close(ctx_srvr2);
		goto server2_mb_connec;
	}

	//sending signal to a waiting thread that read data has arrived
	sem_post(&srvr2_rdbk_sem);

	goto server2_mb_read; //continuous read

	return 0;
}

// ------------------ Server2 (PV) MODBUS write thread -----------------------

void* mbsrvr2_wthread (void* args)
{
	uint64_t srvr2_run_wcmdchk; 		//check for start/stop command
	uint64_t srvr2_p_wcmdchk; 			//check for P setpoint
	uint64_t srvr2_q_wcmdchk;			//check for q setpoint
	uint64_t srvr2_pf_wcmdchk;			//check for power factor setpoint
	uint64_t srvr2_qtyp_wcmdchk;		//check for var type setting


server2_wmb_loop:
	//waiting for server 2 write command to be received from PL
	sem_wait(&srvr2_wcmd_sem);

	//signaling srvr2 modbus write thread if server2 command was sent from PL to PS
	srvr2_run_wcmdchk = mbsrvr_wcmd_stat & 0x40000; //bit 18 is for srvr2 run cmd
	if (srvr2_run_wcmdchk>0)
	{
		sem_post(&srvr2_wcmd_runsem);
	}
	srvr2_p_wcmdchk = mbsrvr_wcmd_stat & 0x80000; //bit 19 is for srvr1 P cmd
	if (srvr2_p_wcmdchk>0)
	{
		sem_post(&stchmgplc_pv_psem/*srvr2_wcmd_psem*/); //signaling server 2 modbus write thread for P command
	}
	srvr2_q_wcmdchk = mbsrvr_wcmd_stat & 0x100000; //bit 20 is for srvr2 Q cmd
	if (srvr2_q_wcmdchk>0)
	{
		sem_post(&srvr2_wcmd_qsem);
	}
	srvr2_pf_wcmdchk = mbsrvr_wcmd_stat & 0x200000; //bit 21 is for srvr2 PF cmd
	if (srvr2_pf_wcmdchk>0)
	{
		sem_post(&srvr2_wcmd_pfsem);
	}
	srvr2_qtyp_wcmdchk = mbsrvr_wcmd_stat & 0x400000; //bit 22 is for srvr2 Q type cmd
	if (srvr2_qtyp_wcmdchk>0)
	{
		sem_post(&srvr2_wcmd_qtypsem);
	}


	goto server2_wmb_loop;
	return 0;
}

// ------------------ Server2 P Command write thread -----------------------

void* mbsrvr2_p_wthread (void* args)
{
	int srvr2p_mbreg_wchk = 0;
	uint16_t srvr2_p_regval = 0;
	unsigned int srvr2_p_regaddr = 1000;
	unsigned int pv_p_plw = 0;
	int rc[6];

server2p_wmb_loop:
	//waiting for server 2 write command to be received from PL
	sem_wait(&srvr2_wcmd_psem);

	pthread_mutex_lock(&srvr2_wsig_lck);
	srvr2_wsig++;
	pthread_mutex_unlock(&srvr2_wsig_lck);

	//PV P command from PL
	pv_p_plw 			= vadd_psddr[WCMD_PSDDR_OFFSET+6];
	pv_p_plw			= (pv_p_plw/100); //Changing to kW with x10 scaling (10/1000)

	//**************************
	//***here you can map commands received to specific MODBUS write registers for the device***
	srvr2_p_regval = pv_p_plw;
	//****************************

	pthread_mutex_lock(&srvr2_rw);
	srvr2p_mbreg_wchk = modbus_write_register(ctx_srvr2, srvr2_p_regaddr, srvr2_p_regval); //if the register is 32bit, you need to use multiple write function instead

	rc[0] = modbus_read_input_registers(ctx_srvr2, 196, 2, server2_rregs_ptr);
	rc[1] = modbus_read_input_registers(ctx_srvr2, 316, 2, (server2_rregs_ptr+2));
	rc[2] = modbus_read_input_registers(ctx_srvr2, 16, 2, (server2_rregs_ptr+2));
	rc[3] = modbus_read_input_registers(ctx_srvr2, 256, 2, (server2_rregs_ptr+2));
	rc[4] = modbus_read_input_registers(ctx_srvr2, 76, 2, (server2_rregs_ptr+2));
	rc[5] = modbus_read_input_registers(ctx_srvr2, 136, 2, (server2_rregs_ptr+2));


	pthread_mutex_unlock(&srvr2_rw);

	pthread_mutex_lock(&srvr2_wsig_lck);
	srvr2_wsig--;
	pthread_mutex_unlock(&srvr2_wsig_lck);

	if (srvr2_wsig==0) //condition tries to ensure that read thread is signaled only after for all write threads have finished processing
		sem_post(&srvr2_rw_sem);

    if ((srvr2p_mbreg_wchk == (-1)) || (rc[0] != 2) || (rc[1] != 2) || (rc[2] != 2) || (rc[3] != 2) || (rc[4] != 2) || (rc[5] != 2))
    	printf("ERROR modbus_write_read_register P Server 2 (%d) (%d) (%d) (%d) (%d) (%d) (%d)\n", srvr2p_mbreg_wchk,rc[0],rc[1],rc[2],rc[3],rc[4],rc[5]);

	//sending signal to a waiting thread that read data has arrived
	sem_post(&srvr2_rdbk_sem);

	goto server2p_wmb_loop;
	return 0;
}

// ------------------ Server2 Q Command write thread -----------------------

void* mbsrvr2_q_wthread (void* args)
{
	int srvr2q_mbreg_wchk = 0;
	uint16_t srvr2_q_regval = 0;
	unsigned int srvr2_q_regaddr = 0;

server2q_wmb_loop:
	//waiting for server 2 write command to be received from PL
	sem_wait(&srvr2_wcmd_qsem);

	pthread_mutex_lock(&srvr2_wsig_lck);
	srvr2_wsig++;
	pthread_mutex_unlock(&srvr2_wsig_lck);

	//***here you can map commands received into PS DDR to specific MODBUS write registers for the device***

	pthread_mutex_lock(&srvr2_rw);
	//srvr2q_mbreg_wchk = modbus_write_register(ctx_srvr2, srvr2_q_regaddr, srvr2_q_regval);
	srvr2q_mbreg_wchk = modbus_write_and_read_registers(ctx_srvr2, srvr2_q_regaddr, 1, &srvr2_q_regval, SERVER2_START_RADDR, SERVER2_NREAD_REGS, server2_rregs);
	pthread_mutex_unlock(&srvr2_rw);

	//sending signal to a waiting thread that read data has arrived
	sem_post(&srvr2_rdbk_sem);

	pthread_mutex_lock(&srvr2_wsig_lck);
	srvr2_wsig--;
	pthread_mutex_unlock(&srvr2_wsig_lck);

	if (srvr2_wsig==0) //condition tries to ensure that read thread is signaled only after for all write threads have finished processing
		sem_post(&srvr2_rw_sem);

    if (srvr2q_mbreg_wchk == (-1))
    	printf("ERROR modbus_write_register Server 2 Q (%d)\n", srvr2q_mbreg_wchk);

	goto server2q_wmb_loop;
	return 0;
}

// ------------------ Server2 RUN Command write thread -----------------------

void* mbsrvr2_run_wthread (void* args)
{
	int srvr2run_mbreg_wchk = 0;
	uint16_t srvr2_run_regval = 0;
	unsigned int srvr2_run_regaddr = 0;

server2run_wmb_loop:
	//waiting for server 2 write command to be received from PL
	sem_wait(&srvr2_wcmd_runsem);

	pthread_mutex_lock(&srvr2_wsig_lck);
	srvr2_wsig++;
	pthread_mutex_unlock(&srvr2_wsig_lck);

	//***here you can map commands received into PS DDR to specific MODBUS write registers for the device***

	pthread_mutex_lock(&srvr2_rw);
	//srvr2run_mbreg_wchk = modbus_write_register(ctx_srvr2, srvr2_run_regaddr, srvr2_run_regval);
	srvr2run_mbreg_wchk = modbus_write_and_read_registers(ctx_srvr2, srvr2_run_regaddr, 1, &srvr2_run_regval, SERVER2_START_RADDR, SERVER2_NREAD_REGS, server2_rregs);
	pthread_mutex_unlock(&srvr2_rw);

	//sending signal to a waiting thread that read data has arrived
	sem_post(&srvr2_rdbk_sem);

	pthread_mutex_lock(&srvr2_wsig_lck);
	srvr2_wsig--;
	pthread_mutex_unlock(&srvr2_wsig_lck);

	if (srvr2_wsig==0) //condition tries to ensure that read thread is signaled only after for all write threads have finished processing
		sem_post(&srvr2_rw_sem);

    if (srvr2run_mbreg_wchk == (-1))
    	printf("ERROR modbus_write_register Server 2 Run (%d)\n", srvr2run_mbreg_wchk);

	goto server2run_wmb_loop;
	return 0;
}

// ------------------ Server2 PF Command write thread -----------------------

void* mbsrvr2_pf_wthread (void* args)
{
	int srvr2pf_mbreg_wchk = 0;
	uint16_t srvr2_pf_regval = 0;
	unsigned int srvr2_pf_regaddr = 0;

server2pf_wmb_loop:
	//waiting for server 2 write command to be received from PL
	sem_wait(&srvr2_wcmd_pfsem);

	pthread_mutex_lock(&srvr2_wsig_lck);
	srvr2_wsig++;
	pthread_mutex_unlock(&srvr2_wsig_lck);

	//***here you can map commands received into PS DDR to specific MODBUS write registers for the device***

	pthread_mutex_lock(&srvr2_rw);
	//srvr2pf_mbreg_wchk = modbus_write_register(ctx_srvr2, srvr2_pf_regaddr, srvr2_pf_regval);
	srvr2pf_mbreg_wchk = modbus_write_and_read_registers(ctx_srvr2, srvr2_pf_regaddr, 1, &srvr2_pf_regval, SERVER2_START_RADDR, SERVER2_NREAD_REGS, server2_rregs);
	pthread_mutex_unlock(&srvr2_rw);

	//sending signal to a waiting thread that read data has arrived
	sem_post(&srvr2_rdbk_sem);

	pthread_mutex_lock(&srvr2_wsig_lck);
	srvr2_wsig--;
	pthread_mutex_unlock(&srvr2_wsig_lck);

	if (srvr2_wsig==0) //condition tries to ensure that read thread is signaled only after for all write threads have finished processing
		sem_post(&srvr2_rw_sem);

    if (srvr2pf_mbreg_wchk == (-1))
    	printf("ERROR modbus_write_register Server 2 PF (%d)\n", srvr2pf_mbreg_wchk);

	goto server2pf_wmb_loop;
	return 0;
}

// ------------------ Server2 Qtyp Command write thread -----------------------

void* mbsrvr2_qtyp_wthread (void* args)
{
	int srvr2qtyp_mbreg_wchk = 0;
	uint16_t srvr2_qtyp_regval = 0;
	unsigned int srvr2_qtyp_regaddr = 0;

server2qtyp_wmb_loop:
	//waiting for server 2 write command to be received from PL
	sem_wait(&srvr2_wcmd_qtypsem);

	pthread_mutex_lock(&srvr2_wsig_lck);
	srvr2_wsig++;
	pthread_mutex_unlock(&srvr2_wsig_lck);

	//***here you can map commands received into PS DDR to specific MODBUS write registers for the device***

	pthread_mutex_lock(&srvr2_rw);
	//srvr2qtyp_mbreg_wchk = modbus_write_register(ctx_srvr2, srvr2_qtyp_regaddr, srvr2_qtyp_regval);
	srvr2qtyp_mbreg_wchk = modbus_write_and_read_registers(ctx_srvr2, srvr2_qtyp_regaddr, 1, &srvr2_qtyp_regval, SERVER2_START_RADDR, SERVER2_NREAD_REGS, server2_rregs);
	pthread_mutex_unlock(&srvr2_rw);

	//sending signal to a waiting thread that read data has arrived
	sem_post(&srvr2_rdbk_sem);

	pthread_mutex_lock(&srvr2_wsig_lck);
	srvr2_wsig--;
	pthread_mutex_unlock(&srvr2_wsig_lck);

	if (srvr2_wsig==0) //condition tries to ensure that read thread is signaled only after for all write threads have finished processing
		sem_post(&srvr2_rw_sem);

    if (srvr2qtyp_mbreg_wchk == (-1))
    	printf("ERROR modbus_write_register Server 2 QTYP (%d)\n", srvr2qtyp_mbreg_wchk);

	goto server2qtyp_wmb_loop;
	return 0;
}






