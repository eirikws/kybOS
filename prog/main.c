#include <stdlib.h>
extern void _SYSTEM_CALL(int , char* );

char* heystr = "awdawdawdawdawd\r\n";
char* awd   = "mmammammwdmawm\r\n";
char* ffw   = "ashahaiuheflaiusehlasiuehfliasuhfla\r\n";


int main(void){
    while(1){
        _SYSTEM_CALL(4, awd);
        _SYSTEM_CALL(2, NULL);

    }
    return 0;
}

