#include <stdlib.h>
#include "../program_library/system_calls.h"
#include "../program_library/ipc.h"

int main(void){
    //int flags;
    _SYSTEM_CALL(4, (void*)"Program 3 doing nothing................................\r\n", NULL, NULL);
    while(1){

    }
    return 0;
}

