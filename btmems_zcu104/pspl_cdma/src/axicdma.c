////Note this application is having cache coherency issue even though I have all the h/w coherency settings turned on.
////Thats why when I open dev/mem, I need to use O_SYNC switch to make it non-cached. I have reported issue to xilinx
////Although I think I dont need caching for this application since processor needs to capture fresh data anyway everytime (so if cache is enabled
////with coherency on, processor will have cache miss every time since data has been updated and will be forced to fetch it directly from location)
////cache is useful when you are using same data again and again which is not being frequently updated
//
//#include <stdio.h>
//#include <math.h>
//#include <stdlib.h>
//#include <time.h>
//#include <fcntl.h>
//#include <sys/mman.h>
//#include <string.h>
//#include <unistd.h>
//#include <errno.h>
//
////FA - Note Tabl 2-6 of AXI CDMA IP product guide has all these addresses listed
//#define XAXICDMA_CR_OFFSET       0x00000000  /**< Control register */
//#define XAXICDMA_SR_OFFSET       0x00000004  /**< Status register */
//
//#define XAXICDMA_SRCADDR_OFFSET 0x00000018  /**< Source address register */
//#define XAXICDMA_DSTADDR_OFFSET 0x00000020  /**< Destination address register */
//#define XAXICDMA_BTT_OFFSET     0x00000028  /**< Bytes to transfer */
//
//
//#define XAXICDMA_XR_IRQ_IOC_MASK 0x00001000 /**< Completion interrupt */
//#define XAXICDMA_XR_IRQ_DELAY_MASK  0x00002000 /**< Delay interrupt */
//#define XAXICDMA_XR_IRQ_ERROR_MASK  0x00004000 /**< Error interrupt */
//#define XAXICDMA_XR_IRQ_ALL_MASK 0x00007000 /**< All interrupts */
//#define XAXICDMA_XR_IRQ_SIMPLE_ALL_MASK   0x00005000 /**< All interrupts for
//                                                        simple only mode */
//
//
//#define BUFFER_BYTESIZE     1024 // Length of the buffers for DMA transfer from DDR to BRAM
//#define MAP_SIZE 4096
//
//#define DDR_MAP_SIZE 0x10000
//#define DDR_MAP_MASK (DDR_MAP_SIZE - 1)
//
//typedef unsigned int u32;
//
//unsigned int dma_set(unsigned int* dma_virtual_address, int offset, unsigned int value) {
//    dma_virtual_address[offset>>2] = value;
//}
//
//unsigned int dma_get(unsigned int* dma_virtual_address, int offset) {
//    return dma_virtual_address[offset>>2]; //FA - right shift by 2 positions to align with 32-bit registers in cdam IP
//}
//
//int main()
//{
//
//   int fd, count = 0;
// //  uint bram_size = 0x40000;//FA - I added this variable for 256K BRAM
//   u32 *vadd_bram, *vadd_psddr, *vadd_cdma;
//   off_t BRAM_pbase = 0xA0000000;
//   off_t PSDDR_pbase = 0x4000000;
//   off_t CDMA_pbase = 0xA0040000;//0x400000000;
//
//   fd = open("/dev/mem", O_RDWR | O_SYNC); //FA - O_SYNC needed for non-cached access to peripheral. This is not needed for hardware coherent system
//   	   	   	   	   	   	   	   	   	   	   	   //note I have enabled required settings for hardware coherent in this system
//   	   	   	   	   	   	   	   	   	   	   	   //Also "| O_NONBLOCK" is switch for non-blocking read, as an FYI
//   if (fd == -1)
//   {
//      printf("Can't open /dev/mem.\n");
//      exit(0);
//   }
//   printf("/dev/mem opened.\n");
//
//   vadd_bram = (u32 *)mmap(NULL,MAP_SIZE, PROT_READ | PROT_WRITE, MAP_SHARED, fd, BRAM_pbase);
//   if(vadd_bram == (u32 *) -1)
//   {
//      printf("Can't map the BRAM memory to user space... %s\n",strerror(errno));
//      //perror("Error Text "); //use either perror or strerror(errno) to print error string
//     exit(0);
//   }
//   printf("BRAM Memory mapped at address %p.\n", vadd_bram);
//
//   vadd_psddr = (u32 *)mmap(NULL, DDR_MAP_SIZE, PROT_READ | PROT_WRITE, MAP_SHARED, fd, PSDDR_pbase);
//   if(vadd_psddr == (u32 *) -1)
//   {
//      printf("Can't map the PSDDR memory to user space.....%s\n",strerror(errno));
//        exit(0);
//    }
//   printf("PSDDR Memory mapped at address %p.\n", vadd_psddr);
//
//   vadd_cdma = (u32 *)mmap(NULL, MAP_SIZE, PROT_READ | PROT_WRITE, MAP_SHARED, fd, CDMA_pbase);
//   if(vadd_cdma == (u32 *) -1)
//   {
//      printf("Can't map the CDMA memory to user space.......%s\n",strerror(errno));
//        exit(0);
//    }
//    printf("CDMA Memory mapped at address %p.\n", vadd_cdma);
//
//      for(int i = 0; i < 1000; i++)
//      {
//         vadd_psddr[i] = i;
//         printf("Input : value in PSDDR %d : value in BRAM %d\r\n", vadd_psddr[i], vadd_bram[i]);
//      }
//
//    unsigned int reg = dma_get(vadd_cdma, XAXICDMA_CR_OFFSET);
//    unsigned int status = dma_get(vadd_cdma, XAXICDMA_SR_OFFSET);
//    printf("control reg:0x%08x\n", reg);
//    printf("status reg:0x%08x\n", status);
//
//
//    printf("all interrupts masked...\n");
//    dma_set(vadd_cdma, XAXICDMA_CR_OFFSET, XAXICDMA_XR_IRQ_SIMPLE_ALL_MASK);
//    reg = dma_get(vadd_cdma, XAXICDMA_CR_OFFSET);
//    status = dma_get(vadd_cdma, XAXICDMA_SR_OFFSET);
//    printf("control reg:0x%08x\n", reg);
//    printf("status reg:0x%08x\n", status);
//
//
//    printf("Writing source address\n");
//    dma_set(vadd_cdma, XAXICDMA_SRCADDR_OFFSET, PSDDR_pbase);
//
//    reg = dma_get(vadd_cdma, XAXICDMA_SRCADDR_OFFSET);
//    status = dma_get(vadd_cdma, XAXICDMA_SR_OFFSET);
//    printf("Source addr reg:0x%08x\n", reg);
//    printf("status reg:0x%08x\n", status);
//
//    printf("Writing destination address\n");
//    dma_set(vadd_cdma, XAXICDMA_DSTADDR_OFFSET, BRAM_pbase);
//
//    reg = dma_get(vadd_cdma, XAXICDMA_DSTADDR_OFFSET);
//    status = dma_get(vadd_cdma, XAXICDMA_SR_OFFSET);
//    printf("Dest addr reg:0x%08x\n", reg);
//    printf("status reg:0x%08x\n", status);
//
//    printf("Writing DMA Transfer Length \n");
//    dma_set(vadd_cdma, XAXICDMA_BTT_OFFSET, 0xFA0); // write length register
//    												// FA - length is in bytes. Also writing to this register initiates DMA transfer as well
//
//    while(1)
//   {
//      status = dma_get(vadd_cdma, XAXICDMA_SR_OFFSET);
//      printf("status reg:0x%08x\n", status);
//      if(status & (1 << 12))
//      {
//         printf("DMA transfer is completed \n");
//         break;
//      }
//
//   }
//    reg = dma_get(vadd_cdma, XAXICDMA_BTT_OFFSET);
//    status = dma_get(vadd_cdma, XAXICDMA_SR_OFFSET);
//    printf("length reg:0x%08x\n", reg);
//    printf("status reg:0x%08x\n", status);
//
//    for(int i = 0; i < 1000; i++)
//    {
//         printf("Output : value in PSDDR %d : value in BRAM %d \r\n", vadd_psddr[i], vadd_bram[i]);
//         if(vadd_psddr[i] != vadd_bram[i])
//         {
//              count++;
//         }
//    }
//
//   if(!count)
//   {
//      printf("Transmitted Data successfully\n");
//   }
//   else
//   {
//      printf("Transmitted data Mismatched : %d\n", count);
//   }
//
//}
