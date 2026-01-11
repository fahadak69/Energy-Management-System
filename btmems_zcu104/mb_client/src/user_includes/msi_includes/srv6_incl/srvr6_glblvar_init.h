#include SERVER6_DEFINES

//Global variable definitions (accessible to main and all threads)

pthread_t mbsrvr6,mbsrvr6_rwait;

sem_t srvr6_rdbk_sem;

modbus_t *ctx_srvr6;
uint16_t server6_rregs[SERVER6_NREAD_REGS]; //buffer for storing read back register values

