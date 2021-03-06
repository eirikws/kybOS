#include <stdint.h>
#include <stdlib.h>
#include <string.h>

#include "time.h"
#include "scheduler.h"
#include "drivers.h"
#include "ipc.h"
#include "uart.h"
#include "control.h"
#include "fs.h"
#include "pcb.h"
#include "mmu.h"
#include "memory.h"
#include "process.h"

#define INSTR_SET_ARM       0x28
#define ELF_MAGIC_NUM       0x7f

static const char elf_magic_string[] = "ELF";
extern uint32_t _process_stack_init(uint32_t sp, uint32_t entry, uint32_t mode);

// 32bit version
struct elf_header{
    uint8_t magic_number;   // should be 0x7f
    char magic_string[3];   // should be "ELF"
    uint8_t word_size;      // 1 == 32bit 2 = 64bit
    uint8_t endianess;      // 1 == little endiand, 2 == big
    uint8_t elf_ver;
    uint8_t OS_ABI;
    uint8_t reserved[8];
    uint16_t type;          // 1==relocatable, 2==executable, 3==shared, 4==core
    uint16_t instruction_set;
    uint32_t elf_ver2;
    uint32_t program_entry;
    uint32_t program_header;
    uint32_t section_header;
    uint32_t flags;
    uint16_t header_size;
    uint16_t prog_entry_size;
    uint16_t prog_entry_num;
    uint16_t sec_entry_size;
    uint16_t sec_entry_num;
    uint16_t sec_name_index;
};

// 32bit version
struct program_header{
    uint32_t segment_type;
    uint32_t p_offset;      // where segment lies in the file
    uint32_t p_vadder;      // where it should be put in virtual memory
    uint32_t undefined;
    uint32_t p_filesz;      // size of segment in file
    uint32_t p_memsz;       // size of segment in memory
    uint32_t flags;
    uint32_t alignment;
};

// 32bit
struct section_header{
    uint32_t name;
    uint32_t type;
    uint32_t flags;
    uint32_t address;
    uint32_t offset;
    uint32_t size;
};

int process_load(const char* file_path, size_t priority, int mode, process_id_t id){
    // read first segment of the file.
    // this contains the elf header and program header
    
    if( ( pcb_id_compare(id, NULL_ID)) || pcb_get(id) != NULL){
        uart_puts("Process load: ID is reserved\r\n");
        return -1;
    }

    uint8_t *buf = (uint8_t*)malloc(0x20000);
    int ret = fs_get()->fs_load(file_path, buf, 0x20000);
    if(ret == -1){
        uart_puts("Process load: file not valid\r\n");
        free(buf);
        return -1;
    }
    struct elf_header *myheader = (struct elf_header*)buf;

    // read elf header
    if(( myheader->magic_number != ELF_MAGIC_NUM) || strncmp(myheader->magic_string, elf_magic_string, 3)){
        uart_puts("Process load: file not a elf file\r\n");
        uart_puts("Magic number is ");
        uart_put_uint32_t(buf[0], 16);
        uart_puts("\r\nAnd magic  string is: ");
        uart_putc(buf[1]);
        uart_putc(buf[2]);
        uart_putc(buf[3]);
        uart_puts("\r\n");
        free(buf);
        return -1;
    }

    if( myheader->word_size != 1){
        uart_puts("Process load: elf file not 32 bit\r\n");
        free(buf);
        return -1;
    }

    if( myheader->type != 2){
        uart_puts("Process load: file not executable\r\n");
        free(buf);
        return -1;
    }

    if( myheader->instruction_set != INSTR_SET_ARM ){
        uart_puts("Process load The instruction set is not ARM. Try to use another compiler\r\n");
        free(buf);
        return -1;
    }

    // the new process should go in here!
    void* dest = memory_slot_get();

    struct program_header *prog_header = (struct program_header*)&buf[myheader->program_header];
 //   struct section_header *sect_header = (struct section_header*)&buf[myheader->section_header];

    PCB_t pcb = {   .id = id, 
                    .state = READY, 
                    .priority = priority,
                    .physical_address = (uint32_t)dest,
    };

    // save the old mapping for p_vadder
    uint32_t old_mapping = mmu_get_mapping(prog_header->p_vadder);

    mmu_remap_section(  prog_header->p_vadder,
                        (uint32_t)dest,
                        SET_FORMAT_SECTION
                      | SECTION_SHAREABLE
                      | SECTION_ACCESS_PL1_RW_PL0_NONE
                      | SECTION_OUT_INN_WRITE_BACK__WRITE_ALOC
                      | SECTION_EXECUTE_ENABLE
                      | 0 << SECTION_DOMAIN // set the domain of this section to 0
                      | SECTION_GLOBAL
                      | SECTION_NON_SECURE);

    memset((void*)prog_header->p_vadder, 0, prog_header->p_memsz);
    memcpy((void*)prog_header->p_vadder, buf + prog_header->p_offset , prog_header->p_filesz);

    // make PCB
    pcb.stack_start = (1 << 20) - 0x1000 + prog_header->p_vadder;

    pcb.stack_pointer = _process_stack_init(pcb.stack_start, myheader->program_entry, mode);
    
    pcb_insert(pcb);
    memory_add_mapping(id, prog_header->p_vadder, (uint32_t)dest);
    // unmap process now that we are done with it

    mmu_remap_section(  prog_header->p_vadder, 0, old_mapping);

    free(buf);

    return 1;
}

int process_start( process_id_t id){
    PCB_t *pcb = pcb_get(id);
    if( pcb == NULL){
        uart_puts("Process start: id is not valid\r\n");
        return -1;
    }
    return scheduler_enqueue(id);
}

#define SPAWN_MODE_ERROR        (1 << 0)
#define SPAWN_LOAD_ERROR        (1 << 1)
#define SPAWN_ID_OCCUPIED       (1 << 2)
extern void _enable_interrupts(void);
extern void _disable_interrupts(void);

scheduling_type_t process_spawn( spawn_args_t *args){
    int mode;
    process_id_t id = args->id;
    if(args->mode == SPAWN_USER){
        mode = CPSR_MODE_USER;
    }else if(args->mode == SPAWN_SUPERVISOR){
        mode = CPSR_MODE_SVR;
    }else{
        args->flags |= SPAWN_MODE_ERROR;
        return NO_RESCHEDULE;
    }
    if( pcb_get(args->id) != NULL){
        args->flags |= SPAWN_ID_OCCUPIED;
    }
    // enable interrupts because process load requires time interrupts
    // should be moved out to a driver-process, but alas, time...
    // disable rescheduling for time interrupts
    set_preemptive_timer(0);
    _enable_interrupts();
    if( process_load( args->path, args->priority, mode, args->id)  != 1){
        args->flags |= SPAWN_LOAD_ERROR;
        _disable_interrupts();
        set_preemptive_timer(1);
        return RESCHEDULE;
    }
    _disable_interrupts();
    set_preemptive_timer(1);
    // disable interrupts
    process_start(id);
    return RESCHEDULE;
}

scheduling_type_t process_kill( process_id_t id){
    // empty msg queue
    ipc_flush_msg_queue(id);
    // free memory
    memory_slot_free( (void*)pcb_get(id)->physical_address); 
    //free driver
    driver_remove(id);
    // remove pcb
    pcb_remove(id);
    if( pcb_id_compare(id, get_current_running_process()) == 1){
        return RESCHEDULE_DONT_SAVE_CONTEXT;
    }else{
        return RESCHEDULE;
    }
}

