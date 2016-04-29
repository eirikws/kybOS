#include <stdlib.h>
#include <stdint.h>


#include "base.h"
#include "memory.h"
#include "mmu.h"

#define VIRT_MEM_SIZE       0x40000000
#define PHYS_MEM_SIZE       (1 << 30)       // 1 GB memory
#define MMU_PAGE_SIZE       (1 << 20)       // 1 MB

typedef enum {
    MEM_VACANT,
    MEM_OCCUPIED,
} mem_slot_t;

/*
* using 1 MB sections
* this means that there are 1 GB/1MB = 1024 
* slots of real memory
*/
static int8_t memory_slots_real[PHYS_MEM_SIZE/MMU_PAGE_SIZE];

/*
 * virtual memory contains 32 bit = 2^32 adresses
 * 2^32/1MB = 2^12 = 4096 sections
 */
//static uint32_t memory_slots_virtual[VIRT_MEM_SIZE/MMU_PAGE_SIZE];






void memory_init(void){
    // file secions of memory that are filled by OS
    memory_slots_real[0] = MEM_OCCUPIED;        // kernel and interrupts are here!
    uint32_t i = PERIPHERAL_BASE;
    for(i = PERIPHERAL_BASE/MMU_PAGE_SIZE; i < PHYS_MEM_SIZE/MMU_PAGE_SIZE; i++){
        memory_slots_real[i] = MEM_OCCUPIED;    // peripherals are memory mapped here
    }
}

/*
 * returns a pointer to start of a 1 MB section of memory
 * and sets that section as occupied
 */
void* memory_slot_get(void){
    uint32_t i = 10;
    while( memory_slots_real[i] == MEM_OCCUPIED){
        i++;
        if( i > (PHYS_MEM_SIZE/MMU_PAGE_SIZE)){ return NULL;} 
    }
    memory_slots_real[i] = MEM_OCCUPIED;
    return (void*)(i << 20);
}

void memory_slot_free(void* addr){
    memory_slots_real[((uint32_t)addr >> 20)] = MEM_VACANT;
}



