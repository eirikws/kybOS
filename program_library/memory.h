#ifndef MEMORY_H
#define MEMORY_H

/*
 * Maps address to virtual address space
 * and returns a pointer to it. 
 * The mapped region will not be cached!
 * Writing to somewhere except the location returned
 * is not safe bacause of page table boundries. 
 * ...it is mostly ok though, unless your're unlucky!
 */
void* mmap(void* address);

#endif
