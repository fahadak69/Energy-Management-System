// CDMA Transfer Code

pthread_t cdma_hndl;
sem_t mb_wcdma_sem;


pthread_mutex_t mutex_cdma_trnsf = PTHREAD_MUTEX_INITIALIZER;
pthread_cond_t cond_cdma_trnsf = PTHREAD_COND_INITIALIZER;
uint16_t cdma_trnsf_chk = FALSE;

#define BRAM_PBASE 0xC0000000//0xA0000000//Base address for Read Back data BRAM
#define BRAM_W_PBASE 0xC0001000//Base address for Write command BRAM
#define PSDDR_PBASE 0x4000000
#define CDMA_PBASE 0xA0000000//0xA0040000

//FA - Note Tabl 2-6 of AXI CDMA IP product guide has all these addresses listed
#define XAXICDMA_CR_OFFSET       0x00000000  /**< Control register */
#define XAXICDMA_SR_OFFSET       0x00000004  /**< Status register */

#define XAXICDMA_SRCADDR_OFFSET 0x00000018  /**< Source address register */
#define XAXICDMA_DSTADDR_OFFSET 0x00000020  /**< Destination address register */
#define XAXICDMA_BTT_OFFSET     0x00000028  /**< Bytes to transfer */


#define XAXICDMA_XR_IRQ_IOC_MASK 0x00001000 /**< Completion interrupt */
#define XAXICDMA_XR_IRQ_DELAY_MASK  0x00002000 /**< Delay interrupt */
#define XAXICDMA_XR_IRQ_ERROR_MASK  0x00004000 /**< Error interrupt */
#define XAXICDMA_XR_IRQ_ALL_MASK 0x00007000 /**< All interrupts */
#define XAXICDMA_XR_IRQ_SIMPLE_ALL_MASK   0x00005000 /**< All interrupts for
                                                        simple only mode */
#define XAXICDMA_IRQ_CLEAR 0x00001000 //to clear CDMA transfer complete interrupt

#define BRAM_MAP_SIZE 4096 //size of PL BRAM for cdma transfers
#define PSCDMA_DDR_MAP_SIZE 0x10000 //size of ps ddr memory mapped for CDMA transfers
#define CDMA_MAP_SIZE 4096


unsigned int cdma_src_addr; //source address global used by all threads for cdma transfer
unsigned int cdma_dest_addr;//destination address global used by all threads for cdma transfer
unsigned int cdma_trnsf_length;//transfer length for cdma

typedef unsigned int u32;

u32 *vadd_psddr; //PS DDR address needs to be global so that server threads can use it
u32 *vadd_bram;  //bram address is global because for now we will do bram to PS transfer using CPU (instead of CDMA) in server write thread -- this is not true anymore since we are using CDMA for pl to ps as well. Delete variable if redundant



//Not using it as a function, code copied in line directly instead to save CPU cycles in function call
//unsigned int dma_set(unsigned int* dma_virtual_address, int offset, unsigned int value) {
//    dma_virtual_address[offset>>2] = value;
//}

//this function will be used by write server thread to grab data from bram to PS (direct cpu read instead of via cdma) and then write to server
unsigned int dma_get(unsigned int* dma_virtual_address, int offset) {
    return dma_virtual_address[offset>>2]; //FA - right shift by 2 positions to align with 32-bit registers in cdam IP
}

void* cdma_thread (void* args)
{
	//CDMA UIO related variables
	void *ptr_uio;
	int fd_uio;
	int size_uio = CDMA_MAP_SIZE;
	ssize_t intr_count_uio = 0;
	int count_uio = 0;
	int uio_intr_en=1;

	sem_init (&mb_wcdma_sem,0,0);

	//****** uio mapping start **********

	//note that uio0 here is CDMA IP. It can also be uio1 or something else in other designs. It depends upon how many devices in device tree are using uio driver and order in which they are declared
	if ((fd_uio = open("/dev/uio0", O_RDWR)) == -1)
	{
		perror("open uio0 failed\n");
		exit(0);
	}
	ptr_uio = mmap(0, size_uio, PROT_READ | PROT_WRITE, MAP_SHARED, fd_uio, 0);
	if (ptr_uio == MAP_FAILED) {
		perror("mmap GPIO uio0 failed\n");
		exit(0);
	}
	//****** uio mapping end **********

   int fd, count = 0;

   u32  *vadd_cdma; //not making it global as no other thread needs cdma address

   //note we are still using /dev/mem and not /dev/uio0 to access memory and device registers. /dev/uio0 above is only used for interrupt
   fd = open("/dev/mem", O_RDWR /*| O_SYNC*/); //FA - O_SYNC needed for non-cached access to peripheral
   	   	   	   	   	   	   	   	   	   	   	   //Also "| O_NONBLOCK" is switch for non-blocking read, as an FYI
   if (fd == -1)
   {
      printf("Can't open /dev/mem.\n");
      exit(0);
   }
#ifdef STAT_CDMA_PRINT
   printf("/dev/mem opened.\n");
#endif

   vadd_bram = (u32 *)mmap(NULL,BRAM_MAP_SIZE, PROT_READ | PROT_WRITE, MAP_SHARED, fd, BRAM_PBASE);
   if(vadd_bram == (u32 *) -1)
   {
      printf("Can't map the BRAM memory to user space... %s\n",strerror(errno));
      //perror("Error Text "); //use either perror or strerror(errno) to print error string
     exit(0);
   }
#ifdef STAT_CDMA_PRINT
   printf("BRAM Memory mapped at address %p.\n", vadd_bram);
#endif

   vadd_psddr = (u32 *)mmap(NULL, PSCDMA_DDR_MAP_SIZE, PROT_READ | PROT_WRITE, MAP_SHARED, fd, PSDDR_PBASE);
   if(vadd_psddr == (u32 *) -1)
   {
      printf("Can't map the PSDDR memory to user space.....%s\n",strerror(errno));
        exit(0);
    }
#ifdef STAT_CDMA_PRINT
   printf("PSDDR Memory mapped at address %p.\n", vadd_psddr);
#endif

   vadd_cdma = (u32 *)mmap(NULL, CDMA_MAP_SIZE, PROT_READ | PROT_WRITE, MAP_SHARED, fd, CDMA_PBASE);
   if(vadd_cdma == (u32 *) -1)
   {
      printf("Can't map the CDMA memory to user space.......%s\n",strerror(errno));
        exit(0);
    }
#ifdef STAT_CDMA_PRINT
    printf("CDMA Memory mapped at address %p.\n", vadd_cdma);
#endif


    vadd_cdma[XAXICDMA_CR_OFFSET>>2] = XAXICDMA_XR_IRQ_SIMPLE_ALL_MASK;
#ifdef STAT_CDMA_PRINT
    printf("all CDMA interrupts masked...\n");
#endif


	pthread_mutex_lock(&mutex_cdma_trnsf);

cdma_transfer_loop:
	while (!cdma_trnsf_chk)
	{
		pthread_cond_wait( &cond_cdma_trnsf, &mutex_cdma_trnsf );//waiting for an external thread to request transfer
	}
	cdma_trnsf_chk = FALSE;//setting back to FALSE for next turn

	#ifdef DBG_CDMA_TRNSF_INIT
		printf ("CDMA Transfer is Initiating \n");
	#endif

    //Write source address
	vadd_cdma[XAXICDMA_SRCADDR_OFFSET>>2] = cdma_src_addr;

    //Write destination address
	vadd_cdma[XAXICDMA_DSTADDR_OFFSET>>2] = cdma_dest_addr;

    //write CDMA transfer length
	vadd_cdma[XAXICDMA_BTT_OFFSET>>2] = cdma_trnsf_length; // write length register
    													   // FA - length is in bytes. Also writing to this register initiates DMA transfer as well

    //blocking read waiting for CDMA completion interrupt. Note this is where we use UIO map
    intr_count_uio = read(fd_uio,&count_uio,sizeof(count_uio));

	#ifdef DBG_CDMA_TRNSF_DONE
    	printf ("CDMA Transfer is Done \n");
	#endif

    if (cdma_src_addr==BRAM_W_PBASE)
    	sem_post(&mb_wcdma_sem); //signaling to write modbus thread that pl to ps transfer is complete


    vadd_cdma[XAXICDMA_SR_OFFSET>>2] = XAXICDMA_IRQ_CLEAR; //clearing CDMA interrupt
    write(fd_uio,&uio_intr_en,sizeof(uio_intr_en)); //re-enabling UIO interrupt controller

    if (cdma_dest_addr==(BRAM_PBASE+ (SRVR1_READ_BRAM_OFFSET*0x4)))
    {
    	//indicate to PL via EMIO that new read data has arrived in BRAM for server1 - use it as +ve edge triggered in PL
    	system("echo 1 > /sys/class/gpio/gpio412/value"); //Note that 412 is based on gpiochip334 (334+78=412), the gpiochipxx number can change for a new version of petalinux, so you need to check /sys/class/gpio
        //Resetting EMIO to zero (PL should be able to capture rising edge before CPU has chance to reset it, since PL is much faster)
        system("echo 0 > /sys/class/gpio/gpio412/value");
    }
    else if (cdma_dest_addr==(BRAM_PBASE+ (SRVR2_READ_BRAM_OFFSET*0x4)))
    {
       	//indicate to PL via EMIO that new read data has arrived in BRAM for server2 - use it as +ve edge triggered in PL
    	system("echo 1 > /sys/class/gpio/gpio413/value");
        //Resetting EMIO to zero (PL should be able to capture rising edge before CPU has chance to reset it, since PL is much faster)
        system("echo 0 > /sys/class/gpio/gpio413/value");
    }
    else if (cdma_dest_addr==(BRAM_PBASE+ (SRVR3_READ_BRAM_OFFSET*0x4)))
    {
       	//indicate to PL via EMIO that new read data has arrived in BRAM for server3 - use it as +ve edge triggered in PL
    	system("echo 1 > /sys/class/gpio/gpio414/value");
        //Resetting EMIO to zero (PL should be able to capture rising edge before CPU has chance to reset it, since PL is much faster)
        system("echo 0 > /sys/class/gpio/gpio414/value");
    }
    else if (cdma_dest_addr==(BRAM_PBASE+ (SRVR4_READ_BRAM_OFFSET*0x4)))
    {
       	//indicate to PL via EMIO that new read data has arrived in BRAM for server4 - use it as +ve edge triggered in PL
    	system("echo 1 > /sys/class/gpio/gpio415/value");
        //Resetting EMIO to zero (PL should be able to capture rising edge before CPU has chance to reset it, since PL is much faster)
        system("echo 0 > /sys/class/gpio/gpio415/value");
    }
    else if (cdma_dest_addr==(BRAM_PBASE+ (SRVR5_READ_BRAM_OFFSET*0x4)))
    {
       	//indicate to PL via EMIO that new read data has arrived in BRAM for server5 - use it as +ve edge triggered in PL
    	system("echo 1 > /sys/class/gpio/gpio416/value");
        //Resetting EMIO to zero (PL should be able to capture rising edge before CPU has chance to reset it, since PL is much faster)
        system("echo 0 > /sys/class/gpio/gpio416/value");
    }
    else if (cdma_dest_addr==(BRAM_PBASE+ (SRVR6_READ_BRAM_OFFSET*0x4)))
    {
       	//indicate to PL via EMIO that new read data has arrived in BRAM for server6 - use it as +ve edge triggered in PL
    	system("echo 1 > /sys/class/gpio/gpio417/value");
        //Resetting EMIO to zero (PL should be able to capture rising edge before CPU has chance to reset it, since PL is much faster)
        system("echo 0 > /sys/class/gpio/gpio417/value");
    }
    else if (cdma_dest_addr==(BRAM_PBASE + (USRPARAM_READ_BRAM_OFFSET*0x4)))
    {
    	system("echo 1 > /sys/class/gpio/gpio418/value");
        system("echo 0 > /sys/class/gpio/gpio418/value");
    }
    else if (cdma_dest_addr==(BRAM_PBASE+ (SRVR7_READ_BRAM_OFFSET*0x4)))
    {
       	//indicate to PL via EMIO that new read data has arrived in BRAM for server7 - use it as +ve edge triggered in PL
    	system("echo 1 > /sys/class/gpio/gpio420/value");
        //Resetting EMIO to zero (PL should be able to capture rising edge before CPU has chance to reset it, since PL is much faster)
        system("echo 0 > /sys/class/gpio/gpio420/value");
    }
    else if (cdma_dest_addr==(BRAM_PBASE+ (SRVR8_READ_BRAM_OFFSET*0x4)))
    {
       	//indicate to PL via EMIO that new read data has arrived in BRAM for server8 - use it as +ve edge triggered in PL
    	system("echo 1 > /sys/class/gpio/gpio421/value");
        //Resetting EMIO to zero (PL should be able to capture rising edge before CPU has chance to reset it, since PL is much faster)
        system("echo 0 > /sys/class/gpio/gpio421/value");
    }
    else if (cdma_dest_addr==(BRAM_PBASE+ (SRVR9_READ_BRAM_OFFSET*0x4)))
    {
       	//indicate to PL via EMIO that new read data has arrived in BRAM for server9 - use it as +ve edge triggered in PL
    	system("echo 1 > /sys/class/gpio/gpio422/value");
        //Resetting EMIO to zero (PL should be able to capture rising edge before CPU has chance to reset it, since PL is much faster)
        system("echo 0 > /sys/class/gpio/gpio422/value");
    }

   goto cdma_transfer_loop;

   return 0;
}
