#ifndef MMU_H
#define MMU_H


// paging bits
// page: SECTION bits
#define SECTION_BASE_ADDRESS_OFFSET     20
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


#define VIRT_MEM_SIZE       0x40000000
#define PHYS_MEM_SIZE       (1 << 30)       // 1 GB memory
#define MMU_PAGE_SIZE       (1 << 20)       // 1 MB

void mmu_init(void);
void mmu_configure(void);
void mmu_init_table(void);
void mmu_remap_section(uint32_t virt,uint32_t physical, uint32_t config_flags);
void mmu_cache_invalidate(uint32_t address);
uint32_t mmu_get_mapping(uint32_t virtual);
void mmu_table_update(void);
#endif
