// NOTES:
//1: We are displaying maximum capacity in each direction, assumption is SCED wont dispatch us more than committed amount (even if we can
//do more)

//2: Improve this logic to account for genset faults (for BESS its easier as max avail disch power goes to zero)

//3: No need to use atomic here because this thread and server3 thread is synced due to use of sempahore "aderpilot_mbsrvr_sem"

void* ader_pilot_thread (void* args) {

int aderp_meter_aggr_3p;
int aderp_meter_aggr_3q;
int aderp_meter_poi_3p;

int aderp_meter_genset_3p;
int aderp_meter_genset_3q;
int aderp_meter_bess_3p;
int aderp_meter_bess_3q;

int16_t aderp_bess_output;
int16_t aderp_genset_output;

unsigned int aderp_bess_maxdschgpwr;
unsigned int aderp_bess_maxchgpwr;
unsigned int aderp_bess_socr;

uint16_t aderp_poi_cbstat;
uint16_t aderp_mgmain_cbstat;

uint16_t aderp_bess_maxdschgpwr_16b;
uint16_t aderp_bess_maxchgpwr_16b;
int16_t aderp_meter_poi_3p_16b;
uint16_t mpc_lmt;

time_t current_time;
struct tm *local_time;


aderpilot_mbsrvr_update:
sem_wait(&aderpilot_mbsrvr_sem);


aderp_meter_poi_3p	= meter_poi_3p_plr/1000; //kw Note 3


aderp_meter_genset_3p	= meter_genset_3p_plr/1000; //kw Note 3
aderp_meter_genset_3q	= meter_genset_3q_plr/1000; //kvar

aderp_meter_bess_3p	= meter_bess_3p_plr/1000; //kw Note 3
aderp_meter_bess_3q	= meter_bess_3q_plr/1000; //kvar


aderp_meter_aggr_3p	= (aderp_meter_genset_3p + aderp_meter_bess_3p)*(-1);//kw, also switching to utility sign convention
aderp_meter_aggr_3q	= (aderp_meter_genset_3q + aderp_meter_bess_3q)*(-1);//kvar

/*printf ("BESS 3P KW %d\n",aderp_meter_bess_3p);
printf ("BESS 3Q KW %d\n",aderp_meter_bess_3q);
printf ("GENSET 3P KW %d\n",aderp_meter_genset_3p);
printf ("GENSET 3Q KW %d\n",aderp_meter_genset_3q);
printf ("AGGR 3P KW %d\n",aderp_meter_aggr_3p);
printf ("AGGR 3Q KW %d\n",aderp_meter_aggr_3q);*/

aderp_bess_maxdschgpwr = (atomic_load(&atomic_bess_maxdschgpwr))/1000; //kw
aderp_bess_maxchgpwr = (atomic_load(&atomic_bess_maxchgpwr))/1000; //kw
aderp_bess_socr = (atomic_load(&atomic_bess_socr)); //%



/*aderp_bess_output 	= (atomic_load(&atomic_bess_output))*0.01; //kw
aderp_genset_output = (atomic_load(&atomic_genset_output))*0.01; //kw*/

aderp_poi_cbstat = atomic_load(&atomic_poi_cbstat);
aderp_mgmain_cbstat = atomic_load(&atomic_mgmain_cbstat);

aderp_bess_maxdschgpwr_16b = aderp_bess_maxdschgpwr;
aderp_bess_maxchgpwr_16b = aderp_bess_maxchgpwr;
aderp_meter_poi_3p_16b = aderp_meter_poi_3p;


//MPC Limit calculation:
if (aderp_bess_socr>=60)//approx. 600kWh = 400kWh (100kw*4hr committment) + 200kWh buffer to absorb load swings, dont want to charge too much to avoid degradaiton
	mpc_lmt = OFFSET;//setting it to OFFSET effectively prevents ERCOT from sending charge setpoint
else if (aderp_bess_socr<=40)
	mpc_lmt = OFFSET + MY_MIN(MY_MIN(295-aderp_meter_poi_3p_16b-aderp_meter_bess_3p-aderp_meter_genset_3p,aderp_bess_maxchgpwr_16b),200);//max BESS chg will be limited to 200kW
else
	mpc_lmt = OFFSET;


//Register Assignment
mb_srvr_map->tab_registers[HLD_REG_AGGR_KW] = OFFSET + aderp_meter_aggr_3p; //1000 is offset for ercot
mb_srvr_map->tab_registers[HLD_REG_AGGR_KVAR] = OFFSET + aderp_meter_aggr_3q;

//Note 1:
mb_srvr_map->tab_registers[HLD_REG_MPC_KW] = mpc_lmt;
mb_srvr_map->tab_registers[HLD_REG_LPC_KW] = MY_MAX((OFFSET - 100 - aderp_bess_maxdschgpwr_16b),(OFFSET-MAX_ERCOT_COMMIT));

mb_srvr_map->tab_registers[HLD_REG_BESS_RRate] = 249;//250;// kw/sec, verify units

mb_srvr_map->tab_bits[BIT_POIBrk_Status] = aderp_poi_cbstat && aderp_mgmain_cbstat; //Note 2


//disabling charge flag, charging will be controlled by ERCOT based on MPC limit provided by participant
/*
//BESS Charging Signal (1AM to 5AM CST is reserved for BESS charging)
time(&current_time);
local_time = localtime(&current_time);


if ((local_time->tm_hour>5) && (local_time->tm_hour<10)) //UTC Time = 6 (1AM CST) to 10 (5AM CST)
{
	aderp_bess_chgflg = (aderp_bess_maxchgpwr_16b!=0);
	sem_post(&stchmgplc_tesla_psem);
}
else if ((local_time->tm_hour==10) && (local_time->tm_min==1))
{
	aderp_bess_chgflg = 0;
	sem_post(&stchmgplc_tesla_psem);
}*/

goto aderpilot_mbsrvr_update;


}



