#include <stdlib.h>
#include <stdint.h>
#include "mmu.h"

#define PHYSICAL_MEMORY             0x4000000
#define NUM_PAGE_TABLE_ENTRIES      1024
#define CACHE_DISABLED              0x12
#define SDRAM_START                 0x80000000
#define SDRAM_END                   
#define CACHE_WRITEBACK 


static uint32_t *page_table;


extern _mmu_start(void);

int mmu_init(void){
    int ra;
    page_table = (uint32_t *const) 0x14000;
    int i;
    uint32_t reg;
    
    for (i = 0; i < NUM_PAGE_TABLE_ENTRIES; i++){
        if i
}

/*  
    sets the base of the translation table
*/
extern _set_tt_base(uint32_t *base);
int set_tt_base(uint32_t *base){
    _set_tt_base(base);
    return 1;
}

