#include <string.h>
#include <stdlib.h>
#include <stdint.h>
#include "base.h"
#include "gpio.h"
#include "uart.h"
#include "interrupts.h"


#define UART_CONTROLLER_BASE    ( PERIPHERAL_BASE + 0x201000 )

static uart_controller_t* UARTController =
		(uart_controller_t*)UART_CONTROLLER_BASE;

/* Loop <delay> times in a way that the compiler won't optimize away. */
void delay(int32_t count){
	__asm volatile("__delay_%=: subs %[count], %[count], #1; bne __delay_%=\n"
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
	uart_get()->CR = 0x00000000;
	//	Control signal to disable pull up/down and delay for 150 clock cycles
    get_gpio()->GPPUD = PULL_UPDOWN_DISABLE;
    delay(150);
	//	disable pull up/down for uart pins and delay
	get_gpio()->GPPUDCLK0 = UART_PINS;
    delay(150);
    //  remove control signal and clocking
    get_gpio()->GPPUD = 0;
    get_gpio()->GPPUDCLK0 = 0;
    //  clear impending interrupts
    uart_get()->ICR = 0x7ff;
    //  set the baud rate:
    //  divider = uart_clock/(16 * baud)
    //  fraction = ( fraction_part * 64 ) + 0.5
    //  UART_CLOCK = 3000000, baud = 115200
    //
    //  Divider = 3000000 / (16 * 115200) = 1.627 ~ 1
    //  fraction = (0.627 * 64) + 0.5 = 40.6 ~ 40
    uart_get()->IBRD = 1;
    uart_get()->FBRD = 40;
    // cofigure UART:
    uart_get()->LCRH =    WORD_LEN_8BIT | FIFO_DISABLE;

    //  set receive interrupt fifo level to 1/8 FIFO level
    uart_get()->IFLS |= RECEIVE_IRQ_FIFO_18;

    
    //  mask interrupts
    uart_get()->IMSC   |= RECEIVE_MASK_BIT;

    //  restart uart again
    irq_controller_get()->Enable_IRQs_2 |= UART_IRQ;
    uart_get()->CR = UART_ENABLE | TRANSMIT_ENABLE | RECEIVE_ENABLE;
}

uart_controller_t* uart_get( void ){
    return UARTController;
}

void uart_putc(unsigned char byte){
    while( uart_get()->FR & TRANSMIT_FIFO_FULL ){}
    uart_get()->DR = byte;
    return;
}

unsigned char uart_getc(){
    while ( uart_get()->FR & RECEIVE_FIFO_EMPTY){ }
    return uart_get()->DR;
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

char* uart_itoa(int value, char* result, int base){
    // check that the base if valid 
    if ( base < 2 || base > 36 ) {
        *result = '\0';
	    return result;
    }
    
    char* ptr = result, *ptr1 = result, tmp_char;
    int tmp_value;
 
    do {
	    tmp_value = value;
	    value /= base;
	    *ptr++ = "zyxwvutsrqponmlkjihgfedcba9876543210123456789abcdefghijklmnopqrstuvwxyz"[35 + (tmp_value - value * base)];
    } while ( value );
 
    // Apply negative sign
    if ( tmp_value < 0 ){
	    *ptr++ = '-';
    }
    *ptr-- = '\0';
 
    while ( ptr1 < ptr ) {
	tmp_char = *ptr;
	*ptr-- = *ptr1;
	*ptr1++ = tmp_char;
    }
 
    return result;
}

void uart_put_uint32_t(uint32_t in, int base){
    char c[35];
    if (base == 16){    uart_puts("0x");}
    else if (base == 2){    uart_puts("0b");}
    uart_puts(uart_itoa(in,c,base));
}

uint32_t uart_handler(void){
    static int lit = 0;
    uart_puts("uart handler!\r\n");
    if( lit ){
        get_gpio()->LED_GPSET = (1 << LED_GPIO_BIT);
        lit = 0;
    } else {
        get_gpio()->LED_GPCLR = (1 << LED_GPIO_BIT);
        lit = 1;
    }
    return 0;
}

