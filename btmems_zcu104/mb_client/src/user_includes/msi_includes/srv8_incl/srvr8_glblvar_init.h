#include SERVER8_DEFINES

//Global variable definitions (accessible to main and all threads)

pthread_t mbsrvr8,mbsrvr8_rwait;

sem_t srvr8_rdbk_sem;

modbus_t *ctx_srvr8;
uint16_t server8_rregs[SERVER8_NREAD_REGS]; //buffer for storing read back register values

