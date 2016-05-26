#include "time.h"
#include "armtimer.h"
#include "scheduler.h"
#include "uart.h"

// the main time keeper in kybos. incremented each timer interrupt.
static time_unit_t system_time;

/*
 * Check if it is time for rescheduling
 */

static int scheduling_on = 0;

void set_preemptive_timer(int onOff){
    scheduling_on = onOff;
}

static int time_for_reschedule(){
    return scheduling_on;
}


/*
 *  Does all time related things. Returns with 1 to call for a 
 *  context switch
 */
uint32_t time_handler(void){
    arm_timer_irq_ack();
    system_time.increments++;
    if (system_time.increments >= arm_timer_get_freq()){
        system_time.seconds++;
        system_time.increments = 0;
    }
    // Check if we want to schedule
    if ( time_for_reschedule() ){
        return 1;
    } else {
        return 0;
    }
}

time_unit_t time_get(void){
    return system_time;
}

void time_add_microseconds(time_unit_t *time_in, int n){
    int irq_freq = arm_timer_get_freq();
    int additional_increments = n * (irq_freq / 1000);
    time_in->seconds +=  (additional_increments + time_in->increments)/ irq_freq;
    time_in->increments = (additional_increments + time_in->increments) % irq_freq;
}

int time_compare(time_unit_t op1, time_unit_t op2){
    if (op1.seconds > op2.seconds){ return 1;}
    else if (op1.seconds < op2.seconds){ return -1;}
    else if (op1.increments > op2.increments){ return 1;}
    else if (op1.increments < op2.increments){ return -1;}
    return 0;
}


int time_delay_microseconds(int n){
    time_unit_t time_now = system_time;
    time_add_microseconds(&time_now, n);
    while( time_compare(time_now, time_get()) == 1){}
    return 1;
}

