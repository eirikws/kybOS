#include "time.h"
#include "armtimer.h"
#include "scheduler.h"

static unsigned long long time = 0;

/*
 * Check if it is time for rescheduling
 */

time_for_reschedule(){
    return 1;
}


/*
 *  Does all time related things. Returns with 1 to call for a 
 *  context switch
 */
uint32_t time_handler(void){
    time++;

    // Check if we want to schedule
    if ( time_for_reschedule() ){
        reschedule();
        return 1;
    } else {
        return 0;

    }
}

unsigned long long time_get(void){
    return time;
}

