#include <stdlib.h>
#include "../program_library/system_calls.h"
#include "../program_library/ipc.h"
#include "../program_library/process.h"
#include "../program_library/memory.h"

#define GPIO_BASE       0x3f200000

#define GPFSEL0         (uint32_t*)(GPIO_BASE + 0x0)
#define GPFSEL1         (uint32_t*)(GPIO_BASE + 0x4)
#define GPFSEL2         (uint32_t*)(GPIO_BASE + 0x8)
#define GPFSEL3         (uint32_t*)(GPIO_BASE + 0xC)
#define GPFSEL4         (uint32_t*)(GPIO_BASE + 0x10)
#define GPFSEL5         (uint32_t*)(GPIO_BASE + 0x14)

#define GPSET0          (uint32_t*)(GPIO_BASE + 0x1c)
#define GPSET1          (uint32_t*)(GPIO_BASE + 0x20)

#define GPCLR0          (uint32_t*)(GPIO_BASE + 0x28)
#define GPCLR1          (uint32_t*)(GPIO_BASE + 0x2c)

#define GPLEV0          (uint32_t*)(GPIO_BASE + 0x34)
#define GPLEV1          (uint32_t*)(GPIO_BASE + 0x38)

#define GPEDS0          (uint32_t*)(GPIO_BASE + 0x40)
#define GPEDS1          (uint32_t*)(GPIO_BASE + 0x44)

#define GPREN0          (uint32_t*)(GPIO_BASE + 0x4c)
#define GPREN1          (uint32_t*)(GPIO_BASE + 0x50)

#define GPFEN0          (uint32_t*)(GPIO_BASE + 0x58)
#define GPFEN1          (uint32_t*)(GPIO_BASE + 0x5c)

#define GPHEN0          (uint32_t*)(GPIO_BASE + 0x64)
#define GPHEN1          (uint32_t*)(GPIO_BASE + 0x68)

#define GPLEN0          (uint32_t*)(GPIO_BASE + 0x70)
#define GPLEN1          (uint32_t*)(GPIO_BASE + 0x74)

#define GPAREN0         (uint32_t*)(GPIO_BASE + 0x7c)
#define GPAREN1         (uint32_t*)(GPIO_BASE + 0x80)

#define GPAFEN0         (uint32_t*)(GPIO_BASE + 0x88)
#define GPAFEN1         (uint32_t*)(GPIO_BASE + 0x8c)

#define GPPUD           (uint32_t*)(GPIO_BASE + 0x94)
#define GPPUDCLK0       (uint32_t*)(GPIO_BASE + 0x98)
#define GPPUDCLK1       (uint32_t*)(GPIO_BASE + 0x9c)

void delay(int32_t count);

int main(void){
    int flags = 0;
    process_id_t sender;
    _SYSTEM_CALL(4, (void*)"gpio driver_register\r\n", NULL, NULL);
    driver_register("gpio");
    _SYSTEM_CALL(4, (void*)"gpio calling mmap\r\n", NULL, NULL);
    volatile uint32_t *gpfsel4 = mmap(GPFSEL4);
    volatile uint32_t *gpfsel2 = mmap(GPFSEL2);
    volatile uint32_t *gpfsel1 = mmap(GPFSEL1);
    volatile uint32_t *gpfsel0 = mmap(GPFSEL0);
    volatile uint32_t *gpset1  = mmap(GPSET1);
    volatile uint32_t *gpset0  = mmap(GPSET0);
    volatile uint32_t *gppud   = mmap(GPPUD);
    volatile uint32_t *gppudclk0 = mmap(GPPUDCLK0);
    volatile uint32_t *gplev0  = mmap(GPLEV0);
    volatile uint32_t *gplev1  = mmap(GPLEV1);
    volatile uint32_t *gpclr0  = mmap(GPCLR0);
    volatile uint32_t *gpclr1  = mmap(GPCLR1);
    volatile uint32_t *gpren0  = mmap(GPREN0);
    volatile uint32_t *gpfen0  = mmap(GPFEN0);
    _SYSTEM_CALL(4, (void*)"gpio remap done\r\n", NULL, NULL);
    //  enable LED pin as an output 
    *gpfsel4 |= 21;
    _SYSTEM_CALL(4, (void*)"gpio did a write\r\n", NULL, NULL);
    *gpfsel2 |= (0b001 << 3); // pin 21 as output
    
    // input
    *gpfsel2 &= ~(7 << 18); //  pin 26
    *gpfsel1 &= ~(7 << 29); //      19
    *gpfsel2 &= ~(7 << 9);  //      13
    *gpfsel0 &= ~(7 << 18); //      6

    // enable pull-down on input pins
    *gppud = 1;
    delay(300);
    *gppudclk0 = (1 << 26);
    *gppudclk0 = (1 << 19);
    *gppudclk0 = (1 << 13);
    *gppudclk0 = (1 << 6);
    delay(300);
    *gppud = 0;
    *gppudclk0 = 0;
    // enable rising edge interrupts
    *gpren0 |= (1 << 26);

    *gpren0 |= (1 << 19);

    *gpren0 |= (1 << 13);

    *gpren0 |= (1 << 6);

    // output

    // zero pin 
    *gpfsel2 &= ~(7 << 3);  //  pin 21
    *gpfsel2 &= ~(7 << 0);  //      20
    *gpfsel1 &= ~(7 << 18); //      16
    *gpfsel1 &= ~(7 << 6);  //      12
    // write as output
    *gpfsel2 |= (1 << 3);   //  pin 21
    *gpfsel2 |= (1 << 0);   //      20
    *gpfsel1 |= (1 << 18);  //      16
    *gpfsel1 |= (1 << 6);   //      12
    
    // set output level
    *gpclr0 = ( 1 << 21);   // pin  21
    *gpclr0 = ( 1 << 20);   // pin  20
    *gpclr0 = ( 1 << 16);   // pin  16
    *gpclr0 = ( 1 << 12);   // pin  12
    
    
    // buf to receive interupts
    uint32_t recv_buf[2];
    _SYSTEM_CALL(4, (void*)"gpio init done, calling recv\r\n", NULL, NULL);

    while(1){
        sender = ipc_receive(recv_buf, 8, &flags);
 /*       
        _SYSTEM_CALL(4, (void*)"value: ", NULL, NULL);
        _SYSTEM_CALL(5, (void*)*gplev0, NULL, NULL);
        
        _SYSTEM_CALL(4, (void*)"\r\n", NULL, NULL);
  */    //  _SYSTEM_CALL(4, (void*)"recv\r\n", NULL, NULL);
        if(flags & BUF_TOO_SMALL){
            _SYSTEM_CALL(4, (void*)"GPIO: buf too small\r\n", NULL, NULL);
        }
        if( *gplev0 & (1 << 26)){
            *gpset0 = ( 1 << 21);   // pin  21
            *gpclr0 = ( 1 << 21);   // pin  21
        }
        if( *gplev0 & (1 << 19)){
            *gpset0 = ( 1 << 20);   // pin  21
            *gpclr0 = ( 1 << 20);   // pin  21
        }
        if( *gplev0 & (1 << 13)){
            *gpset0 = ( 1 << 16);   // pin  21
            *gpclr0 = ( 1 << 16);   // pin  21
        }
        if( *gplev0 & (1 << 6)){
            *gpset0 = ( 1 << 12);   // pin  21
            *gpclr0 = ( 1 << 12);   // pin  21
        }

/*
        if( *gplev0 & ( (1 << 26) | (1 << 19) | (1 << 13) || (1 << 6)) ){
            *gpset1 = ( 1 << 15);
        }else{
            *gpclr1 = ( 1 << 15);
        }
  */      recv_buf[0] = 0;
        recv_buf[1] = 0;
    }
}

void delay(int32_t count){
    __asm volatile("__delay_%=: subs %[count], %[count], #1; bne __delay_%=\n" :: [count]"r"(count) : "cc");
}


