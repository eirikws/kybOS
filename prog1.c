
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
        uart_put_uint32_t(++x, 10);
        uart_puts("\r\n");

    }
}

void prog2(void){
    volatile uint32_t x=0;
    volatile uint32_t y=0;
    int from;
    while(1){
        // do something
        
        uart_puts("2: ");
        uart_put_uint32_t(y++, 10);
        uart_puts("\r\n");
        
        uart_puts("2 receiving x: \r\n");
        from = ipc_receive((void*)&x,sizeof(x));
        uart_puts("2 x is ");
        uart_put_uint32_t(x, 10);
        uart_puts("     from  ");
        uart_put_uint32_t(from, 10);
        uart_puts("\r\n");
        
        
    }
}

void prog3(void){
    volatile uint32_t x=0;
    while(1){
        x++;
        uart_puts("3 is runniiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiing\r\n");
    }
}
