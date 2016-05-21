
cmake_minimum_required( VERSION 2.8 )

project( kybOS C ASM)

#   Add any C compiler flags here. The C flags concerned with processor tuning
#   are in the toolchain files toolchain-arm-none-eabi-bcm2835.cmake, etc.
set( CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -O1" )
set( CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -nostartfiles" )
set( CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -Wall" )
#set( CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -nostdlib" )
set( CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -ffreestanding" )

#include_directories(${../program_library/})

#   Set the linker flags so that we use our "custom" linker script
set( CMAKE_EXE_LINKER_FLAGS "-Wl,-T,${PROJECT_SOURCE_DIR}/../program_library/linker.ld" )

add_executable( prog1.elf
    main.c
    ../program_library/start.S
    ../program_library/cstartup.c
    ../program_library/ipc.c
    ../program_library/ipc.h
    ../program_library/memory.c
    ../program_library/memory.h
    ../program_library/drivers.c
    ../program_library/drivers.h
    ../program_library/process.c
    ../program_library/process.h
   )
