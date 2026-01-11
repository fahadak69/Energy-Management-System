/*
 * File:   defines.h
 * Author: rwr
 *
 * Created on April 26, 2016, 2:50 PM
 */

#ifndef DEFINES_H
#define	DEFINES_H

#include <stdio.h>
#include <stdlib.h>
#include <time.h>

#ifndef 	FALSE
#define 	FALSE       0
#endif /* FALSE */

#ifndef		TRUE
#define		TRUE        1
#endif /* TRUE */

/* ---------------- DATA TYPES ------------------ */
typedef		unsigned char		UWord8;
typedef		unsigned short		UWord16;
typedef		unsigned int		UWord32;
typedef		unsigned long long	UWord64;

typedef struct DATA_RECORD
{
    int timeStampH;
    int timeStampM;
    int timeStampS;
    int timeStampms;
    int V1;
    int V2;
    int V3;
    int V4;
    int V5;
    int V6;
    int V7;
    int V8;
    int V9;
    int V10;
} RECORD;


#endif	/* DEFINES_H */

