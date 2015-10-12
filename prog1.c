
#include <stdint.h>
#include "uart.h"
#include "control.h"
#include "pcb.h"
#include "prog1.h"
#include "ipc.h"


void prog1(void){
    volatile uint32_t x=0;
    while(1){
        // do something
        
        uart_puts("1 sending x\r\n");
        ipc_send(2, (void*)&x, sizeof(x) );
        
        uart_puts("1: ");
        uart_put_uint32_t(x++, 10);
        uart_puts("\r\n");

    }
}

void prog2(void){
    volatile uint32_t x=0;
    while(1){
        // do something
        
        uart_puts("2: ");
        uart_put_uint32_t(x++, 10);
        uart_puts("\r\n");
        
        uart_puts("receiving x: \r\n");
        ipc_receive((void*)&x,sizeof(x)); 
        
    }
}

void prog3(void){
    volatile uint32_t x=0;
    while(1){
        x++;
    }
}
