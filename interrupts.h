
#ifndef INTERRUPTS_H
#define INTERRUPTS_H

#include <stdint.h>

/* 
    Important bits
*/
#define ARM_TIMER_IRQ         (1 << 0)
#define ARM_MAILBOX_IRQ       (1 << 1)
#define ARM_DOORBELL_0_IRQ    (1 << 2)
#define ARM_DOORBELL_1_IRQ    (1 << 3)
#define GPU_0_HALTED_IRQ      (1 << 4)
#define GPU_1_HALTED_IRQ      (1 << 5)
#define ACCESS_ERROR_1_IRQ    (1 << 6)
#define ACCESS_ERROR_0_IRQ    (1 << 7)
#define UART_IRQ              (1 << 25)




/*
    The interrupt controller memory mapped register set
*/
typedef struct irq_controller{
    // see where IRQ came from
    volatile uint32_t IRQ_basic_pending;   
    // more irq sources. Everything concerns the GPU 
    volatile uint32_t IRQ_pending_1;
    volatile uint32_t IRQ_pending_2;
    // controls which source can generate a FIQ. Only one can be selected
    volatile uint32_t FIQ_control;
    // enable interrupt generation
    volatile uint32_t Enable_IRQs_1;
    volatile uint32_t Enable_IRQs_2;
    volatile uint32_t Enable_Basic_IRQs;
    // disable interrupts
    volatile uint32_t Disable_IRQs_1;
    volatile uint32_t Disable_IRQs_2;
    volatile uint32_t Disable_Basic_IRQs;
} irq_controller_t;


irq_controller_t* irq_controller_get( void );

#endif
