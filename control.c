
#include <stdint.h>
#include "control.h"
#include "dispatcher.h"
#include "pcb.h"
#include "uart.h"

char get_cpu_mode(void){
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

void _save_spsr(uint32_t spsr ){
    uint32_t current_running = get_current_running();
    PCB_t* pcb = pcb_get(current_running);
    pcb->context_data.CPSR = spsr;
}

uint32_t _restore_spsr(void){
    uint32_t current_running = get_current_running();
    PCB_t* pcb = pcb_get(current_running);
    return pcb->context_data.CPSR;
}
