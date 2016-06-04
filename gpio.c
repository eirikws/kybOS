
#include <stdint.h>

#include "base.h"
#include "ipc.h"
#include "gpio.h"
#include "drivers.h"
#include "interrupts.h"
#include "scheduler.h"
#include "uart.h"
#include "time.h"

#define GPIO_BASE 	( PERIPHERAL_BASE + 0x00200000 )

static gpio_t* Gpio = (gpio_t*)GPIO_BASE;

gpio_t* get_gpio(void)
{
    return Gpio;
}

void gpio_init(void){
    irq_controller_get()->Enable_IRQs_2 |= GPIO_IRQ;
}

void gpio_jtag_enable(void){
    // set gpio4 to alt 5
    gpio_t *gpio = get_gpio();
    gpio->GPFSEL0 &= ~(7 << 12);    // zero out gpio4
    gpio->GPFSEL0 |= 2<< 12;    //gpio4 to alt5 = ARM_TDI
    
    // set other gpios
    gpio->GPFSEL2 &= ~(     
                        (7<<6)      //zero gpio22
                       |(7<<12)     // gpio24
                       |(7<<15)     // gpio25
                       |(7<<21));   // gpio27
    
    gpio->GPFSEL2 |=    (3 << 6)    // alt4 ARM TRST
                       |(3 << 12)   // alt4 ARM_TD0
                       |(3 << 15)   // alt4 ARM_TCK
                       |(3 << 21);   // alt4 ARM_TMS

    return;
}

void gpio_emmc_enable(void){
    gpio_t *gpio = get_gpio();
    // set as input
    gpio->GPFSEL4 &= ~(7 << 23);
    
}

void gpio_ack(void){
    get_gpio()->GPEDS0 = 0xffffffff;
    get_gpio()->GPEDS1 = 0xffffffff;
}

#define GPIO_IRQS       (0xf << 17)
scheduling_type_t gpio_handler(void){
    // send msg with interrupt regs
    uint32_t irpts[2];
    irpts[0] = get_gpio()->GPEDS0;
    irpts[1] = get_gpio()->GPEDS1;
    gpio_ack();
   // ipc_kernel_send(irpts, 8, driver_irq_get(DRIVER_GPIO));
    return RESCHEDULE;
}

void gpio_test(void){
    uart_puts("starting gpio test\r\n");
    //  enable LED pin as an output 
    get_gpio()->LED_GPFSEL |= LED_GPFBIT;
    /* Enable interrupts! */

    get_gpio()->GPFSEL2 |= (0b001 << 3); // pin 21 as output
    get_gpio()->GPFSEL2 |= (0b000 << 18); // pin 26 as input
    get_gpio()->LED_GPSET = ( 1 << LED_GPIO_BIT);   
    get_gpio()->GPSET0 = ( 1 << 21);      // output pin 21 = 1
    uart_puts("pin 21: ");
    uart_put_uint32_t( (get_gpio()->GPFSEL2 >> 3 ) & 7, 16);
    uart_puts("\r\npin 26: ");
    uart_put_uint32_t( (get_gpio()->GPFSEL2 >> 18 ) & 7, 16);
    // enable pull-down pin 26
    get_gpio()->GPPUD = 1;
    time_delay_microseconds(1);
    get_gpio()->GPPUDCLK0 = (1 << 26);
    time_delay_microseconds(1);
    get_gpio()->GPPUD = 0;
    get_gpio()->GPPUDCLK0 = 0;


    time_delay_microseconds(1000);
    uart_puts("n\r\n");
    while(1){
        uart_put_uint32_t(get_gpio()->GPLEV0 & (1 << 26), 16);
        uart_puts("\r\n");
        if( get_gpio()->GPLEV0 & (1 << 26) ){
            get_gpio()->LED_GPSET = ( 1 << LED_GPIO_BIT);
        }else{
            get_gpio()->LED_GPCLR = ( 1 << LED_GPIO_BIT);
        }
    }
}

