int srvr4_thread_result = 0;
int srvr4_rwait_thread_result = 0;
int srvr4_wthread_result = 0;
int srvr4_wthread_presult = 0;
int srvr4_wthread_qresult = 0;
int srvr4_wthread_runresult = 0;
int srvr4_wthread_opermoderesult = 0;

sem_init (&srvr4_rdbk_sem,0,0);
sem_init (&srvr4_rw_sem,0,0);
sem_init (&srvr4_wcmd_sem,0,0);
sem_init (&srvr4_wcmd_psem,0,0);
sem_init (&srvr4_wcmd_qsem,0,0);
sem_init (&srvr4_wcmd_runsem,0,0);
sem_init (&srvr4_wcmd_opermodesem,0,0);


//Declaring EMIO for PL_PS direct GPIO signal
system("echo 415 > /sys/class/gpio/export"); //For Server 4 modbus read data PS to PL indication into BRAM
system("echo out > /sys/class/gpio/gpio415/direction");//setting direction to output
system("echo 0 > /sys/class/gpio/gpio415/value");//init to zero

srvr4_rwait_thread_result = pthread_create(&mbsrvr4_rwait, NULL, mbsrvr4_rwait_thread, NULL);
if(srvr4_rwait_thread_result != 0)
{
   fprintf(stderr, "Could not Create Readback Wait Thread for Server 4!\n");
   exit(1);
}

srvr4_thread_result = pthread_create(&mbsrvr4, NULL, mbsrvr4_thread, NULL);
if(srvr4_thread_result != 0)
{
   fprintf(stderr, "Could not Create Thread for Server 4!\n");
   exit(1);
}


//******************Write Command Threads for Server 4 (Genset)***********************************************
srvr4_wthread_runresult = pthread_create(&mbsrvr4_run_w, NULL, mbsrvr4_run_wthread, NULL);
if(srvr4_wthread_runresult != 0)
{
   fprintf(stderr, "Could not Create Run Write Thread for Server 4!\n");
   exit(1);
}

srvr4_wthread_presult = pthread_create(&mbsrvr4_p_w, NULL, mbsrvr4_p_wthread, NULL);
if(srvr4_wthread_presult != 0)
{
   fprintf(stderr, "Could not Create P Write Thread for Server 4!\n");
   exit(1);
}

srvr4_wthread_qresult = pthread_create(&mbsrvr4_q_w, NULL, mbsrvr4_q_wthread, NULL);
if(srvr4_wthread_qresult != 0)
{
   fprintf(stderr, "Could not Create Q Write Thread for Server 4!\n");
   exit(1);
}

srvr4_wthread_opermoderesult = pthread_create(&mbsrvr4_opermode_w, NULL, mbsrvr4_opermode_wthread, NULL);
if(srvr4_wthread_opermoderesult != 0)
{
   fprintf(stderr, "Could not Create Operating Mode Write Thread for Server 4!\n");
   exit(1);
}

//*********************************************************************************************************************

srvr4_wthread_result = pthread_create(&mbsrvr4_w, NULL, mbsrvr4_wthread, NULL);
if(srvr4_wthread_result != 0)
{
   fprintf(stderr, "Could not Create Write Thread for Server 4!\n");
   exit(1);
}

