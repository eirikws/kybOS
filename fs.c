#include "fs.h"
#include "emmc.h"
#include "fat.h"


static struct fs *osfs = NULL;

struct fs *fs_get(void){
    return osfs;
}

void fs_init(void){
    //initializing emmc sd card driver
    emmc_init();

    // init the fat
    fat_init( &osfs);
}




