
#include "system_calls.h"
#include "stdlib.h"
#include "drivers.h"


int driver_register(char *name){
    int errors;
    _SYSTEM_CALL(DRIVER_REGISTER, (void*)name, (void*)&errors, NULL);
    return errors;
}

