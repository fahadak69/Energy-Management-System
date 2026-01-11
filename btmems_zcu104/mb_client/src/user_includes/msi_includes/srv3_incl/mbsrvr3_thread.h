// *************************** MODBUS READ Code for Server 2 - Modify as required *********************************************************************

//------ Thread waiting for server 3 read data to arrive -------------------
void* mbsrvr3_rwait_thread (void* args)
{
	int meter_poi_3s_plr;
	int meter_poi_pf_plr;
	int meter_poi_ia_plr;
	int meter_poi_ib_plr;
	int meter_poi_ic_plr;
	int meter_poi_in_plr;
	int meter_poi_vab_plr;
	int meter_poi_vbc_plr;
	int meter_poi_vca_plr;
	int meter_poi_freq_plr;

	float meter_poi_freq_flt;
	float meter_poi_ia_flt;
	float meter_poi_ib_flt;
	float meter_poi_ic_flt;
	float meter_poi_in_flt;
	float meter_poi_3p_flt;
	float meter_poi_3q_flt;
	float meter_poi_3s_flt;
	float meter_poi_pf_flt;
	float meter_poi_vab_flt;
	float meter_poi_vbc_flt;
	float meter_poi_vca_flt;

	float meter_genset_3p_flt;
	float meter_genset_3q_flt;
	float meter_bess_3p_flt;
	float meter_bess_3q_flt;

	int meter_poi_vs_plr;
	float meter_poi_vs_flt;

	int16_t meter_poi_3p_plr_16;


	srvr3_rdbk_waitloop:
	//waiting for server 3 readback data to arrive
	sem_wait(&srvr3_rdbk_sem);

	//***********************************************************
	//here you can map modbus read register data to fpga msi interface signals for this server

	//***********************************************************


#if defined(EIT_TESLA_MEGAPACK) || defined (STCH_MG_ACTUAL_EIT_HIL_HYBRID)
	meter_poi_ia_plr 			= (*(server3_rregs_ptr)) << 16;
	meter_poi_ia_plr   			= meter_poi_ia_plr | (*(server3_rregs_ptr+1));
	meter_poi_ia_plr			= meter_poi_ia_plr/100;

	meter_poi_ib_plr 			= (*(server3_rregs_ptr+2)) << 16;
	meter_poi_ib_plr   			= meter_poi_ib_plr | (*(server3_rregs_ptr+3));
	meter_poi_ib_plr			= meter_poi_ib_plr/100;

	meter_poi_ic_plr 			= (*(server3_rregs_ptr+4)) << 16;
	meter_poi_ic_plr   			= meter_poi_ic_plr | (*(server3_rregs_ptr+5));
	meter_poi_ic_plr			= meter_poi_ic_plr/100;

	meter_poi_in_plr 			= (*(server3_rregs_ptr+6)) << 16;
	meter_poi_in_plr   			= meter_poi_in_plr | (*(server3_rregs_ptr+7));
	meter_poi_in_plr			= meter_poi_in_plr/100;

	//POI voltage reading from the meter going to PL should be scaled by x100. If not already scaled in the meter, scale it here
	meter_poi_vab_plr 		= (*(server3_rregs_ptr+8)) << 16;
	meter_poi_vab_plr   	= meter_poi_vab_plr | (*(server3_rregs_ptr+9));

	meter_poi_vbc_plr 		= (*(server3_rregs_ptr+10)) << 16;
	meter_poi_vbc_plr   	= meter_poi_vbc_plr | (*(server3_rregs_ptr+11));

	meter_poi_vca_plr 		= (*(server3_rregs_ptr+12)) << 16;
	meter_poi_vca_plr   	= meter_poi_vca_plr | (*(server3_rregs_ptr+13));


	meter_poi_3p_plr 		= (*(server3_rregs_ptr+14)) << 16;
	meter_poi_3p_plr   		= meter_poi_3p_plr | (*(server3_rregs_ptr+15));
	meter_poi_3p_plr		= (meter_poi_3p_plr*10);

	meter_poi_pf_plr		= 100;

	meter_poi_3s_plr 		= (*(server3_rregs_ptr+16)) << 16;
	meter_poi_3s_plr   		= meter_poi_3s_plr | (*(server3_rregs_ptr+17));
	meter_poi_3s_plr		= (meter_poi_3s_plr/100);

	meter_poi_3q_plr 		= (*(server3_rregs_ptr+18)) << 16;
	meter_poi_3q_plr   		= meter_poi_3q_plr | (*(server3_rregs_ptr+19));
	meter_poi_3q_plr		= (meter_poi_3q_plr/100);

	//POI frequency reading from the meter going to PL should be scaled by x100. If not already scaled in the meter, scale it here
	meter_poi_freq_plr  = (*(server3_rregs_ptr+20));

	meter_poi_vs_plr 	= 48000;


#else
	/* Use this block if you instead want to read POI data from PLC Enbala Interface (only kW is available)
	//POI frequency reading from the meter going to PL should be scaled by x100. If not already scaled in the meter, scale it here
	meter_poi_freq_plr 	= 6000;

	meter_poi_ia_plr 	= 0;

	meter_poi_ib_plr 	= 0;

	meter_poi_ic_plr 	= 0;

	meter_poi_in_plr 	= 0;

	meter_poi_3p_plr_16 	= (*server3_rregs_ptr);
	meter_poi_3p_plr		= meter_poi_3p_plr_16; //converting 16bit into to 32bit int
	meter_poi_3p_plr    	= meter_poi_3p_plr*10; //scaling factor

	meter_poi_pf_plr 	= 100;

	meter_poi_3q_plr 	= 0;

	meter_poi_3s_plr 	= meter_poi_3p_plr;


	//POI voltage reading from the meter going to PL should be scaled by x100. If not already scaled in the meter, scale it here
	meter_poi_vab_plr 	= 48000;

	meter_poi_vbc_plr 	= 48000;

	meter_poi_vca_plr 	= 48000;

	meter_poi_vs_plr 	= 48000;*/

	meter_genset_3p_flt 	= combineRegistersToFloat(server3_rregs_ptr);
	meter_genset_3p_flt		= meter_genset_3p_flt*1000;
	meter_genset_3p_plr    	= meter_genset_3p_flt;

	meter_genset_3q_flt 	= combineRegistersToFloat(server3_rregs_ptr+4);
	meter_genset_3q_flt		= meter_genset_3q_flt*1000;
	meter_genset_3q_plr    	= meter_genset_3q_flt;

	meter_bess_3p_flt 		= combineRegistersToFloat(server3_rregs_ptr+6);
	meter_bess_3p_flt		= meter_bess_3p_flt*1000;
	meter_bess_3p_plr    	= meter_bess_3p_flt;

	meter_bess_3q_flt 		= combineRegistersToFloat(server3_rregs_ptr+10);
	meter_bess_3q_flt		= meter_bess_3q_flt*1000;
	meter_bess_3q_plr    	= meter_bess_3q_flt;


	//POI frequency reading from the meter going to PL should be scaled by x100. If not already scaled in the meter, scale it here
	meter_poi_freq_flt 	= combineRegistersToFloat(server3_rregs_ptr+12);
	meter_poi_freq_flt  = (meter_poi_freq_flt*100);
	meter_poi_freq_plr  = meter_poi_freq_flt; //note that _plr  needs to be int, if its uint, float to int conversion will drop the sign

	meter_poi_ia_flt 	= combineRegistersToFloat(server3_rregs_ptr+16);
	meter_poi_ia_plr	= meter_poi_ia_flt;

	meter_poi_ib_flt 	= combineRegistersToFloat(server3_rregs_ptr+20);
	meter_poi_ib_plr	= meter_poi_ib_flt;

	meter_poi_ic_flt 	= combineRegistersToFloat(server3_rregs_ptr+24);
	meter_poi_ic_plr	= meter_poi_ic_flt;

	meter_poi_in_flt 	= combineRegistersToFloat(server3_rregs_ptr+28);
	meter_poi_in_plr	= meter_poi_in_flt;

	meter_poi_3p_flt 	= combineRegistersToFloat(server3_rregs_ptr+30);
	meter_poi_3p_flt	= meter_poi_3p_flt*1000;
	meter_poi_3p_plr    = meter_poi_3p_flt*(-1);//sign is flipped coming from PLC

	meter_poi_pf_flt 	= combineRegistersToFloat(server3_rregs_ptr+32);
	meter_poi_pf_flt    = meter_poi_pf_flt*100;
	meter_poi_pf_plr	= meter_poi_pf_flt;

	meter_poi_3q_flt 	= combineRegistersToFloat(server3_rregs_ptr+34);
	meter_poi_3q_flt	= meter_poi_3q_flt*1000;
	meter_poi_3q_plr    = meter_poi_3q_flt;

	meter_poi_3s_flt 	= combineRegistersToFloat(server3_rregs_ptr+36);
	meter_poi_3s_flt	= meter_poi_3s_flt*1000;
	meter_poi_3s_plr    = meter_poi_3s_flt;


	//POI voltage reading from the meter going to PL should be scaled by x100. If not already scaled in the meter, scale it here
	meter_poi_vab_flt 	= combineRegistersToFloat(server3_rregs_ptr+40);
	meter_poi_vab_flt   = meter_poi_vab_flt*100;
	meter_poi_vab_plr	= meter_poi_vab_flt;

	meter_poi_vbc_flt 	= combineRegistersToFloat(server3_rregs_ptr+44);
	meter_poi_vbc_flt   = meter_poi_vbc_flt*100;
	meter_poi_vbc_plr	= meter_poi_vbc_flt;

	meter_poi_vca_flt 	= combineRegistersToFloat(server3_rregs_ptr+48);
	meter_poi_vca_flt   = meter_poi_vca_flt*100;
	meter_poi_vca_plr	= meter_poi_vca_flt;

	meter_poi_vs_flt 	= combineRegistersToFloat(server3_rregs_ptr+52);
	meter_poi_vs_flt   = meter_poi_vs_flt*100;
	meter_poi_vs_plr	= meter_poi_vs_flt;

#endif

	//--------------- Writing Data to PS DDR --------------------------------------------

	  //POI Active Power
	  //printf ("Meter POI 3P %d \n",meter_poi_3p_plr);
	  vadd_psddr[SRVR3_READ_PSDDR_OFFSET] = meter_poi_3p_plr;

	  //POI Reactive Power
	  //printf ("Meter POI 3Q %d \n",meter_poi_3q_plr);
	  vadd_psddr[SRVR3_READ_PSDDR_OFFSET+1] = meter_poi_3q_plr;

	  //POI Apparent Power
	  //printf ("Meter POI 3S %d \n",meter_poi_3s_plr);
	  vadd_psddr[SRVR3_READ_PSDDR_OFFSET+2] = meter_poi_3s_plr;

	  //POI PF
	  //printf ("Meter POI PF %d \n",meter_poi_pf_plr);
	  vadd_psddr[SRVR3_READ_PSDDR_OFFSET+3] = meter_poi_pf_plr;

	  //POI Phase A Current
	  //printf ("Meter POI Ia %d \n",meter_poi_ia_plr);
	  vadd_psddr[SRVR3_READ_PSDDR_OFFSET+4] = meter_poi_ia_plr;

	  //POI Phase B Current
	  //printf ("Meter POI Ib %d \n",meter_poi_ib_plr);
	  vadd_psddr[SRVR3_READ_PSDDR_OFFSET+5] = meter_poi_ib_plr;

	  //POI Phase C Current
	  //printf ("Meter POI Ic %d \n",meter_poi_ic_plr);
	  vadd_psddr[SRVR3_READ_PSDDR_OFFSET+6] = meter_poi_ic_plr;

	  //POI Neutral Current
	  //printf ("Meter POI In %d \n",meter_poi_in_plr);
	  vadd_psddr[SRVR3_READ_PSDDR_OFFSET+7] = meter_poi_in_plr;

	  //POI VAB
	  //printf ("Meter POI Vab %d \n",meter_poi_vab_plr);
	  vadd_psddr[SRVR3_READ_PSDDR_OFFSET+8] = meter_poi_vab_plr;

	  //POI VBC
	  //printf ("Meter POI Vbc %d \n",meter_poi_vbc_plr);
	  vadd_psddr[SRVR3_READ_PSDDR_OFFSET+9] = meter_poi_vbc_plr;

	  //POI VCA
	  //printf ("Meter POI Vca %d \n",meter_poi_vca_plr);
	  vadd_psddr[SRVR3_READ_PSDDR_OFFSET+10] = meter_poi_vca_plr;

	  //POI Frequency
	  //printf ("Meter POI Freq %d \n",meter_poi_freq_plr);
	  vadd_psddr[SRVR3_READ_PSDDR_OFFSET+11] = meter_poi_freq_plr;


	//request CDMA transfer
	reacquire_srvr3_rmutex:
	pthread_mutex_lock(&mutex_cdma_trnsf);
	if (cdma_trnsf_chk==TRUE)
	{
		pthread_mutex_unlock(&mutex_cdma_trnsf);
		goto reacquire_srvr3_rmutex;
	}
	cdma_trnsf_chk = TRUE;

	//Requesting CDMA transfer
	cdma_src_addr = PSDDR_PBASE + (SRVR3_READ_PSDDR_OFFSET*0x4);
    cdma_dest_addr = BRAM_PBASE + (SRVR3_READ_BRAM_OFFSET*0x4);
    cdma_trnsf_length = 0x30; //32bit*12locations = 48bytes. Note Max space reserved is 32bit*40locations = 160bytes

	pthread_cond_signal(&cond_cdma_trnsf);
	pthread_mutex_unlock(&mutex_cdma_trnsf);

#ifdef ENABLE_ADER_PILOT
	//signal ader pilot thread about new meter data
	sem_post(&aderpilot_mbsrvr_sem);
#endif

	//loop back to wait state.
	goto srvr3_rdbk_waitloop;

	return 0;
}

// ------------------ Server3 MODBUS polling thread -----------------------
void* mbsrvr3_thread (void* args)
{
	//Server 3 variable initialization
	int rc[3];
	ctx_srvr3 = modbus_new_tcp(SERVER3_IP, SERVER3_MBPORT);
	modbus_set_debug(ctx_srvr3, SERVER3_DBG_MSG);

server3_mb_connec:
	if (modbus_connect(ctx_srvr3) == -1) {
		printf("Modbus Server 3 Connection Failed - Retrying\n");
		goto server3_mb_connec;
	}

server3_mb_read:

#if defined (EIT_TESLA_MEGAPACK) || defined (STCH_MG_ACTUAL_EIT_HIL_HYBRID)
	/*reading multiple registers values*/
	rc[0] = modbus_read_registers(ctx_srvr3,SERVER3_START_RADDR, SERVER3_NREAD_REGS, server3_rregs_ptr);
	if (rc[0] != 21)
#else
	/*reading multiple registers values*/
	rc[0] = modbus_read_input_registers(ctx_srvr3,186, 6, server3_rregs_ptr);//genset watt,pf,var
	rc[1] = modbus_read_input_registers(ctx_srvr3,270, 6, (server3_rregs_ptr+6));//Tesla watt,pf,var
	rc[2] = modbus_read_input_registers(ctx_srvr3,SERVER3_START_RADDR, 42/*(SERVER3_NREAD_REGS-4)*/, (server3_rregs_ptr+12));
	if ((rc[0] != 6) || (rc[1] != 6) || (rc[2] != 42))
#endif

	{
		printf("ERROR Reading Server 3 Registers - Re-establishing Connection %d \n",rc);
		modbus_close(ctx_srvr3);
		goto server3_mb_connec;
	}

	//sending signal to a waiting thread that read data has arrived
	sem_post(&srvr3_rdbk_sem);

	usleep(500000); //250msec, if polling is done faster, comms sometimes fails with axion rtac
	goto server3_mb_read; //continuous read

	return 0;
}
