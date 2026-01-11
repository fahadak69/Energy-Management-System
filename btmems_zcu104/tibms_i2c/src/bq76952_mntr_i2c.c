///*
// * Copyright (c) 2012 Xilinx, Inc.  All rights reserved.
// *
// * Xilinx, Inc.
// * XILINX IS PROVIDING THIS DESIGN, CODE, OR INFORMATION "AS IS" AS A
// * COURTESY TO YOU.  BY PROVIDING THIS DESIGN, CODE, OR INFORMATION AS
// * ONE POSSIBLE   IMPLEMENTATION OF THIS FEATURE, APPLICATION OR
// * STANDARD, XILINX IS MAKING NO REPRESENTATION THAT THIS IMPLEMENTATION
// * IS FREE FROM ANY CLAIMS OF INFRINGEMENT, AND YOU ARE RESPONSIBLE
// * FOR OBTAINING ANY RIGHTS YOU MAY REQUIRE FOR YOUR IMPLEMENTATION.
// * XILINX EXPRESSLY DISCLAIMS ANY WARRANTY WHATSOEVER WITH RESPECT TO
// * THE ADEQUACY OF THE IMPLEMENTATION, INCLUDING BUT NOT LIMITED TO
// * ANY WARRANTIES OR REPRESENTATIONS THAT THIS IMPLEMENTATION IS FREE
// * FROM CLAIMS OF INFRINGEMENT, IMPLIED WARRANTIES OF MERCHANTABILITY
// * AND FITNESS FOR A PARTICULAR PURPOSE.
// *
// */
//
////This code is taken from TI application note slua801 (section A.3 page 16) with register numbers modified for battery monitor bq76952 and "guage" in the function names replaced with "monitor"
////this code uses system calls (read and write functions) to perform read and write. Repeated start is not possible using this method
//
//#include <unistd.h>
//#include <stdio.h>
//#include <stdlib.h>
//#include <stdbool.h>
//#include <linux/i2c-dev.h>
//#include <fcntl.h>
//#include <sys/stat.h>
//#include <string.h>
//
//
//
//typedef struct
//{
//int nI2C;
//unsigned char nAddress;
//} TI2C;
//
//int monitor_read(void *pHandle, unsigned char nRegister, unsigned char *pData, unsigned char
//nLength)
//{
//TI2C *pI2C = (TI2C *) pHandle;
//int n;
//if (nLength < 1) return 0;
//pData[0] = nRegister;
//n = write(pI2C->nI2C, pData, 1); // write register address
//n = read(pI2C->nI2C, pData, nLength); // read data from register
////printf ("Bytes Read %d\n",n);
//usleep(100);
//return n;
//}
//
//unsigned int monitor_cmd_read(void *pHandle, unsigned char nCmd)
//{
//unsigned char pData[2];
//monitor_read(pHandle, nCmd, pData, 2);
//return (pData[1] << 8) | pData[0];
//}
//
//
//void monitor_address(void *pHandle, unsigned char nAddress)
//{
//
//TI2C *pI2C = (TI2C *) pHandle;
//int tmp_return;
//if (nAddress != pI2C->nAddress)
//{
//	tmp_return= ioctl(pI2C->nI2C, I2C_SLAVE, nAddress >>1);
////printf ("Monitor Address Result %d\n",tmp_return);
//}
//pI2C->nAddress = nAddress;
//}
//
//int main()
//{
//	int tst_usrinpt = 0;
//	TI2C i2c;
//	void *pHandle = (void *) & i2c;
//	unsigned int nResult;
//
//	printf("TI BQ76952 Monitor Test\n\r");
//	if ((i2c.nI2C = open("/dev/i2c-0", O_RDWR)) <0)
//	{
//	printf("cannot open I2C bus\n\r");
//	exit(1);
//	}
//	printf("openend I2C bus\n\r");
//
//	do {
//
//	monitor_address(pHandle, 0x10); //ti monitor default slave address (7bit) is 0x8, 0x10 is being shifted right in the function above to convert to 0x8
//
//	nResult = monitor_cmd_read(pHandle, 0x14);
//	printf(" Cell 1 VOLTAGE = %04d [mV]\n\r", nResult);
//
//	nResult = monitor_cmd_read(pHandle, 0x32);
//	printf(" Cell 16 VOLTAGE = %04d [mV]\n\r", nResult);
//
//	nResult = monitor_cmd_read(pHandle, 0x34);
//	printf(" Stack VOLTAGE = %04d [mV]\n\r", nResult);
//
//	nResult = monitor_cmd_read(pHandle, 0x36);
//	printf(" Pack VOLTAGE = %04d [mV]\n\r", nResult);
//	printf("Enter 1 to Continue Test\n");
//	scanf ("%d",&tst_usrinpt);
//	} while (tst_usrinpt==1);
//
//    return 0;
//}
