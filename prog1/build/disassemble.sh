#!/bin/sh

arm-none-eabi-objdump -D ./prog1.elf > ./prog1.asm
arm-none-eabi-nm ./prog1.elf > ./prog1.nm
