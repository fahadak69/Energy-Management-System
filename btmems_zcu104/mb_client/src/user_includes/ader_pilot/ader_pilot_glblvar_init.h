#include ADER_PILOT_DEFINES

sem_t aderpilot_mbsrvr_sem;

atomic_uint atomic_bess_maxdschgpwr;
atomic_uint atomic_bess_maxchgpwr;
atomic_uint atomic_bess_socr;

atomic_uint_least16_t atomic_bess_output;
atomic_uint_least16_t atomic_genset_output;

atomic_uint_least16_t atomic_poi_cbstat;
atomic_uint_least16_t atomic_mgmain_cbstat;

//atomic_int atomic_meter_poi_3p;

uint16_t aderp_bess_chgflg = 0;
