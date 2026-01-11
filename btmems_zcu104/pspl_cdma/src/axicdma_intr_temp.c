//Note in this code, I am just using a physical address in PS DDR for my buffer. I have obtained that address without using a particular
//methodology. If /dev/mem fails on that address (i.e. doesnt allow mapping), either use some other physical address or its better to just
//reserve whatever physical address you want to use in system-user.dtsi device tree so that kernel doesnt use it for anything else
//For now I am able to map to this PS DDR physical address without reserving it

#include <stdio.h>
#include <math.h>
#include <stdlib.h>
#include <time.h>
#include <fcntl.h>
#include <sys/mman.h>
#include <string.h>
#include <unistd.h>
#include <errno.h>

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


#define BUFFER_BYTESIZE     1024 // Length of the buffers for DMA transfer from DDR to BRAM
#define MAP_SIZE 4096

#define DDR_MAP_SIZE 0x10000
#define DDR_MAP_MASK (DDR_MAP_SIZE - 1)

typedef unsigned int u32;

unsigned int dma_set(unsigned int* dma_virtual_address, int offset, unsigned int value) {
    dma_virtual_address[offset>>2] = value;
}

unsigned int dma_get(unsigned int* dma_virtual_address, int offset) {
    return dma_virtual_address[offset>>2]; //FA - right shift by 2 positions to align with 32-bit registers in cdam IP
}

void *uio_map(int size, int * fd)
{

	void *mio;

	//note that uio0 here is CDMA IP. It can also be uio1 or something else in other designs. It depends upon how many devices in device tree are using uio driver and order in which they are declared
	if ((*fd = open("/dev/uio0", O_RDWR)) == -1) //this can also be uio1 and so on depending upon how many devices in device tree are using uio driver and in what order they have been listed
	{
		perror("open uio0 failed\n");
		exit(-1);
	}

	mio = mmap(0, size, PROT_READ | PROT_WRITE, MAP_SHARED, *fd, 0);
	if (mio == MAP_FAILED) {
		perror("mmap failed\n");
		return NULL;
	}

	return mio;
}


int main()
{
	//CDMA UIO related variables
	unsigned char *ptr_uio = NULL;
	int fd_uio;
	int size_uio = MAP_SIZE;
	ssize_t intr_count_uio = 0;
	int count_uio = 0;
	int uio_intr_en=1;

	//uio mapping
	ptr_uio = (unsigned char *) uio_map(size_uio,&fd_uio); //this is not needed as we are using /dev/mem writing to memory
	if(!ptr_uio) {
		printf("uio mmap failed \n");
		//return 0;
	}

   int fd, count = 0;
 //  uint bram_size = 0x40000;//FA - I added this variable for 256K BRAM
   u32 *vadd_bram, *vadd_psddr, *vadd_cdma;
   off_t BRAM_pbase = 0xC0000000;
   off_t PSDDR_pbase = 0x4000000;
   off_t CDMA_pbase = 0xA0000000;

   //note we are still using /dev/mem and not /dev/uio0 to access memory and device registers. /dev/uio0 above is only used for interrupt
   fd = open("/dev/mem", O_RDWR /*| O_SYNC*/); //FA - O_SYNC needed for non-cached access to peripheral
   	   	   	   	   	   	   	   	   	   	   	   //Also "| O_NONBLOCK" is switch for non-blocking read, as an FYI
   if (fd == -1)
   {
      printf("Can't open /dev/mem.\n");
      exit(0);
   }
   printf("/dev/mem opened.\n");

//   vadd_bram = (u32 *)mmap(NULL,4096, PROT_READ | PROT_WRITE, MAP_SHARED, fd, BRAM_pbase); //For now I am just using same map size for all memories (BRAM, PSU, CDMA). For real application, put the actual memory size in bytes. For BRAM and CDMA, size can be obtained from Vivado address editor. For PS memory, use the size as required
//   if(vadd_bram == (u32 *) -1)
//   {
//      printf("Can't map the BRAM memory to user space... %s\n",strerror(errno));
//      //perror("Error Text "); //use either perror or strerror(errno) to print error string
//     exit(0);
//   }
//   printf("BRAM Memory mapped at address %p.\n", vadd_bram);

   vadd_psddr = (u32 *)mmap(NULL, DDR_MAP_SIZE, PROT_READ | PROT_WRITE, MAP_SHARED, fd, PSDDR_pbase);
   if(vadd_psddr == (u32 *) -1)
   {
      printf("Can't map the PSDDR memory to user space.....%s\n",strerror(errno));
        exit(0);
    }
   printf("PSDDR Memory mapped at address %p.\n", vadd_psddr);

   vadd_cdma = (u32 *)mmap(NULL, MAP_SIZE, PROT_READ | PROT_WRITE, MAP_SHARED, fd, CDMA_pbase);
   if(vadd_cdma == (u32 *) -1)
   {
      printf("Can't map the CDMA memory to user space.......%s\n",strerror(errno));
        exit(0);
    }
    printf("CDMA Memory mapped at address %p.\n", vadd_cdma);

      for(int i = 0; i < 1000; i++)
      {
         vadd_psddr[i] = i;
         printf("Input : value in PSDDR %d\r\n", vadd_psddr[i]);
      }

    unsigned int reg = dma_get(vadd_cdma, XAXICDMA_CR_OFFSET);
    unsigned int status = dma_get(vadd_cdma, XAXICDMA_SR_OFFSET);
    printf("control reg:0x%08x\n", reg);
    printf("status reg:0x%08x\n", status);


    printf("all interrupts masked...\n");
    dma_set(vadd_cdma, XAXICDMA_CR_OFFSET, XAXICDMA_XR_IRQ_SIMPLE_ALL_MASK);
    reg = dma_get(vadd_cdma, XAXICDMA_CR_OFFSET);
    status = dma_get(vadd_cdma, XAXICDMA_SR_OFFSET);
    printf("control reg:0x%08x\n", reg);
    printf("status reg:0x%08x\n", status);

    //**************************************************************************************

    dma_set(vadd_cdma, XAXICDMA_SRCADDR_OFFSET, BRAM_pbase);
    dma_set(vadd_cdma, XAXICDMA_DSTADDR_OFFSET, 0x4000FA0);//PSDDR_pbase + 0FA0
    dma_set(vadd_cdma, XAXICDMA_BTT_OFFSET, 0xFA0);

    intr_count_uio = read(fd_uio,&count_uio,sizeof(count_uio));
    printf ("CDMA Transfer is Done \n");
    dma_set(vadd_cdma, XAXICDMA_SR_OFFSET, XAXICDMA_IRQ_CLEAR);
    write(fd_uio,&uio_intr_en,sizeof(uio_intr_en));

    for(int j = 0; j < 1000; j++)
    {
         printf("Output : value in BRAM %d \r\n", vadd_psddr[j+1000]/*vadd_bram[i]*/); //use vadd_bram instead for readback via CPU and not CDMA, see note above
    }

    //**********************************************************************************
    printf("Writing source address\n");
    dma_set(vadd_cdma, XAXICDMA_SRCADDR_OFFSET, PSDDR_pbase);

    reg = dma_get(vadd_cdma, XAXICDMA_SRCADDR_OFFSET);
    status = dma_get(vadd_cdma, XAXICDMA_SR_OFFSET);
    printf("Source addr reg:0x%08x\n", reg);
    printf("status reg:0x%08x\n", status);

    printf("Writing destination address\n");
    dma_set(vadd_cdma, XAXICDMA_DSTADDR_OFFSET, BRAM_pbase);

    reg = dma_get(vadd_cdma, XAXICDMA_DSTADDR_OFFSET);
    status = dma_get(vadd_cdma, XAXICDMA_SR_OFFSET);
    printf("Dest addr reg:0x%08x\n", reg);
    printf("status reg:0x%08x\n", status);

    printf("Writing DMA Transfer Length \n");
    dma_set(vadd_cdma, XAXICDMA_BTT_OFFSET, 0xFA0); // write length register
    												// FA - length is in bytes. Also writing to this register initiates DMA transfer as well

    //blocking read waiting for CDMA completion interrupt. Note this is where we use UIO map
    intr_count_uio = read(fd_uio,&count_uio,sizeof(count_uio));
    printf ("CDMA Transfer is Done \n");
    dma_set(vadd_cdma, XAXICDMA_SR_OFFSET, XAXICDMA_IRQ_CLEAR); //clearing CDMA interrupt
    write(fd_uio,&uio_intr_en,sizeof(uio_intr_en)); //re-enabling UIO interrupt controller

    reg = dma_get(vadd_cdma, XAXICDMA_BTT_OFFSET);
    status = dma_get(vadd_cdma, XAXICDMA_SR_OFFSET);
    printf("length reg:0x%08x\n", reg);
    printf("status reg:0x%08x\n", status);

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Note the code in this block basically reads backdata using CDMA from BRAM to a PS DDR location for comparison

// Alternative way (for which just delete the code in this block and make a small change on printf line below, see comment there) is to
//directly readback from BRAM (which will consume CPU and wont use CDMA). Note that readback using this approach will not be coherent
//as PS (CPU i.e.) will read BRAM via HPM port in your Vivado design and not HPC (HPC port is used for read/write by CDMA since it is Master on
//that port, PS is Master on HPM port per your design). If you want to make this direct readback by CPU coherent, then make memory non-cached
//using O_SYNC switch in /dev/mem
    dma_set(vadd_cdma, XAXICDMA_SRCADDR_OFFSET, BRAM_pbase);
    dma_set(vadd_cdma, XAXICDMA_DSTADDR_OFFSET, 0x4000FA0);//PSDDR_pbase + 0FA0
    dma_set(vadd_cdma, XAXICDMA_BTT_OFFSET, 0xFA0);

    intr_count_uio = read(fd_uio,&count_uio,sizeof(count_uio));
    printf ("CDMA Transfer is Done \n");
    dma_set(vadd_cdma, XAXICDMA_SR_OFFSET, XAXICDMA_IRQ_CLEAR);
    write(fd_uio,&uio_intr_en,sizeof(uio_intr_en));
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

    for(int i = 0; i < 1000; i++)
    {
         printf("Output : value in PSDDR %d : value in BRAM %d \r\n", vadd_psddr[i], vadd_psddr[i+1000]/*vadd_bram[i]*/); //use vadd_bram instead for readback via CPU and not CDMA, see note above
         if(vadd_psddr[i] != vadd_psddr[i+1000]/*vadd_bram[i]*/) //use vadd_bram instead for readback via CPU and not CDMA, see note above
         {
              count++;
         }
    }

   if(!count)
   {
      printf("Transmitted Data successfully\n");
   }
   else
   {
      printf("Transmitted data Mismatched : %d\n", count);
   }

}
