
extern int __bss_start__;
extern int __bss_end__;

extern void kernel_main( unsigned int r0, unsigned int r1, unsigned int atags );

void _cstartup( unsigned int r0, unsigned int r1, unsigned int r2 )
{
    int* bss = &__bss_start__;
    int* bss_end = &__bss_end__;
    //   Initialize the _bss section to zero
    while( bss < bss_end )
        *bss++ = 0;

    /* We never return from main */
    kernel_main( r0, r1, r2 );

    //  Trap
    while(1)
    {
        /* EMPTY! */
    }
}
