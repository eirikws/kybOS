
#ifndef BARRIER_H
#define BARRIER_H

/*
   a data memory barrier
*/

static inline void barrier_data_mem(void){
    __asm volatile ("dmb" ::: "memory");
}

static inline void barrier_instruction(void){
    __asm volatile ("isb" ::: "memory");
}

static inline void barrier_data_sync(void){
    __asm volatile ("dsb" ::: "memory");
}

#endif
