
#include <stdint.h>
#include "control.h"
#include "uart.h"

char cpu_mode_print(void){
    int32_t cpsr = _get_cpsr();
    int32_t mode = cpsr & 0b11111;
    switch(mode){
        case CPSR_MODE_USER:
            uart_puts("CPSR_MODE_USER\r\n");
            return CPSR_MODE_USER;
            break;
        case CPSR_MODE_FIQ:
            uart_puts("CPSR_MODE_FIQ\r\n");
            return CPSR_MODE_FIQ;
            break;
        case CPSR_MODE_IRQ:
            uart_puts("CPSR_MODE_IRQ\r\n");
            return CPSR_MODE_IRQ;
            break;
        case CPSR_MODE_SVR:
            uart_puts("CPSR_MODE_SVR\r\n");
            return CPSR_MODE_SVR;
            break;
        case CPSR_MODE_ABORT:
            uart_puts("CPSR_MODE_ABORT\r\n");
            return CPSR_MODE_ABORT;
            break;
        case CPSR_MODE_UNDEFINED:
            uart_puts("CPSR_MODE_UNDEFINED\r\n");
            return CPSR_MODE_UNDEFINED;
            break;
        case CPSR_MODE_SYSTEM:
            uart_puts("CPSR_MODE_SYSTEM\r\n");
            return CPSR_MODE_SYSTEM;
            break;
    }
}
