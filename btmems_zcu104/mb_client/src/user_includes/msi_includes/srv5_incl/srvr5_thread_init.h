int srvr5_thread_result = 0;
int srvr5_rwait_thread_result = 0;
int srvr5_wthread_result = 0;
int srvr5_wthread_brkopresult = 0;
int srvr5_wthread_brkclresult = 0;

sem_init (&srvr5_rdbk_sem,0,0);
sem_init (&srvr5_rw_sem,0,0);
sem_init (&srvr5_wcmd_sem,0,0);
sem_init (&srvr5_wcmd_brkopsem,0,0);
sem_init (&srvr5_wcmd_brkclsem,0,0);

//Declaring EMIO for PL_PS direct GPIO signal
system("echo 416 > /sys/class/gpio/export"); //For Server 5 modbus read data PS to PL indication into BRAM
system("echo out > /sys/class/gpio/gpio416/direction");//setting direction to output
system("echo 0 > /sys/class/gpio/gpio416/value");//init to zero

srvr5_rwait_thread_result = pthread_create(&mbsrvr5_rwait, NULL, mbsrvr5_rwait_thread, NULL);
if(srvr5_rwait_thread_result != 0)
{
   fprintf(stderr, "Could not Create Readback Wait Thread for Server 5!\n");
   exit(1);
}

srvr5_thread_result = pthread_create(&mbsrvr5, NULL, mbsrvr5_thread, NULL);
if(srvr5_thread_result != 0)
{
   fprintf(stderr, "Could not Create Thread for Server 5!\n");
   exit(1);
}


//******************Write Command Threads for Server 5 (Relay)***********************************************
srvr5_wthread_brkopresult = pthread_create(&mbsrvr5_brkop_w, NULL, mbsrvr5_brkop_wthread, NULL);
if(srvr5_wthread_brkopresult != 0)
{
   fprintf(stderr, "Could not Create Breaker Open Write Thread for Server 5!\n");
   exit(1);
}

srvr5_wthread_brkclresult = pthread_create(&mbsrvr5_brkcl_w, NULL, mbsrvr5_brkcl_wthread, NULL);
if(srvr5_wthread_brkclresult != 0)
{
   fprintf(stderr, "Could not Create Breaker Close Write Thread for Server 5!\n");
   exit(1);
}
//*********************************************************************************************************************

srvr5_wthread_result = pthread_create(&mbsrvr5_w, NULL, mbsrvr5_wthread, NULL);
if(srvr5_wthread_result != 0)
{
   fprintf(stderr, "Could not Create Write Thread for Server 5!\n");
   exit(1);
}

