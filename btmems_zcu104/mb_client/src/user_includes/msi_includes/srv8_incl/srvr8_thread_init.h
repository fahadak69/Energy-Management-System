int srvr8_thread_result = 0;
int srvr8_rwait_thread_result = 0;

sem_init (&srvr8_rdbk_sem,0,0);

//Declaring EMIO for PL_PS direct GPIO signal
system("echo 421 > /sys/class/gpio/export"); //For Server 8 modbus read data PS to PL indication into BRAM
system("echo out > /sys/class/gpio/gpio421/direction");//setting direction to output
system("echo 0 > /sys/class/gpio/gpio421/value");//init to zero

srvr8_rwait_thread_result = pthread_create(&mbsrvr8_rwait, NULL, mbsrvr8_rwait_thread, NULL);
if(srvr8_rwait_thread_result != 0)
{
   fprintf(stderr, "Could not Create Readback Wait Thread for Server 8!\n");
   exit(1);
}

srvr8_thread_result = pthread_create(&mbsrvr8, NULL, mbsrvr8_thread, NULL);
if(srvr8_thread_result != 0)
{
   fprintf(stderr, "Could not Create Thread for Server 8!\n");
   exit(1);
}

