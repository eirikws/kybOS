#include <stdlib.h>
#include "system_calls.h"


void* mmap(void* address){
    void* retval = NULL;
    _SYSTEM_CALL(MMAP, (void*)&retval, address, NULL);
    return retval;
}

