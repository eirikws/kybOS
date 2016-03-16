#include <stdint.h>
#include "barrier.h"
#include "control.h"
#include "base.h"
#include "mailbox.h"


#define MAILBOX_BASE            (PERIPHERAL_BASE + 0xB880)
#define MAILBOX_READ           (volatile uint32_t*)MAILBOX_BASE
#define MAILBOX_PEEK            ((volatile uint32_t*)(MAILBOX_BASE + 0x10))

#define MAILBOX_STATUS          ((volatile uint32_t*)(MAILBOX_BASE + 0x18))
#define MAILBOX_STATUS_EMPTY    0x40000000
#define MAILBOX_STATUS_FULL     0x80000000
#define MAILBOX_WRITE           ((volatile uint32_t*)(MAILBOX_BASE + 0x20))
#define MAILBOX_CHANNEL_PM      0
#define MAILBOX_CHANNEL_FB      1
#define BCM_MAILBOX_PROP_OUT    8
#define MAILBOX_SENDER          ((volatile uint32_t*)(MAILBOX_BASE + 0x14))
#define MAILBOX_CONFIG          ((volatile uint32_t*)(MAILBOX_BASE + 0x1c))
#define MAILBOX_VM_OFFSET       0x40000000
/*
 * data is an location of a buffer, int ARM adress mode. transform it to VC address.
 */
void mailbox_write(volatile uint32_t *addr, uint8_t chan){
    while( *MAILBOX_STATUS & MAILBOX_STATUS_FULL){}// do nothing
    *MAILBOX_WRITE = (chan | (uint32_t)addr | MAILBOX_VM_OFFSET);
}

uint32_t mailbox_read(uint8_t chan){
    uint32_t data;
    while(1){
        while( *MAILBOX_STATUS & MAILBOX_STATUS_EMPTY){ /* do nothing*/ }
        data = *MAILBOX_READ;
        if (chan == (uint8_t)(data & 0xf)){ 
            return (data & 0xfffffff0);
        }
    }
    return 0x0000BEEF;
}

// for flushing the buffer. 
static void flush(void){
    volatile uint32_t dummy;
    while(!( *MAILBOX_STATUS & MAILBOX_STATUS_EMPTY)){
        dummy = *MAILBOX_READ;
    }
}

uint32_t mailbox_write_read(volatile uint32_t *addr, uint8_t chan){
    barrier_data_mem();
    flush();       // make sure buffer is empty
    mailbox_write(addr, chan);
    barrier_data_mem();
    uint32_t result = mailbox_read(chan);
    barrier_data_mem();
    return result;
}

