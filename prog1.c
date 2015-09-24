
#include <stdint.h>
#include "uart.h"
#include "prog1.h"


void  prog1(void){
    uint32_t x=0;
    while(1){
        // do something
        uart_puts("1: ");
        uart_put_uint32_t(x++, 10);
        uart_puts("\r\n");
    }
}

void  prog2(void){
    uint32_t x=0;
    while(1){
        // do something
        uart_puts("2: ");
        uart_put_uint32_t(x++, 10);
        uart_puts("\r\n");
    }
}
