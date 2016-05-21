#include <stdlib.h>
#include <stdint.h>
#include "mmu.h"
#include "barrier.h"



static volatile __attribute__ ((aligned (0x4000))) uint32_t page_table[VIRT_MEM_SIZE/MMU_PAGE_SIZE];

uint32_t mmu_get_mapping(uint32_t virtual){
    return page_table[virtual >> SECTION_BASE_ADDRESS_OFFSET];
}

void mmu_init_table(void) {
	uint32_t base = 0;
	// initialize page_table
	// 1024MB - 16MB of kernel memory
	// each page describes xx00000-xxFFFFF.

    // first page is operating system
	page_table[base] =    SET_FORMAT_SECTION
	                      | base << SECTION_BASE_ADDRESS_OFFSET
	                      | SECTION_SHAREABLE
	                      | SECTION_ACCESS_PL1_RW_PL0_NONE
	                      | SECTION_OUT_INN_WRITE_BACK__WRITE_ALOC
	                      | SECTION_EXECUTE_ENABLE
	                      | 0 << SECTION_DOMAIN // set the domain of this section to 0
	                      | SECTION_GLOBAL
	                      | SECTION_NON_SECURE;
    
    base++;
    // the next ones are for processes. they are not loaded yet,
    // so should be only accessable by PL1
	for (; base < 1024-16; base++) {
	    page_table[base] = 0;
	}
	
	// 16 MB peripherals at 0x3F000000-3ffffffff
	for (; base < 1024; base++) {
	    page_table[base] =      SET_FORMAT_SECTION
	                          | base << SECTION_BASE_ADDRESS_OFFSET
	                          | SECTION_SHAREABLE
	                          | SECTION_ACCESS_PL1_RW_PL0_NONE
	                          | SECTION_DEVICE_SHAREABLE
	                          | SECTION_EXECUTE_NEVER
	                          | 0 << SECTION_DOMAIN
	                          | SECTION_GLOBAL
	                          | SECTION_NON_SECURE;
	}
	// we have now reached 0x400000000 which is 1 GB, the size of RPI2 memory
	// which means that the rest of memory should be invalid
	for (; base < 4096; base++) {
	    page_table[base] = 0;
	}
	return;
}

// ACTLR bits
#define DISABLE_DUAL_ISSUE                  28
#define DISABLE_DISTRIBUTED_VIRTUAL_MEM     15
#define L1_DATA_PREFETCH_CONTROL            13
#define L1_DATA_CACHE_READ_ALLOC_DISABLE    12
#define L2_DATA_CACHE_READ_ALLOC_DISABLE    11
#define DISABLE_OPT_DATA_MEM_BARRIER        10
#define SMP_ENABLE_COHERENT_REQUESTS        6

// DACR bits
#define DOMAIN_NO_ACCESS                            0
#define DOMAIN_CLIENT                               1
#define DOMAIN_MANAGER                              3

// TTBCR bits
#define TRANSLATION_TABLE_WALK_DISABLE_TTBR1        5
#define TRANSLATION_TABLE_WALK_DISABLE_TTBR0        4
#define TTBR0_BASE_ADDRESS_WIDTH                    0

// TTBR0 bits
#define TTB_ADRESS                                      14
#define TTB_NOT_OUTER_SHAREABLE                         5
#define TTB_REGION_NON_CACHEABLE                        (0 << 3)
#define TTB_REGION_OUT_WRITEBACK_WRITE_ALLOC_CACHEABLE  (1 << 3)
#define TTB_REGION_OUT_WRITETHROUGH_CACHEABLE           (2 << 3)
#define TTB_REGION_OUT_WRITEBACK__NO_WRITE_ALLOC_CACHE  (3 << 3)
#define TTB_SHAREABLE                                   (1 << 1)
#define TTB_CACHEABLE                                   (1 << 0)
#define TTB_INNER_NON_CACHEABLE                         (0 << 0 | 0 << 6)
#define TTB_INNER_WRITETHROUGH_WRITE_ALLOC_CACHEABLE    (1 << 0 | 0 << 6)
#define TTB_INNER_WRITE_THROUGH_CACHEABLE               (0 << 0 | 1 << 6)
#define TTB_INNER_WRITE_BACK__NO_WRITE_ALLOC_CACHEABLE  (1 << 1 | 1 << 6)



void mmu_configure(void) {
	// set SMP bit in ACTLR. MUST be done before the MMU is enabled.
	uint32_t auxctrl;
	__asm volatile ("mrc p15, 0, %0, c1, c0,  1" : "=r" (auxctrl));
	auxctrl |= 1 << SMP_ENABLE_COHERENT_REQUESTS;
	__asm volatile ("mcr p15, 0, %0, c1, c0,  1" :: "r" (auxctrl));

    // set domain 0 to be domain manager
    uint32_t dacr = (DOMAIN_MANAGER << 0);
	__asm volatile ("mcr     p15, 0, %0, c3, c0, 0" :: "r" (dacr));

	// configure TTBRC to always use TTBR0
	// the reset value is the correct one, but it can't hurt to be safe!
	__asm volatile ("mcr p15, 0, %0, c2, c0, 2" :: "r" (0));
    
    // configure the TTBR0
	uint32_t ttb_descr =       (unsigned)&page_table
	                        |   TTB_SHAREABLE
	                        |   TTB_REGION_OUT_WRITEBACK_WRITE_ALLOC_CACHEABLE
	                        |   TTB_INNER_WRITETHROUGH_WRITE_ALLOC_CACHEABLE;
	
	__asm volatile ("mcr p15, 0, %0, c2, c0, 0"
		      :: "r" (ttb_descr));
	barrier_instruction();
}

    // This follows the break-before-make method described in 
    // B3 virtual Memory System Architecture (VMSA) 
    // B3.10 TLB maintenance requirements 
    // inn the arm architecture reference manual Armv7-A armv7-R
void mmu_remap_section(uint32_t virt, uint32_t physical, uint32_t config_flags){
    // 1. invalidate old translation table entry.
    page_table[virt >> SECTION_BASE_ADDRESS_OFFSET] = 0;
    // 2. execute dsb.
    barrier_data_sync();
    // 3. invalidate the translation table with a broadcast TLB invalidation instruction.
    // Invlaidate unified TLB by writing to TLBIALL
    __asm volatile ("mcr p15, 0, %0, c8, c7, 0" :: "r" (0));
    // 4. write new entry.
    page_table[virt >> SECTION_BASE_ADDRESS_OFFSET] = config_flags
                  |( (physical >> SECTION_BASE_ADDRESS_OFFSET) << SECTION_BASE_ADDRESS_OFFSET);
    // 5. data barrier
    barrier_data_sync();
    __asm volatile ("mcr p15, 0, %0, c8, c7, 0" :: "r" (0));
    barrier_data_sync();
}

void mmu_table_update(void){
    barrier_data_sync();
    __asm volatile ("mcr p15, 0, %0, c8, c7, 0" :: "r" (0));
    barrier_data_sync();
    __asm volatile ("mcr p15, 0, %0, c8, c7, 0" :: "r" (0));
    barrier_data_sync();
}

void mmu_cache_invalidate(uint32_t address){
    __asm volatile ("mcr p15, 0, %0, c7, c14, 1"::"r"(address));
    barrier_data_mem();
    barrier_data_sync();
}


