#include <stdint.h>
#include "barrier.h"
#include "control.h"
#include "base.h"
#include "mailbox.h"


#define MAILBOX_VC_BASE         (PERIPHERAL_BASE + 0xB880)

typedef struct{
   volatile uint32_t   READ;
   volatile uint32_t   unused[3]; 
   volatile uint32_t   PEEK;
   volatile uint32_t   SENDER;
   volatile uint32_t   STATUS;
   volatile uint32_t   CONFIG; 
   volatile uint32_t   WRITE;
} mailbox_t;

static mailbox_t* mailboxVC = (mailbox_t*)MAILBOX_VC_BASE;

inline  mailbox_t* mailbox_vc_get(void){
    return mailboxVC;
}

#define MAILBOX_STATUS_EMPTY    0x40000000
#define MAILBOX_STATUS_FULL     0x80000000
#define MAILBOX_VM_OFFSET       0x40000000
/*
 * data is an location of a buffer, int ARM adress mode. transform it to VC address.
 */
void mailbox_write(volatile uint32_t *addr, uint8_t chan){
    while( mailbox_vc_get()->STATUS & MAILBOX_STATUS_FULL){}// do nothing
    mailbox_vc_get()->WRITE = (chan | (uint32_t)addr | MAILBOX_VM_OFFSET);
}

uint32_t mailbox_read(uint8_t chan){
    uint32_t data;
    while(1){
        while( mailbox_vc_get()->STATUS & MAILBOX_STATUS_EMPTY){ /* do nothing*/ }
        data = mailbox_vc_get()->READ;
        if (chan == (uint8_t)(data & 0xf)){ 
            return (data & 0xfffffff0);
        }
    }
}

// for flushing the buffer. 
static void flush(void){
    while(!( mailbox_vc_get()->STATUS & MAILBOX_STATUS_EMPTY)){
        mailbox_vc_get()->READ;
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

