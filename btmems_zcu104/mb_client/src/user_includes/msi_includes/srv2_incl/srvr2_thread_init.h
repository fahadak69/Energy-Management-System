int srvr2_thread_result = 0;
int srvr2_rwait_thread_result = 0;
int srvr2_wthread_result = 0;
int srvr2_wthread_presult = 0;
int srvr2_wthread_qresult = 0;
int srvr2_wthread_pfresult = 0;
int srvr2_wthread_runresult = 0;
int srvr2_wthread_qtypresult = 0;

sem_init (&srvr2_rdbk_sem,0,0);
sem_init (&srvr2_rw_sem,0,0);
sem_init (&srvr2_wcmd_sem,0,0);
sem_init (&srvr2_wcmd_psem,0,0);
sem_init (&srvr2_wcmd_qsem,0,0);
sem_init (&srvr2_wcmd_runsem,0,0);
sem_init (&srvr2_wcmd_pfsem,0,0);
sem_init (&srvr2_wcmd_qtypsem,0,0);


//Declaring EMIO for PL_PS direct GPIO signal
system("echo 413 > /sys/class/gpio/export"); //For Server 2 modbus read data PS to PL indication into BRAM
system("echo out > /sys/class/gpio/gpio413/direction");//setting direction to output
system("echo 0 > /sys/class/gpio/gpio413/value");//init to zero

srvr2_rwait_thread_result = pthread_create(&mbsrvr2_rwait, NULL, mbsrvr2_rwait_thread, NULL);
if(srvr2_rwait_thread_result != 0)
{
   fprintf(stderr, "Could not Create Readback Wait Thread for Server 2!\n");
   exit(1);
}

srvr2_wthread_result = pthread_create(&mbsrvr2_w, NULL, mbsrvr2_wthread, NULL);
if(srvr2_wthread_result != 0)
{
   fprintf(stderr, "Could not Create Write Thread for Server 2!\n");
   exit(1);
}

#ifdef STCH_MG_HIL
srvr2_thread_result = pthread_create(&mbsrvr2, NULL, mbsrvr2_thread, NULL);
if(srvr2_thread_result != 0)
{
   fprintf(stderr, "Could not Create Thread for Server 2!\n");
   exit(1);
}
#endif

//******************Write Command Threads for Server 2 (BESS)***********************************************

#ifndef STCH_MG_PLC

srvr2_wthread_runresult = pthread_create(&mbsrvr2_run_w, NULL, mbsrvr2_run_wthread, NULL);
if(srvr2_wthread_runresult != 0)
{
   fprintf(stderr, "Could not Create Run Write Thread for Server 2!\n");
   exit(1);
}

srvr2_wthread_presult = pthread_create(&mbsrvr2_p_w, NULL, mbsrvr2_p_wthread, NULL);
if(srvr2_wthread_presult != 0)
{
   fprintf(stderr, "Could not Create P Write Thread for Server 2!\n");
   exit(1);
}

srvr2_wthread_qresult = pthread_create(&mbsrvr2_q_w, NULL, mbsrvr2_q_wthread, NULL);
if(srvr2_wthread_qresult != 0)
{
   fprintf(stderr, "Could not Create Q Write Thread for Server 2!\n");
   exit(1);
}

srvr2_wthread_pfresult = pthread_create(&mbsrvr2_pf_w, NULL, mbsrvr2_pf_wthread, NULL);
if(srvr2_wthread_pfresult != 0)
{
   fprintf(stderr, "Could not Create PF Write Thread for Server 2!\n");
   exit(1);
}

srvr2_wthread_qtypresult = pthread_create(&mbsrvr2_qtyp_w, NULL, mbsrvr2_qtyp_wthread, NULL);
if(srvr2_wthread_qtypresult != 0)
{
   fprintf(stderr, "Could not Create Q Type Write Thread for Server 2!\n");
   exit(1);
}
#endif

//*********************************************************************************************************************


