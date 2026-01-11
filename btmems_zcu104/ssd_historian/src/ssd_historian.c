/*
 * Copyright (c) 2012 Xilinx, Inc.  All rights reserved.
 *
 * Xilinx, Inc.
 * XILINX IS PROVIDING THIS DESIGN, CODE, OR INFORMATION "AS IS" AS A
 * COURTESY TO YOU.  BY PROVIDING THIS DESIGN, CODE, OR INFORMATION AS
 * ONE POSSIBLE   IMPLEMENTATION OF THIS FEATURE, APPLICATION OR
 * STANDARD, XILINX IS MAKING NO REPRESENTATION THAT THIS IMPLEMENTATION
 * IS FREE FROM ANY CLAIMS OF INFRINGEMENT, AND YOU ARE RESPONSIBLE
 * FOR OBTAINING ANY RIGHTS YOU MAY REQUIRE FOR YOUR IMPLEMENTATION.
 * XILINX EXPRESSLY DISCLAIMS ANY WARRANTY WHATSOEVER WITH RESPECT TO
 * THE ADEQUACY OF THE IMPLEMENTATION, INCLUDING BUT NOT LIMITED TO
 * ANY WARRANTIES OR REPRESENTATIONS THAT THIS IMPLEMENTATION IS FREE
 * FROM CLAIMS OF INFRINGEMENT, IMPLIED WARRANTIES OF MERCHANTABILITY
 * AND FITNESS FOR A PARTICULAR PURPOSE.
 *
 */

#include <unistd.h>
#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <dirent.h>
#include <string.h>
#include<sched.h>
#include <inttypes.h>
#include <sys/stat.h>
#include <sys/vfs.h>

#include <sys/mount.h>
#include <errno.h>
#include <sys/mman.h>
#include "defines.h"

UWord32 fd;
unsigned page_size;
char DirName[80];
FILE *DATAFile;
time_t t;
struct tm tm;
struct tm gtm;
RECORD D1;
struct timeval start_time, end_time;
long milli_time, seconds, useconds;
#define MEMORY_ACCESS	"/dev/mem"
#define READ_WRITE	O_RDWR

void initMemory(void) {
	//access ZYNQ FPGA with read/write privelidges
	fd = open(MEMORY_ACCESS, READ_WRITE | O_SYNC);
	//fd = open(MEMORY_ACCESS, READ_WRITE);
	if (fd < 1) {
		//display error incase of failure
		printf("Error:\tcant't access IO registers\n");
		exit(1);
	}
	//set virtual memory page size, required for mapping FPGA onto Linux virtual memory
	page_size = sysconf(_SC_PAGESIZE);
}

void cleanupMemory(void) {
	//clear varibales
	if (fd >= 1) {
		close(fd);
	}
	page_size = 0;
}

int RT_Cyle_Per_Second() {
	// Converting time into milli_seconds

	int Clocks_Cycle = 0;

	// Storing start time
	clock_t start_time = clock();
	clock_t stop_time = clock();
	t = time(NULL);
	tm = *localtime(&t);
	D1.timeStampH = tm.tm_hour;
	D1.timeStampM = tm.tm_min;
	D1.timeStampS = tm.tm_sec;
	t = time(NULL);

	do {
		t = time(NULL);
		tm = *localtime(&t);
	} while (D1.timeStampS == tm.tm_sec);
	stop_time = clock();
	Clocks_Cycle = stop_time - start_time;
	return Clocks_Cycle;

}
void delay(int number_of_ms) {
	// Converting time into milli_seconds


	int milli_seconds = number_of_ms;
	 gettimeofday(&start_time, NULL);
	// Storing start time
	//clock_t start_time = clock();

	D1.V1 = D1.V1 + 1;
	D1.V2 = D1.V2 + 10;
	D1.V3 = D1.V3 + 100;

		do{
		  gettimeofday(&end_time, NULL);
		   seconds = end_time.tv_sec - start_time.tv_sec; //seconds
		   useconds = end_time.tv_usec - start_time.tv_usec; //milliseconds
		   milli_time = ((seconds) * 1000 + useconds/1000.0);
}while(milli_time<number_of_ms);
		milli_time=end_time.tv_usec/1000.0;
		  if (milli_time>=1000) { // Allow for rounding up to nearest second
			  milli_time -=1000;
			  printf(" adjust miliseconds\n");
		    end_time.tv_sec++;
		  }
		t = time(NULL);
		tm = *localtime(&end_time.tv_sec);
		D1.timeStampH = tm.tm_hour;
		D1.timeStampM = tm.tm_min;
		D1.timeStampS = tm.tm_sec;

		  // printf("Elapsed time: %ld", milli_time);
		 //  printf(" milliseconds\n");


	//while (clock() < start_time + milli_seconds);

	D1.timeStampms = milli_time;

}

int mkdir_mnt() {
	struct stat st = { 0 };
	char FileLocName[256] = "";
	char FileName[256];
	char tmp[80];
	sprintf(DirName, "/run/media/sda/DATA_LOGGING");
	t = time(NULL);
	tm = *localtime(&t);
	gtm=tm;
	sprintf(FileName, "%s", "/");
	sprintf(tmp, "%d", tm.tm_year + 1900);
	strcat(FileName, tmp);
	strcat(FileName, "-");
	sprintf(tmp, "%02d", tm.tm_mon + 1);
	strcat(FileName, tmp);
	strcat(FileName, "-");
	sprintf(tmp, "%02d", tm.tm_mday);
	strcat(FileName, tmp);
	strcat(FileName, ".txt");

	if (stat("/run/media/sda/DATA_LOGGING", &st) == -1) {

		printf("Create new folder\n");
		mkdir("/run/media/sda/DATA_LOGGING", 0777);
	} else {
		printf("Folder1 exists\n");
	}

	// sprintf(FileName, "/DATA_LOG_FILE_1.txt");
	strcat(FileLocName, DirName);
	strcat(FileLocName, FileName);

	DATAFile = fopen(FileLocName, "w");
	if (DATAFile == NULL) {
		printf("File open Failed for %s\n", FileLocName);
		return -1;
	} else {
		printf("File Created %s\n", FileLocName);
	}

	return 0;
}

int Update_File_Name() {
	fclose(DATAFile);
	struct stat st = { 0 };
	char FileLocName[256] = "";
	char FileName[256];
	char tmp[80];
	sprintf(DirName, "/run/media/sda/DATA_LOGGING");
	t = time(NULL);
	tm = *localtime(&t);
	gtm=tm;
	sprintf(FileName, "%s", "/");
	sprintf(tmp, "%d", tm.tm_year + 1900);
	strcat(FileName, tmp);
	strcat(FileName, "-");
	sprintf(tmp, "%02d", tm.tm_mon + 1);
	strcat(FileName, tmp);
	strcat(FileName, "-");
	sprintf(tmp, "%02d", tm.tm_mday);
	strcat(FileName, tmp);
	strcat(FileName, ".txt");
	strcat(FileLocName, DirName);
	strcat(FileLocName, FileName);

	DATAFile = fopen(FileLocName, "w");
	if (DATAFile == NULL) {
		printf("File open Failed for %s\n", FileLocName);
		return -1;
	} else {
		printf("File Created %s\n", FileLocName);
	}

	return 0;
}
int main() {



	initMemory();
	mkdir_mnt();
int delay_Count = 300; //in mili seconds
	D1.V1 = 0;
	D1.V2 = 0;
	D1.V3 = 0;

	int i;
	fprintf(DATAFile, "Time,DummyVarName1,DummyVarName2,DummyVarName3;");
	for (i = 0; i < 10; i++) {
		delay(delay_Count);
		fprintf(DATAFile, "%02d:%02d:%02d:%d,%d,%d,%d;", D1.timeStampH,
				D1.timeStampM, D1.timeStampS, (D1.timeStampms) , D1.V1,
				D1.V2, D1.V3);
	}
	fclose(DATAFile);
	cleanupMemory();

	return 0;
}
