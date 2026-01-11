#include SERVER3_DEFINES

//Global variable definitions (accessible to main and all threads)

pthread_t mbsrvr3,mbsrvr3_rwait;

sem_t srvr3_rdbk_sem;

modbus_t *ctx_srvr3;
uint16_t server3_rregs[SERVER3_NREAD_REGS]; //buffer for storing read back register values, assuming 32 registers for now
uint16_t *server3_rregs_ptr = server3_rregs;

int meter_poi_3p_plr;
int meter_poi_3q_plr;

int meter_genset_3p_plr;
int meter_genset_3q_plr;

int meter_bess_3p_plr;
int meter_bess_3q_plr;


