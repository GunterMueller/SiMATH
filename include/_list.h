/*
	961201	: SPACE entfernt
*/
#ifndef SIMATH_list_H
#define SIMATH_list_H

#define __LIST__
#include <smconfig.h>
#include <stdio.h>
#include <setjmp.h>
#include <ctype.h>
#include <math.h>


 /*
  * HZ should be defined in <sys/param.h>
  */

#ifndef  __PARAM_HEADER__
#include <sys/param.h>
#endif

#ifndef HZ
#define HZ 60
#endif

 /*
  * Definition of time_t and of the data types in the struct stat
  */

#ifndef  _TYPES_
#include <sys/types.h>
#endif

 /*
  * Definition of struct tms
  */

#include <sys/times.h>

 /*
  * Definition of struct stat
  */

#ifndef __STAT_HEADER__
#include <sys/stat.h>
#endif

#ifndef _NFILE
#define _NFILE NOFILE
#endif


#define  FULL_WIDTH (SIZEOF_INT*8-2)
#define  HALF_WIDTH (FULL_WIDTH/2)
#define  FULL_MASK  ((1<<FULL_WIDTH)-1)
#define  HALF_MASK  ((1<<HALF_WIDTH)-1)
#define  CELL_WIDTH 14                     /* ==log2(BL_SIZE+1) */
#define  CELL_MASK  ((1<<CELL_WIDTH)-1)    /* == BL_SIZE */
#define  BLOCK_MASK (FULL_MASK^CELL_MASK)

#define 	BASIS 	(1<<FULL_WIDTH)
#define 	_0 	(1<<FULL_WIDTH)
#define 	ERROR 	(-(1<<FULL_WIDTH))
#define 	atom 	int
#define 	single 	int
#define 	list 	int
#define 	obj 	int



 /*
  * WARNING! Since version 3.10.2, on all systems except for HP-UX, the last 
  * two bits are used for storage management. This requires that the addresses
  * of memory allocated by a SIMATH process must be divisible by 4.
  */

#ifdef ___HP
#define 	ltop(L) 	((PCELL)(L))
#define 	ptol(p,j) 	((int) (p))
#else
#ifndef LP64
#define 	ltop(L) 	((PCELL) ((L) << 2))
#define 	ptol(p,j) 	((((int) (p)) >> 2) | BASIS)
#else
/* ltop is a function */
#define         ptol(P,j)       (BASIS | ((j)<<CELL_WIDTH) | (int)((P)-BL_START[(j)]) +1)
#endif
#endif


#define           fgetc  xfgetc
#define           fgets  xfgets
#define         fprintf  xfprintf
#define           fputc  xfputc
#define     fputo(a,pf)  (isatom(a)?fputa(a,pf):fputl(a,pf))
#define           fputs  xfputs
#define          geta()  fgeta(stdin)
#undef getc
#define            getc  xfgetc
#undef getchar
#define       getchar()  xfgetc(stdin)
#define         getcb()  fgetcb(stdin)
#define         getcs()  fgetcs(stdin)
#define            gets  xgets
#define          getl()  fgetl(stdin)
#define          geto()  fgeto(stdin)
#define        lines(k)  flines(k,stdout)
#define          printf  xprintf
#define         puta(a)  fputa(a,stdout)
#define      putbits(a)  fputbits(a,stdout)
#undef  putc
#define      putc(c,pf)  xfputc(c,pf)
#undef  putchar
#define      putchar(c)  xfputc(c,stdout)
#define         putl(L)  fputl(L,stdout)
#define   putlstruct(L)  fputlstruct(L,stdout)
#define         puto(a)  (isatom(a)?fputa(a,stdout):fputl(a,stdout))
#define         puts(s)  xfputs(s,stdout)
#define    sputa(a,str)  ( sprintf(str,"%d",a), str )
#define          tab(n)  ftab(n,stdout)

#define       isatom(a)  ( (a) > -BASIS && (a) < BASIS )
#define     issingle(a)  isatom(a)
#define        isobj(a)  ( isatom(a) || islist(a) )

#define       lfirst(L)  (ltop(L)->inh)
#define         lred(L)  (ltop(L)->adr)

#define      lsecond(L)  (lfirst( lred(L) ) )
#define       lthird(L)  (lfirst( lred( lred(L) ) ) )
#define      lfourth(L)  (lfirst( lred( lred ( lred(L) ) ) ) )
#define       lfifth(L)  (lfirst( lred( lred( lred ( lred(L)  ) ) ) ) )

#define                list1(a)  lcomp(a,_0)
#define              list2(a,b)  lcomp2(a,b,_0)                    
#define            list3(a,b,c)  lcomp3(a,b,c,_0)           
#define          list4(a,b,c,d)  lcomp4(a,b,c,d,_0)  
#define        list5(a,b,c,d,e)  lcomp5(a,b,c,d,e,_0)
#define      list6(a,b,c,d,e,f)  lcomp6(a,b,c,d,e,f,_0)

#define        lred2(L)  (lred( lred( L ) ))
#define        lred3(L)  (lred( lred( lred( L ) ) ))
#define        lred4(L)  (lred( lred( lred( lred ( L ) ) ) ) )
#define        lred5(L)  (lred( lred( lred( lred (lred (L) ) ) ) ) )           


typedef struct {
	int adr;
	int inh;
} CELL, *PCELL;  


#define  lsfirst(L,a)  ( (ltop(L)->inh)=(a) )
                             /*L oder a keine Fkt*/
#define  lsred(L,L1)  ( (ltop(L)->adr)=(L1) )
                             /*L oder L1 keine Fkt*/


#define            lsuffix(L,a)  lconc(L,lcomp(a,_0))
			     /*L*/
#define            usunion(L,M)  lconc(usdiff(L,M),M)
			     /*M*/



#define 	lsize(l)  lsizerec (l,1)



/* extern PCELL   SPACE;   */
extern PCELL   *BL_START;
extern int     SP_MAX, ST_SIZE /*, STOCK_SZ */;
extern int     BL_SIZE, BL_NR, BL_NR_MAX, BL_NR_MSG;
extern int     GC_CC, GC_COUNT, GC_MESS, GC_QUOTE, GC_TEST, GC_TIME;
extern int     ST_INDEX, **STACK /*, *STOCK */;
extern list    AVAIL;
extern single  LN_SIZE, MARGIN;
extern obj     DUM, NUM;
extern jmp_buf FL_JMP;
extern single SS_MESS;

/* extern int  STOCK_IND; */
/* extern int  TRACE_ON, TRACE_CC; */

#ifdef LP64
/* function declaration */
extern PCELL ltop(list);
#endif
#endif
