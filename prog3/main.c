#include <stdlib.h>
#include "../program_library/system_calls.h"
#include "../program_library/ipc.h"

int main(void){
    //int flags;
    while(1){
        _SYSTEM_CALL(4, (void*)"Program 3 doing nothing................................\r\n", NULL, NULL);
        _SYSTEM_CALL(YIELD, NULL, NULL, NULL);
    }
    return 0;
}

