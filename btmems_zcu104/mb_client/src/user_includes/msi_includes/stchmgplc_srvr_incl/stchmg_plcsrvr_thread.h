// *************************** MODBUS READ AND WRITE Code for STCH MG PLC Server *********************************************************************
//Note 1: For any testing with real Tesla powerpack, tesla doesnt allow polling by multiple clients and as such readback data for bess will come via PLC enbala interface

//Note 2: Necessary condition for two reasons, 1) to ensure bess_p_plw_offset doesnt contain garbage value or value from a previous
//control mode (as present in vadd_psddr memory location) 2) everytime a new dispatch setpoint comes in, we dont want to throw away
//the offset and hence the flag stays asserted as long as the mode is 3 and is cleared if mode is not 3

//Note 3: For heartbeat, we are using Function Code 22 (0X16) to do mask write. This only updates the bits for which bit position set to
//'0'in AND mask (bits position set to '1' in AND mask are not updated, regardless the value of corresponding bit in OR mask).
//If bit value needs to be '1'. set corresponding bit to '1' in OR mask, else set it to '0'in OR mask

// ------------------ STCH MG PLC Server Enbala Interface Heartbeat thread -----------------------
void* stchmgplc_hb_wthread (void* args)
{
	int plc_mbreg_wchk = 0;
	uint16_t plc_hb_regval = 2+4+32; //bit 1 Tesla En, bit 3 PV En, bit 5 is heartbeat toogle
	int rc[3];

    //********Creating context for PLC Modbus Server (Prosoft Card)
	ctx_plc = modbus_new_tcp(STCHMGPLC_SRVR_IP, STCHMGPLC_SRVR_MBPORT);
	modbus_set_debug(ctx_plc, STCHMGPLC_SRVR_DBG_MSG);

plc_mb_connec:
	if (modbus_connect(ctx_plc) == -1) {
		printf("PLC Modbus Server Connection Failed - Retrying\n");
		goto plc_mb_connec;
	}

//Heartbeat write to PLC Enbala Interface: Note 3

stchmgplc_hb:
	if (plc_hb_regval==38)
		plc_hb_regval 	= 0b0000000000000110;//setting heartbeat bit 5 to 0, also forcing tesla and PV enable to 1(ideally you should read back the value of this register first and only toggle bit 5 keeping other bits same)
	else
		plc_hb_regval 	= 0b0000000000100110;//setting heartbeat bit 5 to 1, also forcing tesla and PV enable to 1


	if (stchmgplc_wsig!=0)
		sem_wait(&stchmgplc_w_sem);


	pthread_mutex_lock(&stchmgplc_w);

		plc_mbreg_wchk =  modbus_mask_write_register(ctx_plc, 855, 0b1111111111011001 /*AND MASK*/, plc_hb_regval/*OR MASK*/);

	   //plc_mbreg_wchk = modbus_write_register(ctx_plc, 855, plc_hb_regval);

	   rc[0] = modbus_read_registers(ctx_plc, 6117, 9, server1_rregs_ptr);//Note 1

	   rc[1] = modbus_read_registers(ctx_plc, 6086, 2, plcsrvr_rregs_ptr);

#ifdef ENABLE_SERVER2_THREAD
	   rc[2] = modbus_read_registers(ctx_plc, 6126, 6, server2_rregs_ptr);
#endif

	pthread_mutex_unlock(&stchmgplc_w);


	if (rc[0] != 9)
	{
		printf("ERROR reading Tesla Data from PLC (%d) \n",rc[0]);
		modbus_close(ctx_plc);
		goto plc_mb_connec;
	}
	//sending signal to a waiting thread that read data has arrived
	sem_post(&srvr1_rdbk_sem);

	if (rc[1] != 2)
	{
		printf("ERROR reading kW Feedback from PLC (%d) \n",rc[1]);
		modbus_close(ctx_plc);
		goto plc_mb_connec;
	}

#ifdef ENABLE_ADER_PILOT
	atomic_store(&atomic_bess_output, *(plcsrvr_rregs_ptr)); //atomic operation to synchronize between read and write across different threads
	atomic_store(&atomic_genset_output, *(plcsrvr_rregs_ptr+1));
#endif

#ifdef ENABLE_SERVER2_THREAD
	if (rc[2] != 6)
	{
		printf("ERROR reading PV Data from PLC (%d) \n",rc[2]);
		modbus_close(ctx_plc);
		goto plc_mb_connec;
	}
	//sending signal to a waiting thread that read data has arrived
	sem_post(&srvr2_rdbk_sem);
#endif

	if (plc_mbreg_wchk == (-1))
	{
		printf("ERROR writing PLC heartbeat register (%d) \n", plc_mbreg_wchk);
		modbus_close(ctx_plc);
		goto plc_mb_connec;
	}
	usleep(250000); //250msec
	goto stchmgplc_hb; //continuous heartbeat toggle

	return 0;
}

// ------------------ STCH MG PLC Server Enbala Interface Tesla P Setpoint Command thread -----------------------

void* stchmgplc_teslaP_wthread (void* args)
{
	int stchmgplc_teslap_mbreg_wchk = 0;
	int16_t stchmgplc_teslaP_regval;
	int bess_p_plw = 0;
	int bess_p_plw_opt = 0;
	int bess_p_plw_offset = 0;
	float bess_p_flt = 0;

#ifdef ENABLE_ADER_PILOT
	int16_t aderp_besskw_sp = 0;
	int16_t aderp_bess_maxdisch;
#endif


stchmgplc_teslaP_loop:
	sem_wait(&stchmgplc_tesla_psem);

	pthread_mutex_lock(&stchmgplc_wsig_lck);
	stchmgplc_wsig++;
	pthread_mutex_unlock(&stchmgplc_wsig_lck);

	//BESS P command from PL
	/* COMMENTING OUT OPTIMIZATION ENGINE, NEEDS FIXING TO WORK WITH ADER PILOT
	if (usr_ctrl_mode==3) //BESS Dispatch Optimization
	{
		bess_p_plw_opt 		= bess_opt_p;
		bess_p_flt			= (bess_p_plw_opt);
		bess_p_plw			= bess_p_flt;

		if (pl_besssp_flg>0)//Note 2
		{
			bess_p_plw_offset 	= vadd_psddr[WCMD_PSDDR_OFFSET+1];
			bess_p_flt			= (bess_p_plw_offset/1000); //Changing to kW
			bess_p_plw_offset    = bess_p_flt;
			bess_p_plw			= bess_p_plw + bess_p_plw_offset;
			pl_besssp_flg       = 0;
		}

		//printf ("Optimization Dispatch %d\n",bess_p_plw);
	}*/
	//else
	//{
		bess_p_plw 			= vadd_psddr[WCMD_PSDDR_OFFSET+1];
		bess_p_flt			= (bess_p_plw/1000); //Changing to kW
		bess_p_plw			= bess_p_flt;
		//printf ("LF_PeakShav Dispatch %d\n",bess_p_plw);
	//}

	//*******************
	//here you can map commands received to specific MODBUS write registers for the device
#ifdef ENABLE_ADER_PILOT

	aderp_bess_maxdisch = (atomic_load(&atomic_bess_maxdschgpwr))/1000; //kw
	bess_p_plw = MY_MIN(MY_MAX((aderp_bess_maxdisch-100),0),bess_p_plw);//setting bess_p_plw (+ve discharge command) to zero if max available discharge is less than 100kW ERCOT reserve

	aderp_besskw_sp = OFFSET - mb_srvr_map->tab_registers[HLD_REG_TARGET_KW];//removing offset
	if (aderp_bess_chgflg)
		aderp_besskw_sp = -120;//-120kW charging power, with -20kW buffer to cover 85% RTE
	else if (aderp_besskw_sp>0) //discharge instruction
		aderp_besskw_sp = MY_MIN(aderp_besskw_sp,BESS_MAX_RSRV) + 1; //+1kW = 1kW  buffer for losses upto POI and any meter inaccuracies
	else if (aderp_besskw_sp<0) //charge instruction
		aderp_besskw_sp = MY_MAX(aderp_besskw_sp,-MAX_ERCOT_COMMIT); //MAX_ERCOT_COMMIT is redundant here as the upper limit of charge command from ERCOT is controlled by LPC limit
	else
		aderp_besskw_sp = 0;

	stchmgplc_teslaP_regval = bess_p_plw + aderp_besskw_sp;

#else
	stchmgplc_teslaP_regval = bess_p_plw;
#endif
	//**********************

	pthread_mutex_lock(&stchmgplc_w);
	stchmgplc_teslap_mbreg_wchk = modbus_write_register(ctx_plc, 852, (stchmgplc_teslaP_regval*10)); //10 is PLC scaling
	pthread_mutex_unlock(&stchmgplc_w);

	pthread_mutex_lock(&stchmgplc_wsig_lck);
	stchmgplc_wsig--;
	pthread_mutex_unlock(&stchmgplc_wsig_lck);

	if (stchmgplc_wsig==0)
		sem_post(&stchmgplc_w_sem);

    if (stchmgplc_teslap_mbreg_wchk == (-1))
    	printf("ERROR writing STCH MG PLC Tesla P Setpoint (%d)\n", stchmgplc_teslap_mbreg_wchk);

	goto stchmgplc_teslaP_loop;
	return 0;

}

// ------------------ STCH MG PLC Server Enbala Interface Genset P Setpoint Command thread -------------------


void* stchmgplc_gensetP_wthread (void* args)
{
	int stchmgplc_gensetp_mbreg_wchk1 = 0;
	int stchmgplc_gensetp_mbreg_wchk2 = 0;
	int16_t stchmgplc_gensetP_regval;
	uint16_t genset_enable;
	uint16_t genset_ramp_flg=0;
	unsigned int aderp_bess_maxdschgpwr;
	uint16_t aderp_bess_maxdschgpwr_16b;


#ifdef ENABLE_ADER_PILOT
	int16_t aderp_gensetkw_sp = 0;
#endif

stchmgplc_gensetP_loop:
	sem_wait(&stchmgplc_genset_psem);

stchmgplc_gensetP_ramp:

	pthread_mutex_lock(&stchmgplc_wsig_lck);
	stchmgplc_wsig++;
	pthread_mutex_unlock(&stchmgplc_wsig_lck);

#ifdef ENABLE_ADER_PILOT
	aderp_bess_maxdschgpwr = (atomic_load(&atomic_bess_maxdschgpwr))/1000; //kw
	aderp_bess_maxdschgpwr_16b = aderp_bess_maxdschgpwr;
	aderp_gensetkw_sp = OFFSET - mb_srvr_map->tab_registers[HLD_REG_TARGET_KW] - MY_MIN(aderp_bess_maxdschgpwr_16b,BESS_MAX_RSRV);//removing offset

	if (aderp_gensetkw_sp>0)
	{
		aderp_gensetkw_sp = MY_MIN(aderp_gensetkw_sp,GENSET_MAX_RSRV);
		stchmgplc_gensetP_regval = 0 + (aderp_gensetkw_sp*10); //10 is scaling required by PLC
		genset_enable = 0b0000000000001000; //setting mask bit to 1 for Genset Enable (see Note 3)
	}
	else
	{
		stchmgplc_gensetP_regval = 0;
		genset_enable = 0b0000000000000000; //setting mask bit to 0 for Genset Enable
	}
#else
	stchmgplc_gensetP_regval = 0;//placeholder
#endif

	pthread_mutex_lock(&stchmgplc_w);
	if ((stchmgplc_gensetP_regval<500) ||  (genset_ramp_flg==1) )//50kW with x10 scaling
	{
		genset_ramp_flg = 0;
		stchmgplc_gensetp_mbreg_wchk1 = modbus_write_register(ctx_plc, 853, stchmgplc_gensetP_regval);
		stchmgplc_gensetp_mbreg_wchk2 = modbus_mask_write_register(ctx_plc, 855, 0b1111111111110111 /*AND MASK*/, genset_enable/*OR MASK*/);

	}
	else
	{
		genset_ramp_flg = 1;
		stchmgplc_gensetp_mbreg_wchk1 = modbus_write_register(ctx_plc, 853, 500); //sending 50kW only in first step
		stchmgplc_gensetp_mbreg_wchk2 = modbus_mask_write_register(ctx_plc, 855, 0b1111111111110111 /*AND MASK*/, genset_enable/*OR MASK*/);
	}


	//stchmgplc_gensetp_mbreg_wchk2 = modbus_write_register(ctx_plc, 855, genset_enable);
	pthread_mutex_unlock(&stchmgplc_w);

	pthread_mutex_lock(&stchmgplc_wsig_lck);
	stchmgplc_wsig--;
	pthread_mutex_unlock(&stchmgplc_wsig_lck);

	if (stchmgplc_wsig==0)
		sem_post(&stchmgplc_w_sem);

    if (stchmgplc_gensetp_mbreg_wchk1 == (-1))
    	printf("ERROR writing STCH MG PLC Genset P Setpoint (%d)\n", stchmgplc_gensetp_mbreg_wchk1);
    if (stchmgplc_gensetp_mbreg_wchk2 == (-1))
    	printf("ERROR writing STCH MG PLC Genset Enable (%d)\n", stchmgplc_gensetp_mbreg_wchk2);

    if (genset_ramp_flg==1)
    {
    	usleep (20000000); //20sec delay
    	goto stchmgplc_gensetP_ramp; //re-triggering the thread for 2nd part of the ramp
    }


	goto stchmgplc_gensetP_loop;
	return 0;

}

// ------------------ STCH MG PLC Server Enbala Interface PV P Setpoint Command thread -----------------------

void* stchmgplc_pvP_wthread (void* args)

{
	int stchmgplc_pvp_mbreg_wchk = 0;
	int16_t stchmgplc_pvP_regval;
	int pv_p_plw = 0;
	float pv_p_flt = 0;

stchmgplc_pvP_loop:
	sem_wait(&stchmgplc_pv_psem);

	pthread_mutex_lock(&stchmgplc_wsig_lck);
	stchmgplc_wsig++;
	pthread_mutex_unlock(&stchmgplc_wsig_lck);

	//PV P command from PL
	pv_p_plw 			= vadd_psddr[WCMD_PSDDR_OFFSET+6];
	pv_p_flt			= (pv_p_plw/100); //Changing to kW with x10 scaling (10/1000)
	pv_p_plw			= pv_p_flt;


	//**************************
	//***here you can map commands received to specific MODBUS write registers for the device***
	stchmgplc_pvP_regval = pv_p_plw;
	//****************************

	pthread_mutex_lock(&stchmgplc_w);
	stchmgplc_pvp_mbreg_wchk = modbus_write_register(ctx_plc, 851, stchmgplc_pvP_regval);
	pthread_mutex_unlock(&stchmgplc_w);

	pthread_mutex_lock(&stchmgplc_wsig_lck);
	stchmgplc_wsig--;
	pthread_mutex_unlock(&stchmgplc_wsig_lck);

	if (stchmgplc_wsig==0)
		sem_post(&stchmgplc_w_sem);

    if (stchmgplc_pvp_mbreg_wchk == (-1))
    	printf("ERROR writing STCH MG PLC PV P Setpoint (%d)\n", stchmgplc_pvp_mbreg_wchk);

	goto stchmgplc_pvP_loop;
	return 0;
}

