
#include <stdint.h>
#include "uart.h"
#include "control.h"
#include "pcb.h"
#include "prog1.h"
#include "ipc.h"


void prog1(void){
    uint32_t x=0;
    uint32_t y=0;
    uart_puts("at start of prog 1\r\n");
    while(1){
        y++;
        if (y%1000000 == 0 ){
            uart_puts("1 sending x:");
            uart_put_uint32_t(++x, 10);
            uart_puts("\r\n");
            ipc_send( (process_id_t){2} , &x, sizeof(x));
        }
        
    }
}

void prog2(void){
    uint32_t x=0;
    process_id_t from;
    uart_puts("at start of prog 2\r\n");
    while(1){
        uart_puts("prog 2 calling receive\r\n");
        from = ipc_receive(&x, sizeof(x));
        uart_puts("2 received x=");
        uart_put_uint32_t(x, 10);
        uart_puts(" from ");
        uart_put_uint32_t(from.id_number, 10);
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
