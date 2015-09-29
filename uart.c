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
    //  clear impending interrupts
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
    GetUartController()->LCRH =    WORD_LEN_8BIT | FIFO_DISABLE;

    //  set receive interrupt fifo level to 1/8 FIFO level
    GetUartController()->IFLS |= RECEIVE_IRQ_FIFO_18;
    
    //  mask interrupts
    GetUartController()->IMSC   |= RECEIVE_MASK_BIT;

    //  restart uart again
    GetIrqController()->Enable_IRQs_2 |= UART_IRQ;
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

void reverse(char str[], int length){
    int start = 0;
    int end = length -1;
    char temp;
    char temp2;
    while (start < end){
        //swap(*(str+start), *(str+end));
        *(str+start) =  *(str+start) ^ *(str+end);
        *(str+end) =  *(str+start) ^ *(str+end);
        *(str+start) =  *(str+end) ^ *(str+start);
        start++;
        end--;
    }
}


char* uart_itoa(int num, char* str, int base){
    int i = 0;
    if (num == 0){
        str[i++] = '0';
        str[i] = '\0';
        return str;
    }
    // Process individual digits
    while (num != 0){
        int rem = num % base;
        str[i++] = (rem > 9)? (rem-10) + 'a' : rem + '0';
        num = num/base;
    }
    str[i] = '\0'; // Append string terminator
    // Reverse the string
    reverse(str, i);
    return str;
}

void uart_put_uint32_t(uint32_t in, int base){
    char c[5];
    if (base == 16){    uart_puts("0x");}
    else if (base == 2){    uart_puts("0b");}
    uart_puts(uart_itoa(in,c,base));
}

void print_alot(void){
    int i;
    for (i=0; i<20; i++){
        uart_puts("AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\r\n");
    }
}

