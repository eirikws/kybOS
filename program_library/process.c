#include <stdlib.h>
#include "system_calls.h"
#include "process.h"


void process_spawn(spawn_args_t *args){
    _SYSTEM_CALL(SPAWN, args, NULL, NULL);
}




