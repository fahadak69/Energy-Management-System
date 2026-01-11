int srvr7_thread_result = 0;
int srvr7_rwait_thread_result = 0;

sem_init (&srvr7_rdbk_sem,0,0);

//Declaring EMIO for PL_PS direct GPIO signal
system("echo 420 > /sys/class/gpio/export"); //For Server 7 modbus read data PS to PL indication into BRAM
system("echo out > /sys/class/gpio/gpio420/direction");//setting direction to output
system("echo 0 > /sys/class/gpio/gpio420/value");//init to zero

srvr7_rwait_thread_result = pthread_create(&mbsrvr7_rwait, NULL, mbsrvr7_rwait_thread, NULL);
if(srvr7_rwait_thread_result != 0)
{
   fprintf(stderr, "Could not Create Readback Wait Thread for Server 7!\n");
   exit(1);
}

srvr7_thread_result = pthread_create(&mbsrvr7, NULL, mbsrvr7_thread, NULL);
if(srvr7_thread_result != 0)
{
   fprintf(stderr, "Could not Create Thread for Server 7!\n");
   exit(1);
}

