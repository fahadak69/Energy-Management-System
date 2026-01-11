#include SERVER5_DEFINES

//Global variable definitions (accessible to main and all threads)

pthread_t mbsrvr5,mbsrvr5_rwait;

sem_t srvr5_rdbk_sem;
sem_t srvr5_rw_sem;

modbus_t *ctx_srvr5;
uint16_t server5_rregs[SERVER5_NREAD_REGS]; //buffer for storing read back register values
uint16_t *server5_rregs_ptr = server5_rregs;

pthread_t mbsrvr5_w;
sem_t srvr5_wcmd_sem;

pthread_t mbsrvr5_brkop_w;
sem_t srvr5_wcmd_brkopsem;

pthread_t mbsrvr5_brkcl_w;
sem_t srvr5_wcmd_brkclsem;

pthread_mutex_t srvr5_rw = PTHREAD_MUTEX_INITIALIZER;
pthread_mutex_t srvr5_wsig_lck = PTHREAD_MUTEX_INITIALIZER;

uint16_t srvr5_wsig = 0;

