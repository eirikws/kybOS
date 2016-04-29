#!/bin/sh

arm-none-eabi-objdump -D ./prog.elf > ./prog.asm
arm-none-eabi-nm ./prog.elf > ./prog.nm
