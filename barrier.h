
#ifndef BARRIER_H
#define BARRIER_H

/*
   a data memory barrier
*/

static inline void barrier_data_mem(void){
    asm volatile ("dmb" ::: "memory");
}

static inline void barrier_instruction(void){
    asm volatile ("isb" ::: "memory");
}

static inline void barrier_data_sync(void){
    asm volatile ("dsb" ::: "memory");
}

#endif
