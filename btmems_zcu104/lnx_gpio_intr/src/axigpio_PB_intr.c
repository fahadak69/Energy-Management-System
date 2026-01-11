//#include <stdio.h>
//#include <stdlib.h>
//#include <time.h>
//#include <fcntl.h>
//#include <signal.h>
//#include <pthread.h>
//#include <linux/input.h>
//
//
//#define    INPUT_EVENT    "/dev/input/event0"
//
//
//int main()
//{
//    struct input_event ev;
//    int tmp;
//    int key_code;
//    int size = sizeof(ev);
//
//    /* Read event0 */
//    tmp = open(INPUT_EVENT, O_RDONLY /*| O_NONBLOCK*/);//fa - O_NONBLOCK is for non-block read
//    if (tmp < 0) {
//        printf("\nOpen " INPUT_EVENT " failed!\n");
//        return 1;
//    }
//    /* Read and parse event, update global variable */
//    while (1) {
//        if (read(tmp, &ev, size) < size) {
//            printf("\nReading from " INPUT_EVENT " failed!\n");
//            return 1;
//        }
//
//        if (ev.value == 1 && ev.type == 1) {    /* Down press only */
//            key_code = ev.code;
//            if (key_code == KEY_DOWN) {
//                printf ("KEY DOWN INTERRUPT \n");
//
//            } else if (key_code == KEY_UP) {    /* raise speed */
//            	printf ("KEY UP INTERRUPT \n");
//            }
//            printf ("Before sleep");
//            usleep(1000);
//            printf ("After sleep");
//        }
//        //printf ("LOOPING BACK");
//    }
//}
