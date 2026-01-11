#include <stdio.h>
#include <stdbool.h>
#ifndef _MSC_VER
#include <unistd.h>
#endif
#include <string.h>
#include <stdlib.h>
#include <errno.h>
#include <pthread.h>
#include <sched.h>
#include <semaphore.h>

#include "libmodbus/modbus.h"

#include <math.h>
#include <time.h>
//#include <fcntl.h>
#include <sys/ioctl.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <sys/socket.h>
//#include <netinet/in.h>
#include <sys/mman.h>
//#include <netdb.h>


#include <linux/input.h>
#include <linux/inotify.h>

#include <stdatomic.h>
