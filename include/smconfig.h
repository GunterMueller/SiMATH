/* smconfig.h.  Generated automatically by configure.  */
/***
SIMATH-Version
4.6
***/

 /*
  * SM_HOME is the path of the directory where SIMATH will be (or is)
  * installed. Upon installation SM_HOME should be set automatically by the
  * configure script.
  */

#define SM_HOME "/usr/local/simath"

 /*
  * MAX_BLOCK_NUMBER determines the maximal number of "blocks" that can be
  * allocated by a SIMATH process. One block equals 128 KB and we have set
  * the default for MAX_BLOCK_NUMBER to 64, i.e. about 8 MB. We suggest that
  * you allow SIMATH processes to allocate about half of the main memory of
  * your machine. (Note that on startup, a SIMATH process will allocate only
  * one block, i.e. 128 KB.) If you do not want to limit the size of a SIMATH
  * process, set MAX_BLOCK_NUMBER to 4096 (say). You can override
  * MAX_BLOCK_NUMBER at run time using the SIMATH function gcreinit().
  */

#define MAX_BLOCK_NUMBER 64

 /*
  * The rest of this file is generated automatically. You probably will not 
  * have to change anything below this line.
  */

 /*
  * We define the symbol ___APOLLO here. This is required by some programs
  * because Apollo workstations sometimes do not behave like other
  * workstations. This should be obsolete by now since Apollo systems
  * are no longer supported.
  */

#ifdef apollo
#define ___APOLLO
#endif

 /*
  * We define the symbol ___HP here because on HP workstations, the macros
  * ltop() and ptol() are implemented in a slightly different way.
  */

#ifdef hppa
#define ___HP
#endif

 /*
  * The following is used somewhere in the simcalc sources.
  */

#if (MAX_BLOCK_NUMBER < 64)
#define ___SMALL_SYSTEM
#else
#if (MAX_BLOCK_NUMBER < 512)
#define ___MEDIUM_SYSTEM
#else
#define ___LARGE_SYSTEM
#endif
#endif

 /*
  * This symbol is set automatically if simcalc uses readline. This should
  * be obsolete by now since readline will be used on every platform.
  */

#define USE_READLINE 1

 /*
  * These symbols define whether certain header files exist. They are set 
  * automatically by the configure script. Do not edit.
  */

#define HAVE_FCNTL_H 1
#define HAVE_MALLOC_H 1
#define HAVE_SGTTY_H 1
#define HAVE_SYS_FILE_H 1
#define HAVE_UNISTD_H 1
/* #undef HAVE_VARARGS_H */

#define HAVE_SYS_TIME_H 1
#define HAVE_TIME_H 1
#define TIME_WITH_SYS_TIME 1
/* #undef TM_IN_SYS_TIME */

/*
 * One of four *dir*.h is selected automatically.
 * It is used in readline.
 */

#define HAVE_DIRENT_H 1
/* #undef HAVE_SYS_NDIR_H */
/* #undef HAVE_SYS_DIR_H */
/* #undef HAVE_NDIR_H */

/* other headers tested */

#define HAVE_TERMIO_H 1
#define HAVE_STRINGS_H 1
#define HAVE_SYS_IOCTL_H 1
#define HAVE_SYS_WAIT_H 1

#define STDC_HEADERS 1

 /*
  * These symbols define if the C functions log2() and random() exist. They
  * are set automatically by the configure script. Do not edit.
  */

#define HAVE_LOG2 1
#define HAVE_RANDOM 1

 /*
  * These symbols define if the signals SIGEMT and SIGSYS are available on
  * the current host. They are set automatically by the configure script. Do
  * not edit.
  */

/* #undef HAVE_SIGEMT */
#define HAVE_SIGSYS 1

 /*
  * These symbols define if the functions random(), srandom() initstate() and
  * setstate() are declared in <math.h>. They are set automatically by the
  * configure script. Do not edit.
  */

#define RANDOM_IN_MATH_H 1
#define SRANDOM_IN_MATH_H 1
/* #undef INITSTATE_IN_MATH_H */
/* #undef SETSTATE_IN_MATH_H */

 /*
  * On systems without random(), we use rand() instead of random().
  */

#ifndef HAVE_RANDOM
#define random() rand()
#define srandom(seed) srand(seed)
#endif

 /*
  *    If `signal.h' declares `signal' as returning a pointer to a
  *    function returning `void', define `RETSIGTYPE' to be `void';
  *    otherwise, define it to be `int'.
  */

#define RETSIGTYPE void

 /*
  * Memory architecture should be checked.
  */

#define SIZEOF_CHAR 1
#define SIZEOF_SHORT 2
#define SIZEOF_INT 4
#define SIZEOF_LONG 8
#define SIZEOF_LONG_LONG 8
#define SIZEOF_VOID_P 8
#define SIZEOF_FLOAT 4
#define SIZEOF_DOUBLE 8

 /*
  * ILP32: sizeof(int),sizeof(long) and sizeof(void *) are all 4.
  *  LP64: sizeof(int) is 4, sizeof(long) and sizeof(void *) are 8.
  */

#if SIZEOF_INT==4 && SIZEOF_LONG==4 && SIZEOF_VOID_P==4
#define ILP32
#elif SIZEOF_INT==4 && SIZEOF_LONG==8 && SIZEOF_VOID_P==8
#define LP64
#else
#error "Your machine is not supported. Please report."
#endif

 /*
  * This defines the preprocessor symbol for readline. Used in the simcalc
  * sources.
  */

#ifdef USE_READLINE
#define ___SIMCALC_RL
#endif

 /*
  * This symbol defines if the SIMATH extension library was found in
  * the sources subdirectory. simcalc depends on this symbol.
  */

/* #undef HAVE_SM_EXT */

 /*
  * This symbol defines if the SIMATH C++ extensions were found when
  * compiling SIMATH.
  */

/* #undef HAVE_SM_CXX */

