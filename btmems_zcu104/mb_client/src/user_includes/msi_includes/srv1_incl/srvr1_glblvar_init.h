#include SERVER1_DEFINES

//Global variable definitions (accessible to main and all threads)

pthread_t mbsrvr1,mbsrvr1_rwait;

sem_t srvr1_rdbk_sem;
sem_t srvr1_rw_sem;

modbus_t *ctx_srvr1;
uint16_t server1_rregs[SERVER1_NREAD_REGS]; //buffer for storing read back register values, assuming 32 registers for now
uint16_t *server1_rregs_ptr = server1_rregs;

pthread_t mbsrvr1_w;
sem_t srvr1_wcmd_sem;

pthread_t mbsrvr1_p_w;
sem_t srvr1_wcmd_psem;

pthread_t mbsrvr1_q_w;
sem_t srvr1_wcmd_qsem;

pthread_t mbsrvr1_run_w;
sem_t srvr1_wcmd_runsem;

pthread_t mbsrvr1_pf_w;
sem_t srvr1_wcmd_pfsem;

pthread_t mbsrvr1_qtyp_w;
sem_t srvr1_wcmd_qtypsem;

pthread_t mbsrvr1_island_w;
sem_t srvr1_wcmd_islandsem;

pthread_t mbsrvr1_islndfrq_w;
sem_t srvr1_wcmd_islndfrqsem;

pthread_t mbsrvr1_islndvlt_w;
sem_t srvr1_wcmd_islndvltsem;

pthread_mutex_t srvr1_rw = PTHREAD_MUTEX_INITIALIZER;
pthread_mutex_t srvr1_wsig_lck = PTHREAD_MUTEX_INITIALIZER;

uint16_t srvr1_wsig = 0;


