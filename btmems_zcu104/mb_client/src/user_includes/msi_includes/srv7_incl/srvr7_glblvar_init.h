#include SERVER7_DEFINES

//Global variable definitions (accessible to main and all threads)

pthread_t mbsrvr7,mbsrvr7_rwait;

sem_t srvr7_rdbk_sem;

modbus_t *ctx_srvr7;
uint16_t server7_rregs[SERVER7_NREAD_REGS]; //buffer for storing read back register values

