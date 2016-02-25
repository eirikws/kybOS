
#include "memory.h"
#include "mmu.h"


typedef enum {
    MEM_VACANT,
    MEM_OCCUPIED,
} mem_slot_t;

/*
* using 1 MB sections
* this means that there are 1 GB/1MB = 1024 
* slots of real memory
*/
int memory_slots_real[1024];

/*
 * virtual memory contains 32 bit = 2^32 adresses
 * 2^32/1MB = 2^12 = 4096 sections
 */
int memory_slots_virtual[4096];






void memory_init(void){
    // initialize high interrupts
}




















