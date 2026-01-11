int plc_hb_thread_result = 0;
int plc_teslaP_thread_result = 0;
int plc_gensetP_thread_result = 0;
int plc_pvP_thread_result = 0;

plc_hb_thread_result = pthread_create(&mbplc_hb, NULL, stchmgplc_hb_wthread, NULL);
if(plc_hb_thread_result != 0)
{
	fprintf(stderr, "Could not Create PLC Heartbeat Thread!\n");
	exit(1);
}

plc_teslaP_thread_result = pthread_create(&mbplc_teslaP, NULL, stchmgplc_teslaP_wthread, NULL);
if(plc_teslaP_thread_result != 0)
{
	fprintf(stderr, "Could not Create PLC Tesla P Setpoint Thread!\n");
	exit(1);
}

plc_gensetP_thread_result = pthread_create(&mbplc_gensetP, NULL, stchmgplc_gensetP_wthread, NULL);
if(plc_gensetP_thread_result != 0)
{
	fprintf(stderr, "Could not Create PLC Genset P Setpoint Thread!\n");
	exit(1);
}

plc_pvP_thread_result = pthread_create(&mbplc_pvP, NULL, stchmgplc_pvP_wthread, NULL);
if(plc_pvP_thread_result != 0)
{
	fprintf(stderr, "Could not Create PLC PV P Setpoint Thread!\n");
	exit(1);
}


