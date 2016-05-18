
#include <stdint.h>
#include "control.h"
#include "uart.h"

// SCTLR bits
#define THUMB_EXCEPTION_ENABLE                          (1 << 30)
#define THUMB_EXCEPTION_DISABLE                         (0 << 30)
#define ACCESS_FLAG_ENABLE                              (1 << 29)
#define ACCESS_FLAG_DISABLE                             (0 << 29)
#define TEX_REMAP_ENABLE                                (1 << 28)
#define TEX_REMAP_DISABLE                               (0 << 28)
#define NON_MASKABLE_FIQ_SUPPORT_OFFSET                 27
#define EXCEPTION_ENDIANNESS_LITTLE                     (0 << 26)
#define EXCEPTION_ENDIANNESS_BIT                        (1 << 26)
#define INTERRUPT_VECTORS_USR_MADE                      (1 << 25)
#define INTERRUPT_VECTORS_STD                           (0 << 25)
#define FIQ_CONFIG_ENABLE_OFFSET                        21
#define HARDWARE_ACCESS_FLAG_ENABLE                     (1 << 17)
#define HARDWARE_ACCESS_FLAG_DISABLE                    (0 << 17)
#define CACHE_PLACEMENT_STRATEGY_NORMAL                 (1 << 14)
#define CACHE_PLACEMENT_STRATEGY_PREDICTABLE            (0 << 14)
#define VECTORS_HIGH                                    (1 << 13)
#define VECTORS_LOW                                     (0 << 13)
#define CACHE_INSTRUCTION_ENABLE                        (1 << 12)
#define CACHE_INSTRUCTION_DISABLE                       (0 << 12)
#define BRANCH_PREDICTION_ENABLE                        (1 << 11)
#define BRANCH_PREDICTION_DISABLE                       (0 << 11)
#define SWP_SWPB_ENABLE                                 (1 << 10)
#define SWP_SWPB_DISABLE                                (0 << 10)
#define BARRIERS_CP15_ENABLE                            (1 << 5)
#define BARRIERS_CP15_DISABLE                           (0 << 5)
#define CACHE_DATA_ENABLE                               (1 << 2)
#define CACHE_DATA_DISABLE                              (0 << 2)
#define ALIGNMENT_CHECK_ENABLE                          (1 << 1)
#define ALIGNMENT_CHECK_DISABLE                         (0 << 1)
#define MMU_ENABLE                                      (1 << 0)
#define MMU_DISABLE                                     (0 << 0)



/*  
 *  Configure the SCTLR
 */

void cpu_control_config(void){
	uint32_t mode =   MMU_ENABLE
	                | ALIGNMENT_CHECK_ENABLE
	                | CACHE_DATA_ENABLE
	                | BARRIERS_CP15_ENABLE
	                | SWP_SWPB_ENABLE
	                | BRANCH_PREDICTION_ENABLE
	                | CACHE_INSTRUCTION_ENABLE
	                | VECTORS_LOW
	                | INTERRUPT_VECTORS_STD
	                | CACHE_PLACEMENT_STRATEGY_PREDICTABLE
	                | HARDWARE_ACCESS_FLAG_DISABLE
	                | INTERRUPT_VECTORS_STD
	                | EXCEPTION_ENDIANNESS_LITTLE
	                | TEX_REMAP_DISABLE
	                | ACCESS_FLAG_DISABLE
	                | THUMB_EXCEPTION_DISABLE ;         
	__asm volatile ("mcr p15, 0, %0, c1, c0, 0" :: "r" (mode) : "memory");
}

void cpu_cache_disable(void){
    uint32_t reg;
    __asm volatile ("mrc p15, 0, %0, c1, c0, 0" : "=r" (reg));
    reg &= ~(CACHE_DATA_ENABLE);
    __asm volatile ("mcr p15, 0, %0, c1, c0, 0" :: "r" (reg) : "memory");
}

void cpu_cache_enable(void){
    uint32_t reg;
    __asm volatile ("mrc p15, 0, %0, c1, c0, 0" : "=r" (reg));
    reg |= (CACHE_DATA_ENABLE);
    __asm volatile ("mcr p15, 0, %0, c1, c0, 0" :: "r" (reg) : "memory");
}
void cpu_set_irq_vectors_high(void){
    uint32_t w_reg;
    __asm volatile ("mrc p15, 0, %0, c1, c0, 0" : "=r" (w_reg));
    w_reg |= VECTORS_HIGH;
    __asm volatile ("mrc p15, 0, %0, c1, c0, 0" :: "r" (w_reg) : "memory");


}

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
    }return 0;
}

void cpu_fpu_enable(void){
    __asm volatile ("mrc p15, 0, r0, c1, c1, 2");
    __asm volatile ("orr r0, r0, #0b11<<10");
    __asm volatile ("mcr p15, 0, r0, c1, c1, 2");
    __asm volatile ("ldr r0, =(0xf << 20)");
    __asm volatile ("mcr p15, 0, r0, c1, c0, 2");
    __asm volatile ("mov r3, #0x40000000");
    __asm volatile ("vmsr fpexc, r3");
}

