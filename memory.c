#include <stdlib.h>
#include <stdint.h>


#include "base.h"
#include "mmu.h"
#include "memory.h"


typedef enum {
    MEM_VACANT,
    MEM_OCCUPIED,
    MEM_IO,
} mem_slot_t;

/*
* using 1 MB sections
* this means that there are 1 GB/1MB = 1024 
* slots of physical memory
*/
static int8_t memory_slots_physical[PHYS_MEM_SIZE/MMU_PAGE_SIZE];

/*
 * virtual memory contains 32 bit = 2^32 adresses
 * 2^32/1MB = 2^12 = 4096 sections
 */
//static uint32_t memory_slots_virtual[VIRT_MEM_SIZE/MMU_PAGE_SIZE];


void memory_init(void){
    // file secions of memory that are filled by OS
    memory_slots_physical[0] = MEM_OCCUPIED;        // kernel and interrupts are here!
    uint32_t i = PERIPHERAL_BASE;
    for(i = PERIPHERAL_BASE/MMU_PAGE_SIZE; i < PHYS_MEM_SIZE/MMU_PAGE_SIZE; i++){
        memory_slots_physical[i] = MEM_IO;    // peripherals are memory mapped here
    }
}

/*
 * returns a pointer to start of a 1 MB section of memory
 * and sets that section as occupied
 */
void* memory_slot_get(void){
    uint32_t i = 10;
    while( memory_slots_physical[i] != MEM_VACANT){
        i++;
        if( i > (PHYS_MEM_SIZE/MMU_PAGE_SIZE)){ return NULL;} 
    }
    memory_slots_physical[i] = MEM_OCCUPIED;
    return (void*)(i << SECTION_BASE_ADDRESS_OFFSET);
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
        is_occupied[ (node->virtual_address >> SECTION_BASE_ADDRESS_OFFSET) ] = MEM_OCCUPIED;
        node = node->mem_next;
    }
    // select a 
    for(i = 0; i < VIRT_MEM_SIZE/MMU_PAGE_SIZE; i++){
        if(is_occupied[i] == MEM_VACANT){
            free(is_occupied);
            return (void*)(i << SECTION_BASE_ADDRESS_OFFSET);
        }
    }
    return NULL;
}


void memory_slot_free(void* addr){
    memory_slots_physical[((uint32_t)addr >> SECTION_BASE_ADDRESS_OFFSET)] = MEM_VACANT;
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
        // check what type of memory it is. if it is IO memory
        // then dont use the cache!!
        if( memory_slots_physical[(node->physical_address >> SECTION_BASE_ADDRESS_OFFSET)] == MEM_IO){
            
	        mmu_remap_section(      node->virtual_address,
                                    node->physical_address, 
                                    SET_FORMAT_SECTION
	                              | SECTION_SHAREABLE
	                              | SECTION_ACCESS_PL1_RW_PL0_RW
	                              | SECTION_DEVICE_SHAREABLE
	                              | SECTION_EXECUTE_NEVER
	                              | 0 << SECTION_DOMAIN
	                              | SECTION_GLOBAL
	                              | SECTION_NON_SECURE);
        }else{  // if not io memory, use the cache!!
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
        }
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

void memory_map(void* retval, uint32_t address, process_id_t id){
    // check if region already is mapped
    PCB_t* pcb = pcb_get(id);
    mem_mapping_t *node = pcb->mem_next;
    uint32_t ret;
    int found  = 0;
    while( node){
        if( ((uint32_t)address >> SECTION_BASE_ADDRESS_OFFSET) == (node->physical_address >> SECTION_BASE_ADDRESS_OFFSET)){
            //  found another mapping that exists. use this one
            ret = node->virtual_address;
            found = 1;
            break;
        }
        node = node->mem_next;
    }
    // if not in existing mapping, create a new one
    if( found != 1){
        ret = (uint32_t)virtual_memory_slot_get(id);
        memory_add_mapping(id, ret, address);
    }
    // ret now contains the base address
    // adjust for the rest!
    ret += address % MMU_PAGE_SIZE;
    *(uint32_t*)retval = ret;
}


