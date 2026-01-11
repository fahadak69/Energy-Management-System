int srvr3_thread_result = 0;
int srvr3_rwait_thread_result = 0;

sem_init (&srvr3_rdbk_sem,0,0);

//Declaring EMIO for PL_PS direct GPIO signal
system("echo 414 > /sys/class/gpio/export"); //For Server 3 modbus read data PS to PL indication into BRAM
system("echo out > /sys/class/gpio/gpio414/direction");//setting direction to output
system("echo 0 > /sys/class/gpio/gpio414/value");//init to zero

srvr3_rwait_thread_result = pthread_create(&mbsrvr3_rwait, NULL, mbsrvr3_rwait_thread, NULL);
if(srvr3_rwait_thread_result != 0)
{
   fprintf(stderr, "Could not Create Readback Wait Thread for Server 3!\n");
   exit(1);
}

srvr3_thread_result = pthread_create(&mbsrvr3, NULL, mbsrvr3_thread, NULL);
if(srvr3_thread_result != 0)
{
	fprintf(stderr, "Could not Create Thread for Server 3!\n");
	exit(1);
}



