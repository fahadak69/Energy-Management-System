//This is code relies on using UIO driver (uio_pdrv_genirq.c) to receive GPIO Interrupt
//In device tree, don't use GPIO_KEY node (KEY is used only if using xilinx gpio driver)

#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <sys/mman.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>


#define XAXIGPIO_DATACH1_OFFSET 		0x00000000   	//Offset for gpio channel 1 data register
#define XAXIGPIO_STATUS_OFFSET 			0x00000120   	//Offset for status register
#define XAXIGPIO_GOLBALINTR_OFFSET 		0x0000011C		//Offset for global interrupt enable register
#define XAXIGPIO_CHNLINTR_OFFSET 		0x00000128		//offset for ch1 and ch2 register


#define MAP_SIZE 65536 //size of GPIO IP Memory - Comes from Vivado Address Editor


void *do_map(int size, int * fd)
{

	void *mio;

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

	unsigned char *ptr = NULL;
	int fd;
	ssize_t intr_count = 0;
	int count = 0;
	int size = MAP_SIZE;
	int uio_intr_en=1;

	printf("GPIO UIO App\n");

	ptr = (unsigned char *) do_map(size,&fd);

	if(!ptr) {
		printf("mmap failed, exiting\n");
		return 0;
	}

	*((unsigned int *)(ptr + XAXIGPIO_GOLBALINTR_OFFSET)) = 0x80000000; //Enable global interrupt in IP
	*((unsigned int *)(ptr + XAXIGPIO_CHNLINTR_OFFSET)) = 0x1; //Enable channel 1 interrupt (since inputs are connected to ch1 of gpio ip)

	printf("Reading Global Intr Reg: value: 0x%08x, Reading Chnl Intr Reg: value: 0x%08x \n",*((unsigned int *)(ptr + XAXIGPIO_GOLBALINTR_OFFSET)), *((unsigned int *)(ptr + XAXIGPIO_CHNLINTR_OFFSET)));

	while (1) {

	printf("Reading Status Reg: value: 0x%08x \n",*((unsigned int *)(ptr + XAXIGPIO_STATUS_OFFSET)));
	intr_count = read(fd,&count,sizeof(count)); //blocking read, gets blocked until a new interrupt arrives
	printf("GPIO DATA : value: 0x%08x \n",*((unsigned int *)(ptr + XAXIGPIO_DATACH1_OFFSET)));

	printf("count = %d, intr_count = %ld\n",count,intr_count);

	*((unsigned int *)(ptr + XAXIGPIO_STATUS_OFFSET)) = 0x1; //writing 1 to interrupt status register to clear it back to zero
	write(fd,&uio_intr_en,sizeof(uio_intr_en)); //Interr handler in UIO Driver disables interr controller after receiving interr. Re-enabling it for next interrupt by writing 0x1 to the device

	}


	munmap(ptr,size);
	return 0;


}
