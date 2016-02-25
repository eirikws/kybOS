#include "time.h"
#include "armtimer.h"
#include "scheduler.h"

static unsigned int time_increments = 0;
static unsigned long long seconds = 0;




/*
 * Check if it is time for rescheduling
 */

int time_for_reschedule(){
    return 1;
}


/*
 *  Does all time related things. Returns with 1 to call for a 
 *  context switch
 */
uint32_t time_handler(void){
    arm_timer_irq_ack();
    time_increments++;
    if (time_increments > arm_timer_get_freq()){
        seconds++;
        time_increments = 0;
    }
    uart_puts("|");
    // Check if we want to schedule
    if ( time_for_reschedule() ){
        reschedule();
        return 1;
    } else {
        return 0;
    }
}

unsigned int time_increments_get(void){
    return time_increments;
}

unsigned long long time_get_seconds(void){
    return seconds;
}
