int srvr1_thread_result = 0;
int srvr1_rwait_thread_result = 0;
int srvr1_wthread_result = 0;
int srvr1_wthread_presult = 0;
int srvr1_wthread_qresult = 0;
int srvr1_wthread_pfresult = 0;
int srvr1_wthread_runresult = 0;
int srvr1_wthread_qtypresult = 0;
int srvr1_wthread_islandresult = 0;
int srvr1_wthread_islndfrqresult = 0;
int srvr1_wthread_islndvltresult = 0;

sem_init (&srvr1_rdbk_sem,0,0);
sem_init (&srvr1_rw_sem,0,0);
sem_init (&srvr1_wcmd_sem,0,0);
sem_init (&srvr1_wcmd_psem,0,0);
sem_init (&srvr1_wcmd_qsem,0,0);
sem_init (&srvr1_wcmd_runsem,0,0);
sem_init (&srvr1_wcmd_pfsem,0,0);
sem_init (&srvr1_wcmd_qtypsem,0,0);
sem_init (&srvr1_wcmd_islandsem,0,0);
sem_init (&srvr1_wcmd_islndfrqsem,0,0);
sem_init (&srvr1_wcmd_islndvltsem,0,0);



//Declaring EMIO for PL_PS direct GPIO signal
system("echo 412 > /sys/class/gpio/export"); //For Server 1 modbus read data PS to PL indication into BRAM
system("echo out > /sys/class/gpio/gpio412/direction");//setting direction to output
system("echo 0 > /sys/class/gpio/gpio412/value");//init to zero

srvr1_rwait_thread_result = pthread_create(&mbsrvr1_rwait, NULL, mbsrvr1_rwait_thread, NULL);
if(srvr1_rwait_thread_result != 0)
{
   fprintf(stderr, "Could not Create Readback Wait Thread for Server 1!\n");
   exit(1);
}

srvr1_wthread_result = pthread_create(&mbsrvr1_w, NULL, mbsrvr1_wthread, NULL);
if(srvr1_wthread_result != 0)
{
   fprintf(stderr, "Could not Create Write Thread for Server 1!\n");
   exit(1);
}

//creating bess read thread only if reading from bess directly
#ifndef STCH_MG_ACTUAL
 #ifndef STCH_MG_ACTUAL_EIT_HIL_HYBRID
	srvr1_thread_result = pthread_create(&mbsrvr1, NULL, mbsrvr1_thread, NULL);
	if(srvr1_thread_result != 0)
	{
		fprintf(stderr, "Could not Create Thread for Server 1!\n");
		exit(1);
	}
 #endif
#endif


//creating write command threads only if writing commands to the asset directly
#ifndef STCH_MG_PLC
//******************Write Command Threads for Server 1 (BESS)***********************************************
srvr1_wthread_runresult = pthread_create(&mbsrvr1_run_w, NULL, mbsrvr1_run_wthread, NULL);
if(srvr1_wthread_runresult != 0)
{
   fprintf(stderr, "Could not Create Run Write Thread for Server 1!\n");
   exit(1);
}

srvr1_wthread_presult = pthread_create(&mbsrvr1_p_w, NULL, mbsrvr1_p_wthread, NULL);
if(srvr1_wthread_presult != 0)
{
   fprintf(stderr, "Could not Create P Write Thread for Server 1!\n");
   exit(1);
}

srvr1_wthread_qresult = pthread_create(&mbsrvr1_q_w, NULL, mbsrvr1_q_wthread, NULL);
if(srvr1_wthread_qresult != 0)
{
   fprintf(stderr, "Could not Create Q Write Thread for Server 1!\n");
   exit(1);
}

srvr1_wthread_pfresult = pthread_create(&mbsrvr1_pf_w, NULL, mbsrvr1_pf_wthread, NULL);
if(srvr1_wthread_pfresult != 0)
{
   fprintf(stderr, "Could not Create PF Write Thread for Server 1!\n");
   exit(1);
}

srvr1_wthread_qtypresult = pthread_create(&mbsrvr1_qtyp_w, NULL, mbsrvr1_qtyp_wthread, NULL);
if(srvr1_wthread_qtypresult != 0)
{
   fprintf(stderr, "Could not Create Q Type Write Thread for Server 1!\n");
   exit(1);
}

srvr1_wthread_islandresult = pthread_create(&mbsrvr1_island_w, NULL, mbsrvr1_island_wthread, NULL);
if(srvr1_wthread_islandresult != 0)
{
   fprintf(stderr, "Could not Create Island Write Thread for Server 1!\n");
   exit(1);
}

srvr1_wthread_islndfrqresult = pthread_create(&mbsrvr1_islndfrq_w, NULL, mbsrvr1_islndfrq_wthread, NULL);
if(srvr1_wthread_islndfrqresult != 0)
{
   fprintf(stderr, "Could not Create Island Freq Write Thread for Server 1!\n");
   exit(1);
}

srvr1_wthread_islndvltresult = pthread_create(&mbsrvr1_islndvlt_w, NULL, mbsrvr1_islndvlt_wthread, NULL);
if(srvr1_wthread_islndvltresult != 0)
{
   fprintf(stderr, "Could not Create Island Volt Write Thread for Server 1!\n");
   exit(1);
}
//*********************************************************************************************************************
#endif
