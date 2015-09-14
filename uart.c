#include <string.h>
#include <stdint.h>
#include "base.h"
#include "gpio.h"
#include "uart.h"


#define UART_CONTROLLER_BASE    ( PERIPHERAL_BASE + 0x201000 )

static uart_controller_t* UARTController =
		(uart_controller_t*)UART_CONTROLLER_BASE;

/* Loop <delay> times in a way that the compiler won't optimize away. */
static void delay(int32_t count){
	asm volatile("__delay_%=: subs %[count], %[count], #1; bne __delay_%=\n"
		 : : [count]"r"(count) : "cc");
}

/*
    from the datasheet:
    To enable transmission, the TXE bit and UARTEN bit must be set to 1.
    Similarly, to enable reception, the RXE bit and UARTEN bit, must be set to 1.
    NOTE:
    Program the control registers as follows:
    1. Disable the UART.w
    2. Wait for the end of transmission or reception of the current character.
    3. Flush the transmit FIFO by setting the FEN bit to 0 in the Line Control
    Register, UART_LCRH.
    4. Reprogram the Control Register, UART_CR.
    5. Enable the UART.
*/
void uart_init( void ){
	//	turn everything off for starters
	GetUartController()->CR = 0x00000000;
	//	Control signal to disable pull up/down and delay for 150 clock cycles
    GetGpio()->GPPUD = PULL_UPDOWN_DISABLE;
    delay(150);
	//	disable pull up/down for uart pins and delay
	GetGpio()->GPPUDCLK0 = UART_PINS;
    delay(150);
    //  remove control signal and clocking
    GetGpio()->GPPUD = 0;
    GetGpio()->GPPUDCLK0 = 0;
    //  clear impending intrrupts
    GetUartController()->ICR = 0x7ff;
    //  set the baud rate:
    //  divider = uart_clock/(16 * baud)
    //  fraction = ( fraction_part * 64 ) + 0.5
    //  UART_CLOCK = 3000000, baud = 115200
    //
    //  Divider = 3000000 / (16 * 115200) = 1.627 ~ 1
    //  fraction = (0.627 * 64) + 0.5 = 40.6 ~ 40
    GetUartController()->IBRD = 1;
    GetUartController()->FBRD = 40;
    // cofigure UART:
    GetUartController()->LCRH =    WORD_LEN_8BIT | FIFO_ENABLE;
    // mask interrupts
    GetUartController()->IMSC =  (1 << 1) | (1 << 4) | (1 << 5) | (1 << 6) |
                                 (1 << 7) | (1 << 8) | (1 << 9) | (1 << 10);
    //  restart uart again
    GetUartController()->CR = UART_ENABLE | TRANSMIT_ENABLE | RECEIVE_ENABLE;
}

uart_controller_t* GetUartController( void ){
    return UARTController;
}

void uart_putc(unsigned char byte){
    while( GetUartController()->FR & TRANSMIT_FIFO_FULL ){}
    GetUartController()->DR = byte;
    return;
}

unsigned char uart_getc(){
    while ( GetUartController()->FR & RECEIVE_FIFO_EMPTY){ }
    return GetUartController()->DR;
}


void uart_write(const unsigned char* buffer, size_t size){
    size_t i;
    for( i = 0; i < size; i++){
        uart_putc(buffer[i]);
    }
    return;
}

void uart_puts(const char* str){
    uart_write((const unsigned char*)str, strlen(str));
    return;
}


