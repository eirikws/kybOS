
#ifndef GPIO_H
#define GPIO_H

#include "base.h"

#define LED_GPFSEL      GPFSEL4
#define LED_GPFBIT      21
#define LED_GPSET       GPSET1
#define LED_GPCLR       GPCLR1
#define LED_GPIO_BIT    15

/***/
#define GPIO_FSEL0_00_INPUT     ( 0 )
#define GPIO_FSEL0_00_OUTPUT    ( 1 )

#define GPIO_FSEL0_01_INPUT     ( 0 << 3 )
#define GPIO_FSEL0_01_OUTPUT    ( 1 << 3 )

#define GPIO_FSEL0_02_INPUT     ( 0 << 6 )
#define GPIO_FSEL0_02_OUTPUT    ( 1 << 6 )

#define GPIO_FSEL0_03_INPUT     ( 0 << 9 )
#define GPIO_FSEL0_03_OUTPUT    ( 1 << 9 )

#define GPIO_FSEL0_04_INPUT     ( 0 << 12 )
#define GPIO_FSEL0_04_OUTPUT    ( 1 << 12 )

#define GPIO_FSEL0_05_INPUT     ( 0 << 15 )
#define GPIO_FSEL0_05_OUTPUT    ( 1 << 15 )

#define GPIO_FSEL0_06_INPUT     ( 0 << 18 )
#define GPIO_FSEL0_06_OUTPUT    ( 1 << 18 )

#define GPIO_FSEL0_07_INPUT     ( 0 << 21 )
#define GPIO_FSEL0_07_OUTPUT    ( 1 << 21 )

#define GPIO_FSEL0_08_INPUT     ( 0 << 24 )
#define GPIO_FSEL0_08_OUTPUT    ( 1 << 24 )

#define GPIO_FSEL0_09_INPUT     ( 0 << 27 )
#define GPIO_FSEL0_09_OUTPUT    ( 1 << 27 )


typedef struct {
    volatile uint32_t           GPFSEL0;
    volatile uint32_t           GPFSEL1;
    volatile uint32_t           GPFSEL2;
    volatile uint32_t           GPFSEL3;
    volatile uint32_t           GPFSEL4;
    volatile uint32_t           GPFSEL5;
    volatile const uint32_t     Reserved0;
    volatile uint32_t           GPSET0;
    volatile uint32_t           GPSET1;
    volatile const uint32_t     Reserved1;
    volatile uint32_t           GPCLR0;
    volatile uint32_t           GPCLR1;
    volatile const uint32_t     Reserved2;
    volatile uint32_t           GPLEV0;
    volatile uint32_t           GPLEV1;
    volatile const uint32_t     Reserved3;
    volatile uint32_t           GPEDS0;
    volatile uint32_t           GPEDS1;
    volatile const uint32_t     Reserved4;
    volatile uint32_t           GPREN0;
    volatile uint32_t           GPREN1;
    volatile const uint32_t     Reserved5;
    volatile uint32_t           GPFEN0;
    volatile uint32_t           GPFEN1;
    volatile const uint32_t     Reserved6;
    volatile uint32_t           GPHEN0;
    volatile uint32_t           GPHEN1;
    volatile const uint32_t     Reserved7;
    volatile uint32_t           GPLEN0;
    volatile uint32_t           GPLEN1;
    volatile const uint32_t     Reserved8;
    volatile uint32_t           GPAREN0;
    volatile uint32_t           GPAREN1;
    volatile const uint32_t     Reserved9;
    volatile uint32_t           GPAFEN0;
    volatile uint32_t           GPAFEN1;
    volatile const uint32_t     Reserved10;
    volatile uint32_t           GPPUD;
    volatile uint32_t           GPPUDCLK0;
    volatile uint32_t           GPPUDCLK1;
    volatile const uint32_t     Reserved11;
} gpio_t;


gpio_t* get_gpio(void);
void gpio_init(void);
void gpio_jtag_enable(void);

#endif
