
//Notes:
//1: If you want server to accept connection only from certain specific client IPs, modify modbus_tcp_accept function
//	 to compare inet_ntoa(addr.sin_addr) with an IP string of the form "xxx.xxx.xxx.xxx". If string doesnt match with specified IP
//	 addresses, just close the connection using modbus_close(ctx) and wait for another client. Basically with this approach, you will
//	 still accept connection from any client, but if IP doesnt match, you will close it immediately


 void* mbsrv_502_thread (void* args)
 {
	 mb_param* inner_param = (mb_param*)args;
	 modbus_t *ctx;
	 modbus_mapping_t *mb_mapping;
	 int s = -1;
	 int function_code;
	 uint16_t prv_reg_value;

	 unsigned int usr_imp_lmt_pl;

	 ctx = inner_param->ctx;
	 mb_mapping = inner_param->mb_mapping;

	 //Initializing setpoint register
#ifdef ENABLE_ADER_PILOT
	 prv_reg_value = 0;
	 mb_mapping->tab_registers[HLD_REG_TARGET_KW] = 0;
#endif

start_label_502:
	 s = -1;
	 s = modbus_tcp_listen(ctx, 1);// this function creates server listening socket
	 modbus_tcp_accept(ctx, &s);//this is the function that waits for a client request and then accepts the request

	 for (;;) {

		 uint8_t query[MODBUS_TCP_MAX_ADU_LENGTH];
	     int rc;

	     rc = modbus_receive(ctx, query);
	     if (rc > 0) {
	        /* rc is the query size */
	    	 modbus_reply(ctx, query, rc, mb_mapping,&function_code);
	    	 //printf("Handled Modbus function code: 0x%02X\n", function_code); //this can be used to find type of request
	        } else if (rc == -1) {
	            /* Connection closed by the client or error */
	            break;
	        }

#ifdef ENABLE_ADER_PILOT

	     if (mb_mapping->tab_registers[HLD_REG_TARGET_KW] != prv_reg_value)
	     {
	    	 sem_post(&stchmgplc_tesla_psem);
	    	 sem_post(&stchmgplc_genset_psem);

	    	 prv_reg_value = mb_mapping->tab_registers[HLD_REG_TARGET_KW];
	     }
#endif


	     //values printed here which are sent to holding registers from Master simulator
	     //printf("The tab register value is %d\n", mb_mapping->tab_registers[0]); //write a value to register 400  using client simulator and match it with print result which means successfully written
	     //printf("The tab register value is %d\n", mb_mapping->tab_registers[1]);
	     //printf("The tab register value is %d\n", mb_mapping->tab_registers[19]);
	     //printf("The tab register value is %d\n", mb_mapping->tab_input_registers[9]);
	     //printf("The tab coil value is %d\n", mb_mapping->tab_bits[0]);
	    }

	 	 //message after client closes the connection
	    //printf("Quit the loop: %s\n", modbus_strerror(errno));

	    if (s != -1) {
	        close(s);
	    }

	    modbus_close(ctx);
	    goto start_label_502;

	    return 0;
 }
