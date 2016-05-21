#include <stdlib.h>
#include "system_calls.h"
#include "process.h"


void process_spawn(spawn_args_t *args){
    _SYSTEM_CALL(SPAWN, args, NULL, NULL);
}

void _exit(int status){
    _SYSTEM_CALL(EXIT, (void*)status, NULL, NULL);
}


