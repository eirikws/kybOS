#!/bin/sh

arm-none-eabi-objdump -D ./kybOS > ./kybOS.asm
arm-none-eabi-nm ./kybOS > ./kybOS.nm
