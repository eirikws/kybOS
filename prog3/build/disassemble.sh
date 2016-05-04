#!/bin/sh

arm-none-eabi-objdump -D ./prog3.elf > ./prog3.asm
arm-none-eabi-nm ./prog3.elf > ./prog3.nm
