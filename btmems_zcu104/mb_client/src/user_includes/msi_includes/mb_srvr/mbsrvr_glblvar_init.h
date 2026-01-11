#include MB_SERVER_DEFINES

modbus_t *ctx_srvr;
modbus_mapping_t *mb_srvr_map;

pthread_t mbsrvr_port502;
typedef struct param_struct {
    	modbus_t *ctx;
    	modbus_mapping_t *mb_mapping;
 } mb_param;
