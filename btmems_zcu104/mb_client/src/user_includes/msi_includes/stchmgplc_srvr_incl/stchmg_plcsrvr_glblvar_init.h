#include STCHMG_PLCSRVR_DEFINES

//Global variable definitions (accessible to main and all threads)

modbus_t *ctx_plc;
pthread_t mbplc_hb;
sem_t stchmgplc_w_sem;
pthread_t mbplc_teslaP;
pthread_t mbplc_gensetP;
sem_t stchmgplc_tesla_psem;
sem_t stchmgplc_genset_psem;
pthread_t mbplc_pvP;
sem_t stchmgplc_pv_psem;

pthread_mutex_t stchmgplc_w = PTHREAD_MUTEX_INITIALIZER;
pthread_mutex_t stchmgplc_wsig_lck = PTHREAD_MUTEX_INITIALIZER;

uint16_t stchmgplc_wsig = 0;
int bess_opt_p=0;

uint16_t plcsrvr_rregs[2];
uint16_t *plcsrvr_rregs_ptr = plcsrvr_rregs;
