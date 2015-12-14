#ifndef CONTROL_H
#define CONTROL_H


typedef enum{
    CPSR_MODE_USER  =       0x10,
    CPSR_MODE_FIQ   =       0x11,
    CPSR_MODE_IRQ   =       0x12,
    CPSR_MODE_SVR   =       0x13,
    CPSR_MODE_ABORT =       0x17,
    CPSR_MODE_UNDEFINED =   0x1B,
    CPSR_MODE_SYSTEM =      0x1F,
    CPSR_IRQ_INHIBIT =      0x80,
    CPSR_FIQ_INHIBIT =      0x40,
} cpu_mode_t;

char cpu_mode_print(void);
extern void _set_cpu_mode(cpu_mode_t mode);
extern cpu_mode_t _get_cpsr(void);





#endif
