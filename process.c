#include <stdint.h>
#include <stdlib.h>
#include <string.h>

#include "scheduler.h"
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
    uint32_t p_filesz;
    uint32_t p_memsz;
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
    uint8_t *buf = (uint8_t*)malloc(0x20000);
    int ret = fs_get()->fs_load(file_path, buf, 0x20000);
    if(ret == -1){
        uart_puts("Process load: file not valid\r\n");
        return -1;
    }
    
    struct elf_header *myheader = (struct elf_header*)buf;

    // read elf header
    //const char* c = buf+1;
    if(( myheader->magic_number != ELF_MAGIC_NUM) || strncmp(myheader->magic_string, elf_magic_string, 3)){
        uart_puts("Process load: file not a elf file\r\n");
        uart_puts("Magic number is ");
        uart_put_uint32_t(buf[0], 16);
        uart_puts("\r\nAnd magic  string is: ");
        uart_putc(buf[1]);
        uart_putc(buf[2]);
        uart_putc(buf[3]);
        uart_puts("\r\n");
        return -1;
    }

    if( myheader->word_size != 1){
        uart_puts("Process load: elf file not 32 bit\r\n");
        return -1;
    }

    if( myheader->type != 2){
        uart_puts("Process load: file not executable\r\n");
        return -1;
    }

    if( myheader->instruction_set != INSTR_SET_ARM ){
        uart_puts("Process load The instruction set is not ARM. Try to use another compiler\r\n");
        return -1;
    }
    
    uart_puts("prog entry is ");
    uart_put_uint32_t(myheader->program_entry, 16);
    uart_puts(" program header is ");
    uart_put_uint32_t(myheader->program_header, 10);
    uart_puts("\r\n");
    

    // the new process should go in here!
    void* dest = memory_slot_get();
    uart_puts("new process is put in ");
    uart_put_uint32_t((int)dest, 16);
    uart_puts("\r\n");

    struct program_header *prog_header = (struct program_header*)&buf[myheader->program_header];
 //   struct section_header *sect_header = (struct section_header*)&buf[myheader->section_header];

    PCB_t pcb = {   .id = id, 
                    .state = READY, 
                    .priority = priority,
                    .context_data.virtual_address = prog_header->p_vadder,
                    .context_data.real_address = (uint32_t)dest,
                  //  .context_data.stack_start = (1 << 20)-0x1000,
    };
    uart_puts("Process load: mapping memory\r\n");

    cpu_mode_print();
    mmu_remap_section(  pcb.context_data.virtual_address,
                        pcb.context_data.real_address,
                        SET_FORMAT_SECTION
                      | SECTION_SHAREABLE
                      | SECTION_ACCESS_PL1_RW_PL0_NONE
                      | SECTION_OUT_INN_WRITE_BACK__WRITE_ALOC
                      | SECTION_EXECUTE_ENABLE
                      | 0 << SECTION_DOMAIN // set the domain of this section to 0
                      | SECTION_GLOBAL
                      | SECTION_NON_SECURE);
        
    

    uart_puts("remapped slot ");
    uart_put_uint32_t(pcb.context_data.virtual_address >> 20, 10);
    uart_puts(" to point to real physical address ");
    uart_put_uint32_t( (pcb.context_data.real_address >> SECTION_BASE_ADDRESS_OFFSET) << SECTION_BASE_ADDRESS_OFFSET, 16);
    uart_puts("\r\n");
    uart_puts("Process load: map complete\r\n");
    cpu_mode_print();
    memset((void*)pcb.context_data.virtual_address, 0, prog_header->p_memsz);
    memcpy((void*)pcb.context_data.virtual_address, buf + prog_header->p_offset , prog_header->p_filesz);

    uart_puts("code is now put in memory\r\n");
    cpu_mode_print();
    // make PCB
    pcb.context_data.stack_start = (1 << 20) - 0x1000 + pcb.context_data.virtual_address;

    pcb.context_data.SP = _process_stack_init(pcb.context_data.stack_start, myheader->program_entry, mode);
    
    pcb_insert(pcb);
    
    // unmap process now that we are done with it
    mmu_remap_section(  pcb.context_data.virtual_address, 0,0);

    uart_puts("New process ");
    uart_put_uint32_t( id.id_number, 10);
    uart_puts(" lies at real address ");
    uart_put_uint32_t(pcb.context_data.real_address, 16);
    uart_puts(" and should linked to Virt adr ");
    uart_put_uint32_t(pcb.context_data.virtual_address, 16);
    uart_puts("\r\nThe stack is at virtual address ");
    uart_put_uint32_t(pcb.context_data.SP, 16);
    uart_puts("\r\n");

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



