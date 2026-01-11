////This is code relies on using xilinx gpio driver (gpio-xilinx.c) to receive GPIO Interrupt
////In device tree, either use GPIO_KEY node for each GPIO input OR (export each gpio input individually and enable its respetive interrupt using [echo "rising" > edge] command after exporting a particular gpio input)
//
//#include <signal.h>
//#include <stdio.h>
//#include <time.h>
//#include <sys/mman.h>
//#include <unistd.h>
//#include<errno.h>
//#include<fcntl.h>
//#include <stdlib.h>
//#include <linux/input.h>
//
//#define MAP_SIZE 65536 //size of GPIO IP Memory - Comes from Vivado Address Editor
//#define XAXIGPIO_BASE 		0xA0050000 //GPIO IP base address, comes from vivado
//
//unsigned int *vadd_gpio;
//unsigned int gpio_dataval;
//typedef unsigned int u32;
//
//
//void sig_handler(int sig_num) //gpio-xilinx.c driver has been modified by omar such that whenever interrupt comes, interrupt handler
//							  //in the driver code sends a signal to userspace program
//{
//
//	printf("Interrupt Arrived: %d\n",sig_num);
//
//    gpio_dataval = vadd_gpio[0];
//    printf("GPIO Data Value :0x%08x\n", gpio_dataval);
//
//}
//
//int main ()
//
//{
//	int fd , ret, len;
//	unsigned int pid;
//
//	off_t GPIO_pbase = XAXIGPIO_BASE;
//	fd = open("/dev/mem", O_RDWR /*| O_SYNC*/);
//	if (fd == -1)
//	 {
//	    printf("Can't open /dev/mem.\n");
//	    exit(0);
//	 }
//	printf("/dev/mem opened.\n");
//	vadd_gpio = (u32 *)mmap(NULL, MAP_SIZE, PROT_READ | PROT_WRITE, MAP_SHARED, fd, GPIO_pbase);
//	   if(vadd_gpio == (u32 *) -1)
//	   {
//	      printf("Can't map the GPIO memory to user space.......%s\n",strerror(errno));
//	        exit(0);
//	    }
//	    printf("GPIO Memory mapped at address %p.\n", vadd_gpio);
//	    gpio_dataval = vadd_gpio[0];
//	    printf("GPIO Data Value :0x%08x\n", gpio_dataval);
//
//
//	pid = getpid();
//
//	printf("Hello %d\n",getpid());
//	signal(SIGRTMIN + 2, sig_handler);
//
//	 fd = open("/dev/char_device", O_RDWR);             // Open the device with read/write access, note name "char_device" must match with device name mentioned in xilinx gpio driver. If you want different name, change both here as well as in the driver
//	if (fd < 0) {
//		perror("Failed to open the device...");
//		return errno;
//	}
//
//
//	while(1) {
//
//		sleep(1); // infinite while loop so that the program never ends. Note that we have confirmed that when interrupt arrives,
//				  // processor is going to run the signal handler code above and wont wait for sleep timer to expire before running signal handler code
//	}
//
//	return 0;
//}
