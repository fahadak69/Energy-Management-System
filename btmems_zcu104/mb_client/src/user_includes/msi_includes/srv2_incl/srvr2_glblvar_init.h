#include SERVER2_DEFINES

//Global variable definitions (accessible to main and all threads)

pthread_t mbsrvr2,mbsrvr2_rwait;

sem_t srvr2_rdbk_sem;
sem_t srvr2_rw_sem;

modbus_t *ctx_srvr2;
uint16_t server2_rregs[SERVER2_NREAD_REGS]; //buffer for storing read back register values, assuming 32 registers for now
uint16_t *server2_rregs_ptr = server2_rregs;

pthread_t mbsrvr2_w;
sem_t srvr2_wcmd_sem;

pthread_t mbsrvr2_p_w;
sem_t srvr2_wcmd_psem;

pthread_t mbsrvr2_q_w;
sem_t srvr2_wcmd_qsem;

pthread_t mbsrvr2_run_w;
sem_t srvr2_wcmd_runsem;

pthread_t mbsrvr2_pf_w;
sem_t srvr2_wcmd_pfsem;

pthread_t mbsrvr2_qtyp_w;
sem_t srvr2_wcmd_qtypsem;

pthread_mutex_t srvr2_rw = PTHREAD_MUTEX_INITIALIZER;
pthread_mutex_t srvr2_wsig_lck = PTHREAD_MUTEX_INITIALIZER;

uint16_t srvr2_wsig = 0;
