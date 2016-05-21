#ifndef MEMORY_H
#define MEMORY_H

#include <stdint.h>
#include "scheduler.h"
#include "pcb.h"

void memory_init(void);
void* memory_slot_get(void);
void* virt_memory_slot_get(process_id_t id);
void memory_slot_free(void* addr);
int memory_perform_process_mapping(process_id_t id);
int memory_perform_process_unmapping(process_id_t id);
int memory_add_mapping(process_id_t id, uint32_t virtual, uint32_t physical);
int memory_remove_mapping(process_id_t id, uint32_t virtual, uint32_t physical);
int memory_remove_all_mappings(process_id_t id);
scheduling_type_t memory_map(void* retval, uint32_t address, process_id_t id); 
scheduling_type_t memory_srbk( int incr, process_id_t id);
#endif
