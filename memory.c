#include <stdlib.h>
#include <stdint.h>


#include "base.h"
#include "mmu.h"
#include "memory.h"

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

/*
 * returns a virtual memory address that can be used for additional mapping of memory
 * useful when drivers need access to memory mapped io
 */
void* virtual_memory_slot_get(process_id_t id){
    int i = 0; 
    int8_t *is_occupied = (int8_t*)calloc(( VIRT_MEM_SIZE/MMU_PAGE_SIZE), sizeof(int8_t));
    is_occupied[0] = MEM_OCCUPIED; // 0 is reseved for kernel
    
    PCB_t *pcb = pcb_get(id);
    mem_mapping_t* node = pcb->mem_next;
    // search for memory that is already mapped for the process
    while(node){
        is_occupied[ (node->virtual_address >> 20) ] = MEM_OCCUPIED;
        node = node->mem_next;
    }
    // select a 
    for(i = 0; i < VIRT_MEM_SIZE/MMU_PAGE_SIZE; i++){
        if(is_occupied[i] == MEM_VACANT){
            free(is_occupied);
            return (void*)(i << 20);
        }
    }
    return NULL;
}


void memory_slot_free(void* addr){
    memory_slots_real[((uint32_t)addr >> 20)] = MEM_VACANT;
}

mem_mapping_t* memory_map_get(uint32_t virtual, uint32_t physical){
    mem_mapping_t* ret = (mem_mapping_t*)malloc(sizeof(mem_mapping_t));
    ret->virtual_address = virtual;
    ret->physical_address = physical;
    ret->mem_next = NULL;
    return ret;
}

int memory_add_mapping(process_id_t id, uint32_t virtual, uint32_t physical){
    // get new node
    mem_mapping_t* node = memory_map_get(virtual, physical);
    
    if(node == NULL){   return -1;}

    PCB_t* pcb = pcb_get(id);
  
    mem_mapping_t* it = pcb->mem_next;

    pcb->mem_next = node;

    node->mem_next = it;
    
    return 1;
}


int memory_remove_mapping(process_id_t id, uint32_t virtual, uint32_t physical){

    PCB_t* pcb = pcb_get(id);
    mem_mapping_t* del;
    mem_mapping_t** it = &pcb->mem_next;
    
    while(*it){
        if( (*it)->virtual_address == virtual && (*it)->physical_address){
            del = *it;
            *it = (*it)->mem_next;
            free(del); 
            return 1;
        }
        it = &(*it)->mem_next;
    }
    return 0;
}

int memory_perform_process_mapping(process_id_t id){
    PCB_t *pcb = pcb_get(id);
    mem_mapping_t *node = pcb->mem_next;
    while(node){
               
        mmu_remap_section(  node->virtual_address,
                            node->physical_address,
	                        SET_FORMAT_SECTION
	                      | SECTION_SHAREABLE
	                      | SECTION_ACCESS_PL1_RW_PL0_RW
	                      | SECTION_OUT_INN_WRITE_BACK__WRITE_ALOC
	                      | SECTION_EXECUTE_ENABLE
	                      | 0 << SECTION_DOMAIN // set the domain of this section to 0
	                      | SECTION_GLOBAL
	                      | SECTION_NON_SECURE);
        node = node->mem_next;
    }
    return 1;
}

int memory_perform_process_unmapping(process_id_t id){
    PCB_t *pcb = pcb_get(id);
    mem_mapping_t *node = pcb->mem_next;
    while(node){
        mmu_remap_section(  node->virtual_address, 0, 0);
        node = node->mem_next;
    }
    return 1;
}

int memory_remove_all_mappings(process_id_t id){
    PCB_t *pcb = pcb_get(id);
    mem_mapping_t *node = pcb->mem_next;
    mem_mapping_t *del;
    while(node){
        del = node;
        node = node->mem_next;
        free(del);
    }
    return 1;   
}

