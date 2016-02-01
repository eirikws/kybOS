#include <timer.h>
#include "arm_timer.h"



static long long time = 0;

uint32_t time_handler(void){
    time++;
    schedule();
}

time_get(void){
    return time;
}


