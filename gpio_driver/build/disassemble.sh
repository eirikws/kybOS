#!/bin/sh

arm-none-eabi-objdump -D ./gpio.elf > ./gpio.asm
arm-none-eabi-nm ./gpio.elf > ./gpio.nm
