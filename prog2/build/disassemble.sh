#!/bin/sh

arm-none-eabi-objdump -D ./prog2.elf > ./prog2.asm
arm-none-eabi-nm ./prog2.elf > ./prog2.nm
