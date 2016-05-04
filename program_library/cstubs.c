/*
    Newlib stubs required to fail gracefully when a OS is not available.
    https://sourceware.org/newlib/libc.html#Stubs
*/

#include <stdint.h>
#include <errno.h>
#undef errno
extern int errno;

/* Required include for fstat() */
#include <sys/stat.h>

/* Required include for times() */
#include <sys/times.h>
#include "system_calls.h"

/* A pointer to a list of environment variables and their values. For a minimal
   environment, this empty list is adequate: */
char *__env[1] = {0};
char **environ = __env;

/* A helper function written in assembler to aid us in allocating memory */
extern caddr_t _get_stack_pointer(void);



void _exit( int status ){
    _SYSTEM_CALL(EXIT, (void*)status, NULL, NULL);
}


/* There's currently no implementation of a file system because there's no
   file system! */
int close( int file )
{
    return -1;
}


/* Transfer control to a new process. Minimal implementation (for a system
   without processes): */
int execve( char *name, char **argv, char **env )
{
    errno = ENOMEM;
    return -1;
}


/* Create a new process. Minimal implementation (for a system without
   processes): */
int fork( void )
{
    errno = EAGAIN;
    return -1;
}


/* Status of an open file. For consistency with other minimal implementations
   in these examples, all files are regarded as character special devices. The
   sys/stat.h header file required is distributed in the include subdirectory
   for this C library. */
int fstat( int file, struct stat *st )
{
    st->st_mode = S_IFCHR;
    return 0;
}


/* Process-ID; this is sometimes used to generate strings unlikely to conflict
   with other processes. Minimal implementation, for a system without
   processes: */
int getpid( void )
{
    return 1;
}


/* Query whether output stream is a terminal. For consistency with the other
   minimal implementations, which only support output to stdout, this minimal
   implementation is suggested: */
int isatty(int file)
{
    return 1;
}


/* Send a signal. Minimal implementation: */
int kill( int pid, int sig )
{
    errno = EINVAL;
    return -1;
}


/* Establish a new name for an existing file. Minimal implementation: */
int link( char *old, char *new )
{
    errno = EMLINK;
    return -1;
}


/* Set position in a file. Minimal implementation: */
int lseek(int file, int ptr, int dir)
{
    return 0;
}


/* Open a file. Minimal implementation: */
int open( const char *name, int flags, int mode )
{
    return -1;
}


/* Read from a file. Minimal implementation: */
int read( int file, char *ptr, int len )
{
    return 0;
}


/* Increase program data space. As malloc and related functions depend on this,
   it is useful to have a working implementation. The following suffices for a
   standalone system; it exploits the symbol _end automatically defined by the
   GNU linker. */
caddr_t _sbrk( int incr )
{
    extern char _end;
    static char* heap_end;
    char* prev_heap_end;
    if( heap_end == 0 )
        heap_end = &_end;

     prev_heap_end = heap_end;

     if( ( heap_end + incr ) > _get_stack_pointer() )
     {
        while( 1 ) { /* TRAP HERE! */ }
     }

     heap_end += incr;
     return (caddr_t)prev_heap_end;
}


/* Status of a file (by name). Minimal implementation: */
int stat( const char *file, struct stat *st )
{
    st->st_mode = S_IFCHR;
    return 0;
}


/* Timing information for current process. Minimal implementation: */
clock_t times( struct tms *buf )
{
    return -1;
}


/* Remove a file's directory entry. Minimal implementation: */
int unlink( char *name )
{
    errno = ENOENT;
    return -1;
}


/* Wait for a child process. Minimal implementation: */
int wait( int *status )
{
    errno = ECHILD;
    return -1;
}


void outbyte( char b )
{
    (void)b;
}

/* Write to a file. libc subroutines will use this system routine for output to
   all files, including stdout—so if you need to generate any output, for
   example to a serial port for debugging, you should make your minimal write
   capable of doing this. The following minimal implementation is an
   incomplete example; it relies on a outbyte subroutine (not shown; typically,
   you must write this in assembler from examples provided by your hardware
   manufacturer) to actually perform the output. */
int write( int file, char *ptr, int len )
{
    int todo;

    for( todo = 0; todo < len; todo++ )
        outbyte(*ptr++);

    return len;
}

/*
//    semaphore to protect the heap

static OS_EVENT *heapsem;
 
//    id of the task that is
//    currently manipulating the heap 

static int lockid;

//    number of times
//    __malloc_lock has recursed

static int locks;

void __malloc_lock ( struct _reent *_r ){
    OS_TCB tcb;
    OS_SEM_DATA semdata;
    INT8U err;
    int id;
    // use our priority as a task id 
    OSTaskQuery( OS_PRIO_SELF, &tcb );
    id = tcb.OSTCBPrio;
    // see if we own the heap already 
    OSSemQuery( heapsem, &semdata );
    if( semdata.OSEventGrp && id == lockid ) {
        // we do; just count the recursion 
        locks++;
    }
    else {
        // wait on the other task to yield the
        // heap, then claim ownership of it 
        OSSemPend( heapsem, 0, &err );
        lockid = id;
        }
    return;
}

void __malloc_unlock ( struct _reent *_r ){
    // release the heap once the number of
    //locks == the number of unlocks 
    if( (--locks) == 0 ) {
        lockid = -1;
        OSSemPost( heapsem );
    }
}
*/
