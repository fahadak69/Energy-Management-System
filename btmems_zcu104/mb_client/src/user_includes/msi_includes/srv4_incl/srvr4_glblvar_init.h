#include SERVER4_DEFINES

//Global variable definitions (accessible to main and all threads)

pthread_t mbsrvr4,mbsrvr4_rwait;

sem_t srvr4_rdbk_sem;
sem_t srvr4_rw_sem;

modbus_t *ctx_srvr4;
uint16_t server4_rregs[SERVER4_NREAD_REGS]; //buffer for storing read back register values, assuming 32 registers for now

pthread_t mbsrvr4_w;
sem_t srvr4_wcmd_sem;

pthread_t mbsrvr4_p_w;
sem_t srvr4_wcmd_psem;

pthread_t mbsrvr4_q_w;
sem_t srvr4_wcmd_qsem;

pthread_t mbsrvr4_run_w;
sem_t srvr4_wcmd_runsem;

pthread_t mbsrvr4_opermode_w;
sem_t srvr4_wcmd_opermodesem;


pthread_mutex_t srvr4_rw = PTHREAD_MUTEX_INITIALIZER;
pthread_mutex_t srvr4_wsig_lck = PTHREAD_MUTEX_INITIALIZER;

uint16_t srvr4_wsig = 0;


