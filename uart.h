
#ifndef UART_H
#define UART_H

# include <stdint.h>

/*
    important control register bits
*/
#define REQUEST_TO_SEND         ( 1 << 11)
#define REQUEST_TO_SEND_RESET   ( 0 << 11)
#define RECEIVE_ENABLE          ( 1 << 9 )
#define RECEIVE_DISABLE         ( 0 << 9 )
#define TRANSMIT_ENABLE         ( 1 << 8 )
#define TRANSMIT_DISABLE        ( 0 << 8 )
#define LOOPBACK_ENABLE         ( 1 << 7 )
#define LOOPBACK_DISABLE        ( 0 << 7 )
#define UART_ENABLE             ( 1 << 0 )
#define UART_DISABLE            ( 0 << 0 )

/*
    pull up/down control
*/
#define PULL_UPDOWN_DISABLE        (0 << 1 ) | (0 << 0 )
#define PULL_UP_CONTROL_ENABLE      (0 << 1 ) | (1 << 0 )
#define PULL_DOWN_CONTROL_ENABLE    (1 << 1 ) | (0 << 0 )
#define UART_PINS                   (1 << 14) | (1 << 15)

/*
    clear interrups bits
*/
#define UART_CLEAR_ALL_INTERRUPTS        0x3ff

/*
    UART configuration
*/
#define WORD_LEN_8BIT           ( 1 << 6 ) | (1 << 5)
#define STICK_PARITY_ENABLE     ( 1 << 7 )
#define STICK_PARITY_DISABLE    ( 0 << 7 )
#define FIFO_ENABLE             ( 1 << 4 )
#define FIFO_DISABLE            ( 0 << 4 )
#define TWO_STOP_BITS_ENABLE    ( 1 << 3 )
#define TWO_STOP_BITS_DISABLE   ( 0 << 3 )
#define PARITY_ODD              ( 0 << 2 )
#define PARITY_EVEN             ( 1 << 2 )
#define PARITY_ENABLE           ( 1 << 1 )
#define PARITY_DISABLE          ( 0 << 1 )
#define BREAK_ENABLE            ( 1 << 0 )
#define BREAK_DISABLE           ( 0 << 0 )

/*
    Flag register
*/
#define TRANSMIT_FIFO_EMPTY     ( 1 << 7 )
#define RECEIVE_FIFO_FULL       ( 1 << 6 )
#define TRANSMIT_FIFO_FULL      ( 1 << 5 )
#define RECEIVE_FIFO_EMPTY      ( 1 << 4 )
#define UART_BUSY               ( 1 << 3 )
#define CLEAR_TO_SEND           ( 1 << 0 )


/*
    uart controller that is memory mapped
*/
typedef struct uart_controller{
    // the data register
    volatile uint32_t DR;
    // receive status/error clear register
    volatile uint32_t errors;
    // padding to align memory
    volatile uint32_t padding0;
    volatile uint32_t padding1;
    volatile uint16_t padding2;
    // flag register
    volatile uint32_t FR;
    // padding again...
    volatile uint16_t padding3;
    // integer baud rate divisor
    volatile uint32_t IBRD;
    // Fractional baud rate divisor
    volatile uint32_t FBRD;
    // line control register
    volatile uint32_t LCRH;
    // control register
    volatile uint32_t CR;
    // interrupt FIFO level select register
    volatile uint32_t IFLS;
    // interrupt mask set clear register
    volatile uint32_t IMSC;
    // raw interrupt status register
    volatile uint32_t RIS;
    // masked interrupt status register
    volatile uint32_t MIS;
    // interrupt clear register
    volatile uint32_t ICR;
    // DMA control register
    volatile uint32_t DMACR;
    // MOAR padding!
    volatile uint32_t padding4[14];
    // test control register
    volatile uint32_t ITCR;
    // integration test input reg
    volatile uint32_t ITIP;
    // integration test output reg
    volatile uint32_t ITOP;
    // test data reg
    volatile uint32_t TDR;
} uart_controller_t;

void uart_init( void );
void uart_puts(const char* str);
unsigned char uart_getc(void);
void uart_putc(unsigned char byte);
uart_controller_t* GetUartController( void );

#endif
