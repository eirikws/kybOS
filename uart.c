

#include <stdint.h>
#include "base.h"
#include "gpio.h"
#include "uart.h"


#define UART_CONTROLLER_BASE    ( PERIPHERAL_BASE + 0x 20100 )

static uart_controller_t* UARTController =
        (uart_controller_t*)UART_CONTROLLER_BASE;


void uart_init( void ){
    GetUartController()->CR = 0x0000;
    
    
}






uart_controller_t* GetUartController( void );
    return UARTcontroller;
}
