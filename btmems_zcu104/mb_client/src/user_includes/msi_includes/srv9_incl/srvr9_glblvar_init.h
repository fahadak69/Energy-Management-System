#include SERVER9_DEFINES

//Global variable definitions (accessible to main and all threads)

pthread_t mbsrvr9,mbsrvr9_rwait;

sem_t srvr9_rdbk_sem;

modbus_t *ctx_srvr9;
uint16_t server9_rregs[SERVER9_NREAD_REGS]; //buffer for storing read back register values

