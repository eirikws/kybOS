
#include <stdint.h>
#include "uart.h"
#include "control.h"
#include "pcb.h"
#include "prog1.h"
#include "ipc.h"


void prog1(void){
    uint32_t x=0;
    while(1){
        x++;
        /*
        uart_puts("this is prog1");
        uart_put_uint32_t(x, 10);
        uart_puts("\r\n");*/
        //uart_puts("h\r\n");
        if (x%1000000 == 0 ){
            uart_puts("1 sending x:");
            uart_put_uint32_t(x, 10);
            uart_puts("\r\n");
            ipc_send(2 , &x, sizeof(x));
        }
        
    }
}

void prog2(void){
    uint32_t x=0;
    int from;
    while(1){/*
        uart_puts("this is prog2");
        uart_put_uint32_t(x++, 10);
        uart_puts("\r\n");
    */
    
        uart_puts("prog 2 calling receive\r\n");
        from = ipc_receive(&x, sizeof(x));
        uart_puts("2 received x=");
        uart_put_uint32_t(x, 10);
        uart_puts(" from ");
        uart_put_uint32_t(from, 10);
        uart_puts("\r\n");
        
    }
}

void prog3(void){
    volatile uint32_t x=0;
    while(1){
            x++;
            uart_puts("3 is runniiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiing\r\n");
    }
}
