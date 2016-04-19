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
/*  
 *  configure the SCTLR such that the cpu behaves as wanted
 *  Most important is to turn on the MMU, caches, cache placement strategy,
 *  set the location of interrupt vectors to low, enable swp and swpb, 
 *  enable intruction and data barriers and alignment checks.
 */
void cpu_control_config(void);


void cpu_cache_disable(void);
void cpu_cache_enable(void);

/*  
 *  get the current CPU mode
*/
char cpu_mode_print(void);

/*
 *  set the cpu mode to mode
 */
extern void _set_cpu_mode(cpu_mode_t mode);

/*
 * get the value of cpsr register
*/
extern cpu_mode_t _get_cpsr(void);


void cpu_fpu_enable(void);



#endif
