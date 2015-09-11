
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
    uart controller that is memory mapped
*/
typedef uart_controller{
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
} uart_controller_t

void uart_init( void );

uart_controller_t* GetUartController( void );

#endif
