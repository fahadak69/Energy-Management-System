int thread_result = 0;
mb_param modparam;

ctx_srvr = modbus_new_tcp(MB_SERVER_IP, 502); //IP address of server
modbus_set_debug(ctx_srvr, FALSE);

mb_srvr_map = modbus_mapping_new(SRVR_BITS, SRVR_INPUT_BITS, SRVR_HOLDING_REG, SRVR_INPUT_REG); //mapping registers and coils

if (mb_srvr_map == NULL) {
	fprintf(stderr, "Failed to allocate the mapping: %s\n", modbus_strerror(errno));
    modbus_free(ctx_srvr);
    return -1;
	}

//Assign Test Values:
//mb_srvr_map->tab_input_registers[9] = 271; //random value stored in input register which will be read by Master simulator
//mb_srvr_map->tab_registers[19] = 129;
//mb_srvr_map->tab_input_bits[0] = 1; //random value stored in input bit which will be read by MAster simulator

modparam.ctx = ctx_srvr;
modparam.mb_mapping = mb_srvr_map;

thread_result = pthread_create(&mbsrvr_port502, NULL, mbsrv_502_thread, &modparam);
if(thread_result != 0)
	{
 	   fprintf(stderr, "Could not create MB server thread for port 502!\n");
 	   exit(1);
    }

//modbus_mapping_free(mb_srvr_map);
//modbus_close(ctx_srvr);
//modbus_free(ctx_srvr);
