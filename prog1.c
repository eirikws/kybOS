
#include "prog1.h"

extern void prog1_init(void) __attribute__((section("prog1")));

void  prog1_init(void){
    int x=0;
    while(1){
        // do something
        x++;
    }
}
