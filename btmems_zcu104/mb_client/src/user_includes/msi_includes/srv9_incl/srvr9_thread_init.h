int srvr9_thread_result = 0;
int srvr9_rwait_thread_result = 0;

sem_init (&srvr9_rdbk_sem,0,0);

//Declaring EMIO for PL_PS direct GPIO signal
system("echo 422 > /sys/class/gpio/export"); //For Server 9 modbus read data PS to PL indication into BRAM
system("echo out > /sys/class/gpio/gpio422/direction");//setting direction to output
system("echo 0 > /sys/class/gpio/gpio422/value");//init to zero

srvr9_rwait_thread_result = pthread_create(&mbsrvr9_rwait, NULL, mbsrvr9_rwait_thread, NULL);
if(srvr9_rwait_thread_result != 0)
{
   fprintf(stderr, "Could not Create Readback Wait Thread for Server 9!\n");
   exit(1);
}

srvr9_thread_result = pthread_create(&mbsrvr9, NULL, mbsrvr9_thread, NULL);
if(srvr9_thread_result != 0)
{
   fprintf(stderr, "Could not Create Thread for Server 9!\n");
   exit(1);
}

