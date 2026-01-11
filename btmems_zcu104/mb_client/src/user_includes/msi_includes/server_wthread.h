//Code for writing MODBUS commands to servers
//AXI GPIO defines
#define AXIGPIO_PL2PS_WMB_SIZE 			65536 			//size of axigpio memory for pl2ps modbus write data transfer
#define XAXIGPIO_DATACH1_OFFSET 		0x00000000   	//Offset for gpio channel 1 data register
#define XAXIGPIO_DATACH2_OFFSET 		0x00000004   	//Offset for gpio channel 2 data register
#define XAXIGPIO_STATUS_OFFSET 			0x00000120   	//Offset for status register
#define XAXIGPIO_GOLBALINTR_OFFSET 		0x0000011C		//Offset for global interrupt enable register
#define XAXIGPIO_CHNLINTR_OFFSET 		0x00000128		//offset for ch1 and ch2 register

void* srvr_wthread (void* args)
{
	//CDMA UIO related variables
	void *ptr_uio1;
	int fd_uio1;
	int size_uio1 = AXIGPIO_PL2PS_WMB_SIZE;
	ssize_t intr_count = 0;
	int count = 0;
	int uio1_intr_en=1;
	unsigned int gpio_statintr_rdbk;
	unsigned int mbsrvr_wcmd_stat1;
	unsigned int mbsrvr_wcmd_stat2;
	unsigned int srvr1_wcmdchk_tmp;
	unsigned int srvr2_wcmdchk_tmp;
	unsigned int srvr4_wcmdchk_tmp;
	unsigned int srvr5_wcmdchk_tmp;

	if ((fd_uio1 = open("/dev/uio1", O_RDWR)) == -1) //uio# number can vary depending upon definition in device tree
	{
		perror("open GPIO uio1 failed\n");
		exit(0);
	}
	ptr_uio1 = mmap(0, size_uio1, PROT_READ | PROT_WRITE, MAP_SHARED, fd_uio1, 0);
	if (ptr_uio1 == MAP_FAILED) {
		perror("mmap GPIO uio1 failed\n");
		exit(0);
	}

	*((unsigned int *)(ptr_uio1 + XAXIGPIO_GOLBALINTR_OFFSET)) = 0x80000000; //Enable global interrupt in IP
	*((unsigned int *)(ptr_uio1 + XAXIGPIO_CHNLINTR_OFFSET)) = 0x3; //Enable channel 1 and 2 interrupt

mbserver_write_loop:

	intr_count = 0;
	count = 0;

	system("echo 0 > /sys/class/gpio/gpio419/value"); //Deasserting emio flag that indicates PS is busy fetching fetching write command from PL

	intr_count = read(fd_uio1,&count,sizeof(count)); //blocking read, gets blocked until a new interrupt arrives. Note that when PS loops back and sets busy flag above to zero, PL may update write command status right after. This means interrupt maybe present already by the time cpu arrives at this line. Hence it may be necessary to configure this interrupt as level interrupt, not edge in pl.dtsi device tree for this device

	#ifdef DBG_WCMD_CDMA_TRNSF
		printf ("PL Write Command Flag Asserted\n");
	#endif

	//request CDMA transfer
	reacquire_w_mutex:
	pthread_mutex_lock(&mutex_cdma_trnsf);
	if (cdma_trnsf_chk==TRUE)
	{
		pthread_mutex_unlock(&mutex_cdma_trnsf);
		goto reacquire_w_mutex;
	}
	cdma_trnsf_chk = TRUE;
	system("echo 1 > /sys/class/gpio/gpio419/value"); //indicate to PL that PS is busy fetching write command from PL

	mbsrvr_wcmd_stat1 = *((unsigned int *)(ptr_uio1 + XAXIGPIO_DATACH1_OFFSET));//reading gpio ch.1 input values to know which modbus commands are sent by PL
	mbsrvr_wcmd_stat2 = *((unsigned int *)(ptr_uio1 + XAXIGPIO_DATACH2_OFFSET));//reading gpio ch.2 input values to know which modbus commands are sent by PL

	mbsrvr_wcmd_stat = mbsrvr_wcmd_stat2;
	mbsrvr_wcmd_stat = mbsrvr_wcmd_stat << 32;
	mbsrvr_wcmd_stat = mbsrvr_wcmd_stat | mbsrvr_wcmd_stat1;

	//update src addr, dest addr and transfer length using offsets from PSDDR_PBASE and BRAM_PBASE base address macros
	cdma_src_addr = BRAM_W_PBASE; //since this BRAM is used only for write commands, offset is zero
	cdma_dest_addr = PSDDR_PBASE + (WCMD_PSDDR_OFFSET*4); //multiplying by 4 as it is byte level addressing
    cdma_trnsf_length = TOTAL_W_REGISTERS*4; //Note we are reading all the write commands regardless of which command was updated, since cdma
    									     //transfer is very fast and there are not as many write commands as read data
	pthread_cond_signal(&cond_cdma_trnsf);
	pthread_mutex_unlock(&mutex_cdma_trnsf);

	sem_wait(&mb_wcdma_sem); //waiting for cdma transfer from PL to PS to finish

	#ifdef DBG_WCMD_CDMA_TRNSF
		printf ("PL2PS Write Commands Transfer Done\n");

	#endif

	//signaling srvr1 modbus write thread if server1 command was sent from PL to PS
	srvr1_wcmdchk_tmp = mbsrvr_wcmd_stat & 0x2; //bit 1 is for srvr1 cmd
	if (srvr1_wcmdchk_tmp>0)
	{
		sem_post(&srvr1_wcmd_sem);
	}

	//signaling srvr2 modbus write thread if server2 command was sent from PL to PS
	srvr2_wcmdchk_tmp = mbsrvr_wcmd_stat & 0x4; //bit 2 is for srvr2 cmd
	if (srvr2_wcmdchk_tmp>0)
	{
		sem_post(&srvr2_wcmd_sem);
	}

	//signaling srvr4 modbus write thread if server4 command was sent from PL to PS
	srvr4_wcmdchk_tmp = mbsrvr_wcmd_stat & 0x8; //bit 3 is for srvr4 cmd
	if (srvr4_wcmdchk_tmp>0)
	{
		sem_post(&srvr4_wcmd_sem);
	}

	//signaling srvr5 modbus write thread if server5 command was sent from PL to PS
	srvr5_wcmdchk_tmp = mbsrvr_wcmd_stat & 0x10; //bit 4 is for srvr5 cmd
	if (srvr5_wcmdchk_tmp>0)
	{
		sem_post(&srvr5_wcmd_sem);
	}

	//similarly check for commands for other servers

	gpio_statintr_rdbk = *((unsigned int *)(ptr_uio1 + XAXIGPIO_STATUS_OFFSET)); //reading interrupt status register to know which channel caused interrupt
	if (gpio_statintr_rdbk==1)
		*((unsigned int *)(ptr_uio1 + XAXIGPIO_STATUS_OFFSET)) = 0x1; //writing 1 to interrupt status register to clear it back to zero
	else
		*((unsigned int *)(ptr_uio1 + XAXIGPIO_STATUS_OFFSET)) = 0x2; //clearing channel 2 interrupt status


	write(fd_uio1,&uio1_intr_en,sizeof(uio1_intr_en)); //Interr handler in UIO Driver disables interr controller after receiving interr. Re-enabling it for next interrupt by writing 0x1 to the device


	goto mbserver_write_loop;
}
