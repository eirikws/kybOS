#include <stdlib.h>
#include <stdint.h>
#include "mmu.h"
#include "barrier.h"

// paging bits
// page: SECTION bits
#define SECTION_BASE_ADDRESS_OFFSET      20
#define SECTION_NS                      19
#define SECTION_nG                      17
#define SECTION_S                       16
#define SECTION_AP2                     15
#define SECTION_TEX                     12
#define SECTION_AP01                    10
#define SECTION_DOMAIN                  5
#define SECTION_XN                      4
#define SECTION_C                       3
#define SECTION_B                       2
#define section_PXN                     0

// page: SECTION bit values
#define SECTION_NON_SECURE              (0 << SECTION_NS)
#define SECTION_SECURE                  (1 << SECTION_NS)
#define SECTION_NON_GLOBAL              (1 << SECTION_nG)
#define SECTION_GLOBAL                  (0 << SECTION_nG)
#define SECTION_SHAREABLE               (1 << SECTION_S)
#define SECTION_NON_SHAREABLE            (0 << SECTION_S)
#define SECTION_ACCESS_PL1_NONE_PL0_NONE    ((0 << SECTION_AP01) | (0 << SECTION_AP2))
#define SECTION_ACCESS_PL1_RW_PL0_NONE      ((1 << SECTION_AP01) | (0 << SECTION_AP2))
#define SECTION_ACCESS_PL1_RW_PL0_RO        ((2 << SECTION_AP01) | (0 << SECTION_AP2))
#define SECTION_ACCESS_PL1_RW_PL0_RW        ((3 << SECTION_AP01) | (0 << SECTION_AP2))
#define SECTION_ACCESS_PL1_RO_PL0_NONE      ((1 << SECTION_AP01) | (1 << SECTION_AP2))
#define SECTION_ACCESS_PL1_RO_PL0_RO        ((3 << SECTION_AP01) | (1 << SECTION_AP2))
#define SECTION_EXECUTE_NEVER               (1 << SECTION_XN)
#define SECTION_EXECUTE_ENABLE              (0 << SECTION_XN)
#define SET_FORMAT_SECTION                  ((2 << 0) << (0 << 18))

// page: Memory attributes
#define SECTION_STRONGLY_ORDERED    ((0 << SECTION_TEX) | (0 << SECTION_C) | (0 << SECTION_B))
#define SECTION_DEVICE_SHAREABLE         ((0 << SECTION_TEX) | (0 << SECTION_C) | (1 << SECTION_B))
#define SECTION_OUT_IN_WR_THROUGH__NO_WRITE_ALOC  ((0 << SECTION_TEX) | (1 << SECTION_C) | (0 << SECTION_B))
#define SECTION_OUT_IN_WR_BACK__NO_WRITE_ALOC   ((0 << SECTION_TEX) | (1 << SECTION_C) | (1 << SECTION_B))
#define SECTION_OUT_INN_NON_CACHABLE    ((1 << SECTION_TEX) | (0 << SECTION_C) | (0 << SECTION_B))
#define SECTION_OUT_INN_WRITE_BACK__WRITE_ALOC    ((1 << SECTION_TEX) | (1 << SECTION_C) | (1 << SECTION_B))
#define SECTION_DEVICE_NON_SHAREABLE    ((2 << SECTION_TEX) | (0 << SECTION_C) | (0 << SECTION_B))


static volatile __attribute__ ((aligned (0x4000))) uint32_t page_table[4096];

void mmu_init_table(void) {
	uint32_t base;
	// initialize page_table
	// 1024MB - 16MB of kernel memory
	// each page describes xx00000-xxFFFFF.
	for (base = 0; base < 1024-16; base++) {
	    page_table[base] =    SET_FORMAT_SECTION
	                          | base << SECTION_BASE_ADDRESS_OFFSET
	                          | SECTION_SHAREABLE
	                          | SECTION_ACCESS_PL1_RW_PL0_RW
	                          | SECTION_OUT_INN_WRITE_BACK__WRITE_ALOC
	                          | SECTION_EXECUTE_ENABLE
	                          | 0 << SECTION_DOMAIN // set the domain of this section to 0
	                          | SECTION_GLOBAL
	                          | SECTION_NON_SECURE;
	}
	
	// 16 MB peripherals at 0x3F000000-3ffffffff
	for (; base < 1024; base++) {
	    page_table[base] =      SET_FORMAT_SECTION
	                          | base << SECTION_BASE_ADDRESS_OFFSET
	                          | SECTION_SHAREABLE
	                          | SECTION_ACCESS_PL1_RW_PL0_RW
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

// SCTLR bits
#define THUMB_EXCEPTION_ENABLE                          (1 << 30)
#define THUMB_EXCEPTION_DISABLE                         (0 << 30)
#define ACCESS_FLAG_ENABLE                              (1 << 29)
#define ACCESS_FLAG_DISABLE                             (0 << 29)
#define TEX_REMAP_ENABLE                                (1 << 28)
#define TEX_REMAP_DISABLE                               (0 << 28)
#define NON_MASKABLE_FIQ_SUPPORT_OFFSET                 27
#define EXCEPTION_ENDIANNESS_LITTLE                     (0 << 26)
#define EXCEPTION_ENDIANNESS_BIT                        (1 << 26)
#define INTERRUPT_VECTORS_USR_MADE                      (1 << 25)
#define INTERRUPT_VECTORS_STD                           (0 << 25)
#define FIQ_CONFIG_ENABLE_OFFSET                        21
#define HARDWARE_ACCESS_FLAG_ENABLE                     (1 << 17)
#define HARDWARE_ACCESS_FLAG_DISABLE                    (0 << 17)
#define CACHE_PLACEMENT_STRATEGY_NORMAL                 (1 << 14)
#define CACHE_PLACEMENT_STRATEGY_PREDICTABLE            (0 << 14)
#define VECTORS_HIGH                                    (1 << 13)
#define VECTORS_LOW                                     (0 << 13)
#define CACHE_INSTRUCTION_ENABLE                        (1 << 12)
#define CACHE_INSTRUCTION_DISABLE                       (0 << 12)
#define BRANCH_PREDICTION_ENABLE                        (1 << 11)
#define BRANCH_PREDICTION_DISABLE                       (0 << 11)
#define SWP_SWPB_ENABLE                                 (1 << 10)
#define SWP_SWPB_DISABLE                                (0 << 10)
#define BARRIERS_CP15_ENABLE                            (1 << 5)
#define BARRIERS_CP15_DISABLE                           (0 << 5)
#define CACHE_DATA_ENABLE                               (1 << 2)
#define CACHE_DATA_DISABLE                              (0 << 2)
#define ALIGNMENT_CHECK_ENABLE                          (1 << 1)
#define ALIGNMENT_CHECK_DISABLE                         (0 << 1)
#define MMU_ENABLE                                      (1 << 0)
#define MMU_DISABLE                                     (0 << 0)


void mmu_configure(void) {
	// set SMP bit in ACTLR. MUST be done before the MMU is enabled.
	uint32_t auxctrl;
	asm volatile ("mrc p15, 0, %0, c1, c0,  1" : "=r" (auxctrl));
	auxctrl |= 1 << SMP_ENABLE_COHERENT_REQUESTS;
	asm volatile ("mcr p15, 0, %0, c1, c0,  1" :: "r" (auxctrl));

    // set domain 0 to be domain manager
    uint32_t dacr = (DOMAIN_MANAGER << 0);
	asm volatile ("mcr     p15, 0, %0, c3, c0, 0" :: "r" (dacr));

	// configure TTBRC to always use TTBR0
	// the reset value is the correct one, but it can't hurt to be safe!
	asm volatile ("mcr p15, 0, %0, c2, c0, 2" :: "r" (0));
    
    // configure the TTBR0
	uint32_t ttb_descr =       (unsigned)&page_table
	                        |   TTB_SHAREABLE
	                        |   TTB_REGION_OUT_WRITEBACK_WRITE_ALLOC_CACHEABLE
	                        |   TTB_INNER_WRITETHROUGH_WRITE_ALLOC_CACHEABLE;
	
	asm volatile ("mcr p15, 0, %0, c2, c0, 0"
		      :: "r" (ttb_descr));
	barrier_instruction();

	//                 0b1100 0101 0000 1000 0111 1000
	
	// configure SCTLR, the system control register
	// enabling the caches and branch prediction will result in a significant
	// performance increase.
}


    // must be section aligned
void remap(uint32_t virtual, uint32_t physical){
    // TODO


}
