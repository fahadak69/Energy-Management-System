int srvr6_thread_result = 0;
int srvr6_rwait_thread_result = 0;

sem_init (&srvr6_rdbk_sem,0,0);

//Declaring EMIO for PL_PS direct GPIO signal
system("echo 417 > /sys/class/gpio/export"); //For Server 6 modbus read data PS to PL indication into BRAM
system("echo out > /sys/class/gpio/gpio417/direction");//setting direction to output
system("echo 0 > /sys/class/gpio/gpio417/value");//init to zero

srvr6_rwait_thread_result = pthread_create(&mbsrvr6_rwait, NULL, mbsrvr6_rwait_thread, NULL);
if(srvr6_rwait_thread_result != 0)
{
   fprintf(stderr, "Could not Create Readback Wait Thread for Server 6!\n");
   exit(1);
}

srvr6_thread_result = pthread_create(&mbsrvr6, NULL, mbsrvr6_thread, NULL);
if(srvr6_thread_result != 0)
{
   fprintf(stderr, "Could not Create Thread for Server 6!\n");
   exit(1);
}

