#ifndef TIME_H
#define TIME_H
#include <stdint.h>

// the main unit of time int kybOS.
typedef struct{
    uint32_t increments;
    uint32_t seconds;
} time_unit_t;

// called from main irq handeler if a timer has made a interrupt.
uint32_t time_handler(void);

// function for getting the time.
time_unit_t time_get(void);


// function that delays in a loop until the right amount of time has passed.
int time_delay_microseconds(int n);


// adds n microseconds to time_in
void time_add_microseconds(time_unit_t *time_in, int n);


/*
 *  returns 1 if op1 > op2
 *          0 if op1 == op2
 *         -1 if op1 < op2
 */
int time_compare(time_unit_t op1, time_unit_t op2);

#endif
