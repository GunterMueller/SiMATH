/*   MC */
#ifndef _HDARITH_H
#define _HDARITH_H


#ifndef _0
#include<_simath.h>   
#endif   

#include <_heidelberg.h>

/* Integer Version 2.1, RD, 16.7.93	iint.h	*/
/* Integer Version 2.0, RD, 15.1.93	iint.h	*/

#ifndef _IINT_H
#define _IINT_H

typedef unsigned long 	DigitType;
#define BitsPerDigit	(sizeof(DigitType)*8)

/* Need definiton of FILE */


/*	Here is the part of c_varieties.h we shall use	(eliminated by MC.)*/

#define EXTERN_FUNCTION( rtn, args ) rtn()
#define _VOID_
#define const


/*	And now come some useful definitions	*/

#ifndef BOOLEANDEF
#define BOOLEANDEF
    typedef int     BOOLEAN;
#endif
#ifndef FALSE
#define FALSE 0
#endif
#ifndef TRUE
#define TRUE 1
#endif
#ifndef NULL
#define NULL 0
#endif

/* These are the signs of our Integers */

#define PLUS 0
#define MINUS 1

/*	This is the main data type	*/
/* undefine vec, da SIMATH-Datentyp */
#ifdef vec
#undef vec
#endif


typedef struct {
    DigitType          *vec;
    int             maxlength, length, sign;
}               Integer, *pInteger;


/*      Special sort of code to name the functions:
        I:      Integer
        int:    int
        as:     assign
        pl:     plus
        mi:     minus
	eq:	equal
	gt:	greater than
	mu:	multiply
	sl:	shift left
	sr:	shift right
*/


EXTERN_FUNCTION(void cI, (Integer *));			/* Creator */
EXTERN_FUNCTION(void cIasint, (Integer *, int));	/* Creator + Init int */
EXTERN_FUNCTION(void cIasuint, (Integer *, unsigned int));
	/* Creator + Init unsigned int */
EXTERN_FUNCTION(void cIaslong, (Integer *, long));
	/* Creator + Init long */
EXTERN_FUNCTION(void cIasulong, (Integer *, unsigned long));
	/* Creator + Init unsigned long */
EXTERN_FUNCTION(void cIasI, (Integer *, const Integer *));
	/* Creator + Init Int */
EXTERN_FUNCTION(void cImaxlength, (Integer *, int));
 	/* maxlength wird vorgegeben */
EXTERN_FUNCTION(void dI, (Integer *));			/* Destructor */

EXTERN_FUNCTION(Integer * ncI, (_VOID_));		/* new Integer + cI */
EXTERN_FUNCTION(Integer * ncIasint, (int));	/* new Integer + cIasint */
EXTERN_FUNCTION(Integer * ncIasI, (Integer *));	/* new Integer + cIasI */
EXTERN_FUNCTION(Integer * ncImaxlength, (int));	/* new Integer + cImaxlength */
EXTERN_FUNCTION(void ddI, (Integer *));		/* dI + delete Integer */

EXTERN_FUNCTION(void Ierror, (const char *));	/* Error message */

EXTERN_FUNCTION(void IasI, (Integer *, const Integer *));	/* Assignment */
EXTERN_FUNCTION(void Iasint, (Integer *, int));	    /* Assignment of an int */
EXTERN_FUNCTION(void Ias0, (Integer *));
EXTERN_FUNCTION(void Ias1, (Integer *));
#ifdef USE_THIS_LOT_OF_MACROS
#define IAS0(A) ((A)->length=0, (A)->sign=PLUS)
#define IAS1(A) ((A)->length=1, *((A)->vec)=1, (A)->sign=PLUS)
#endif
EXTERN_FUNCTION(BOOLEAN Iisint, (const Integer *));
EXTERN_FUNCTION(BOOLEAN Iisuint, (const Integer *));
EXTERN_FUNCTION(BOOLEAN Iislong, (const Integer *));
EXTERN_FUNCTION(BOOLEAN Iisulong, (const Integer *));
EXTERN_FUNCTION(int intasI, (const Integer *));
EXTERN_FUNCTION(unsigned int uintasI, (const Integer *));
EXTERN_FUNCTION(long longasI, (const Integer *));
EXTERN_FUNCTION(unsigned long ulongasI, (const Integer *));

EXTERN_FUNCTION(int Ilog, (const Integer *));	/* Two's logarithm */
EXTERN_FUNCTION(int intlog, (int));	/* Two's logarithm */

EXTERN_FUNCTION(void IasIplI, (Integer *, const Integer *, const Integer *));
	/* Addition + */
EXTERN_FUNCTION(void IasImiI, (Integer *, const Integer *, const Integer *));
	/* Subtraction - */
EXTERN_FUNCTION(void IplasI, (Integer *, const Integer *));
	/* Addition += */
EXTERN_FUNCTION(void ImiasI, (Integer *, const Integer *));
	/* Subtraction -= */
EXTERN_FUNCTION(void Ineg, (Integer *));
	/* Change the sign */
EXTERN_FUNCTION(void Iinc, (Integer *));		/* ++ */
EXTERN_FUNCTION(void Idec, (Integer *));		/* -- */

EXTERN_FUNCTION(BOOLEAN IeqI, (const Integer *, const Integer *));
	/* Test equality == */
EXTERN_FUNCTION(BOOLEAN IgtI, (const Integer *, const Integer *));
	/* Test greater > */
EXTERN_FUNCTION(BOOLEAN IneI, (const Integer *, const Integer *));
EXTERN_FUNCTION(BOOLEAN IgeI, (const Integer *, const Integer *));
EXTERN_FUNCTION(BOOLEAN IltI, (const Integer *, const Integer *));
EXTERN_FUNCTION(BOOLEAN IleI, (const Integer *, const Integer *));
EXTERN_FUNCTION(BOOLEAN Ige0, (const Integer *));
EXTERN_FUNCTION(BOOLEAN Igt0, (const Integer *));
EXTERN_FUNCTION(BOOLEAN Ile0, (const Integer *));
EXTERN_FUNCTION(BOOLEAN Ilt0, (const Integer *));
EXTERN_FUNCTION(BOOLEAN Ieq0, (const Integer *));
EXTERN_FUNCTION(BOOLEAN Ieq1, (const Integer *));

#ifdef USE_THIS_LOT_OF_MACROS
#define INEI(A, B)	(!IeqI((A), (B)))
#define IGEI(A, B)	(!IgtI((B), (A)))
#define ILTI(A, B)	(IgtI((B), (A)))
#define ILEI(A, B)	(!IgtI((A), (B)))
#define IGE0(A)		((A)->sign==PLUS)
#define IGT0(A)		(((A)->sign==PLUS)&&((A)->length))
#define ILE0(A)		(!(A)->length || ((A)->sign==MINUS))
#define ILT0(A)		((A)->sign==MINUS)
#define IEQ0(A)		(!(A)->length)
#define IEQ1(A)	((*((A)->vec)==1)&&((A)->length==1)&&((A)->sign==PLUS))
#endif

EXTERN_FUNCTION(void IasImuI, (Integer *, const Integer *, const Integer *));
	/* Multiplication * */
EXTERN_FUNCTION(void ImuasI, (Integer *, const Integer *));
	/* Multiplication *= */
EXTERN_FUNCTION(void IasImuD, (Integer *, const Integer *, DigitType));
	/* Multiplication with DigitType */
EXTERN_FUNCTION(void ImuasD, (Integer *, DigitType));

EXTERN_FUNCTION(void IasIsrint, (Integer *, const Integer *, unsigned int));
	/* Shift to the right */
EXTERN_FUNCTION(void Israsint, (Integer *, unsigned int));
	/* Shift to the right */
EXTERN_FUNCTION(void IasIslint, (Integer *, const Integer *, unsigned int));
	/* Shift to the left */
EXTERN_FUNCTION(void Islasint, (Integer *, unsigned int));
	/* Shift to the left */
EXTERN_FUNCTION(BOOLEAN Isr1, (Integer *));	/* Shift by one */
EXTERN_FUNCTION(BOOLEAN Ieven, (const Integer *));	/* is a even? */
#ifdef USE_THIS_LOT_OF_MACROS
#define IEVEN(A)	(!(*((A)->vec) & 1))
#endif

EXTERN_FUNCTION(DigitType uIdiasD, (Integer *, DigitType));
	/* Division by DigitType, no sign, return remainder. */
EXTERN_FUNCTION(DigitType IdiasD, (Integer *, DigitType));
	/* Division by DigitType, with sign, return remainder. */
EXTERN_FUNCTION(DigitType uIasIdiD, (Integer *, const Integer *, DigitType));
	/* Division by DigitType, no sign, return remainder. */
EXTERN_FUNCTION(DigitType IasIdiD, (Integer *, const Integer *, DigitType));
	/* Division by DigitType, with sign, return remainder. */
EXTERN_FUNCTION(void uIdiv, (Integer *q, Integer *r, const Integer *a, const Integer *b));
	/* Division with remainder a=bq+r, no sign */
EXTERN_FUNCTION(void Idiv, (Integer *q, Integer *r, const Integer *a, const Integer *b));
	/* Division with remainder a=bq+r, with sign */
EXTERN_FUNCTION(void IasIdiI, (Integer *, const Integer *, const Integer *));
	/* Division, quotient */
EXTERN_FUNCTION(void IasIreI, (Integer *, const Integer *, const Integer *));
	/* Division, remainder */
EXTERN_FUNCTION(void IdiasI, (Integer *, const Integer *));
	/* Division, quotient */
EXTERN_FUNCTION(void IreasI, (Integer *, const Integer *));
	/* Division, remainder */

EXTERN_FUNCTION(int fscanI, (FILE *, Integer *));	/* Input from file */
EXTERN_FUNCTION(int fprintI, (FILE *, const Integer *));
	/* Output to file */

EXTERN_FUNCTION(void Idgcd, (Integer *d, const Integer *a, const Integer *b));
	/* Euklid's Algorithm (Division)  d=gcd(a, b); */
EXTERN_FUNCTION(void Ibgcd, (Integer *d, const Integer *a, const Integer *b));
	/* Binary gcd */
#define Igcd	Ibgcd
	/* Standard gcd	*/
EXTERN_FUNCTION(void Idxgcd,(Integer*d,Integer*u,Integer*v,const Integer*a,const Integer*b));
	/* Extended gcd:  d=gcd(a, b)==ua+vb; */
#define Ixgcd	Idxgcd
EXTERN_FUNCTION(void Ibxgcd,(Integer*d,Integer*u,Integer*v,const Integer*a,const Integer*b));
	/* Binary xgcd */
EXTERN_FUNCTION(void Ireduce, (Integer *a, Integer *b));	/* reduce gcd */

EXTERN_FUNCTION(void IasrandomI, (Integer * a, const Integer * b));
 /*
  * Randomgenerator: choose random a with 0<=|a|<|b|, a->sign=b->sign.
  * a and b have to be distinct.
  */

/* Now come some functions for fast writing and reading or sending and
 * receiving Integers. The result of these functions are pointers to
 * memory blocks consisting of l bytes, that have to be sent/received
 * by appropriate funtions.
 *	The calling sequences are:
 *	- sender:	p=wIdata1(a, &l);
 *			send(channel, p, l);	(or write(file, p, l); ...)
 *			p=wIdata2(a, &l);
 *			send(channel, p, l);
 *	- receiver:	p=rIdata1(a, &l);
 *			receive(channel, p, l);
 *			p=rIdata2(a, &l);
 *			receive(channel, p, l);
 */
EXTERN_FUNCTION(char *wIdata1, (const Integer * a, int *l));
EXTERN_FUNCTION(char *wIdata2, (const Integer * a, int *l));
EXTERN_FUNCTION(char *rIdata1, (const Integer * a, int *l));
EXTERN_FUNCTION(char *rIdata2, (Integer * a, int *l));

EXTERN_FUNCTION(int Itoa, (const Integer * n, char s[]));
EXTERN_FUNCTION(int atoI, (char s[], Integer * n));

EXTERN_FUNCTION(void IprintStatistics, (_VOID_));



#endif


/* Integer Version 2.0, RD, 15.1.93	imem.h	*/

#ifndef _IMEM_H
#define _IMEM_H


/* Es fehlen einige Includes, MC */

EXTERN_FUNCTION(DigitType * newDigitVec, (int *maxl));
EXTERN_FUNCTION(void delDigitVec, (DigitType *u, int maxl));

EXTERN_FUNCTION(Integer * _newInteger, (_VOID_));
EXTERN_FUNCTION(void _delInteger, (Integer *u));

EXTERN_FUNCTION(char *Imalloc, (int));	/* Systemunabhaengiges malloc */
EXTERN_FUNCTION(void Ifree, (char *)); /* Systemunabhaengiges free */
EXTERN_FUNCTION(void IprintStatistics, (_VOID_));


#endif



/* DigitVecAddCarry and DigitVecSubCarry removed, RD, 14.7.93 */
/* Integer Version 2.1, RD, 13.7.93	idigit.h	*/
/* Changed definition of DigitMult, added DigitMultAdd, RD, 13.7.93	*/
/* Integer Version 2.0, RD, 15.1.93	idigit.h	*/
/* DigitMultAdd and DigitMultSub removed, RD, 11.2.93 */

#ifndef _IDIGIT_H
#define _IDIGIT_H

/* include "iint.h" */

/* iint.h defines DigitType, BitsPerDigit and
	the c-varieties macros:
	EXTERN_FUNCTION, _VOID_, (const)
*/
/* Remark: In this version BitsPerDigit==sizeof(DigitType)*8,
	idigit*.c and shifts depend on this.			*/

/*******************************
	First the Digit-operations
*********************************/

EXTERN_FUNCTION( DigitType  DigitAdd, 
	( DigitType *sum, DigitType a, DigitType b, DigitType carry) );
        /* *sum=LOW-DIGIT(a+b+carry);
	   return HIGH-DIGIT(a+b+carry); 
	*/
EXTERN_FUNCTION( DigitType  DigitSub, 
	( DigitType *diff, DigitType a, DigitType b, DigitType carry) );
        /* *diff=RESULT;
	   return CARRY;
	   where RESULT, CARRY are defined by: 
	   2^BitsPerDigit > 
		CARRY*2^BitsPerDigit + a - b - carry == RESULT >= 0
	*/
EXTERN_FUNCTION( DigitType  DigitMult, 
	( DigitType *prod, DigitType a, DigitType b) );
        /* *prod=LOW-DIGIT(a*b);
	   return HIGH-DIGIT(a*b); 
	*/
EXTERN_FUNCTION( DigitType  DigitMultAdd, 
	( DigitType *prod, DigitType a, DigitType b, DigitType carry) );
        /* *prod=LOW-DIGIT(a*b+carry);
	   return HIGH-DIGIT(a*b+carry); 
	*/
EXTERN_FUNCTION( DigitType  DigitDiv, 
	( DigitType *quot, DigitType h, DigitType l, DigitType d) );
	/* Suppose:	d>0 and h<d
	   *quot=QUOT;
	   return REM;
	   where QUOT, REM are defined by: 
	   h*2^BitsPerDigit + l == d*QUOT + REM,
	   2^BitsPerDigit > REM >= 0
	*/

/*******************************
	Now the standard DigitVec operations 
*********************************/

EXTERN_FUNCTION( DigitType  DigitVecAdd, 
	( DigitType *sum, DigitType *a, DigitType *b, int l) );
     /*	sum[0..l-1] = a[0..l-1] + b[0..l-1]; return CARRY;   */
     /* This notation means:
	Add the integers represented by the vectors a and b,
	write the lowest l digits of the result into the vector sum
	and return the carry of this operation.
     */
EXTERN_FUNCTION( DigitType  DigitVecSub, 
	( DigitType *diff, DigitType *a, DigitType *b, int l) );
     /*	diff[0..l-1] = a[0..l-1] - b[0..l-1]; return CARRY;   */

EXTERN_FUNCTION( DigitType  DigitVecMult, 
	( DigitType *res, DigitType *a, DigitType m, int l) );
     /*	res[0..l-1] = a[0..l-1]*m; return CARRY;   */
EXTERN_FUNCTION( DigitType  DigitVecMultAdd, 
	( DigitType *res, DigitType *a, DigitType m, int l) );
     /*	res[0..l-1] += a[0..l-1]*m; return CARRY;   */
     /* Special function for multiple digit multiplication */
EXTERN_FUNCTION( DigitType  DigitVecMultSub, 
	( DigitType *res, DigitType *a, DigitType m, int l) );
     /*	res[0..l] -= a[0..l-1]*m; return CARRY;   */
     /* Special function for multiple digit division */
EXTERN_FUNCTION( DigitType  DigitVecDiv, 
	( DigitType *quot, DigitType *a, DigitType d, int l) );
     /*	quot[0..l-1] = a[0..l-1]/m; 
	return a[0..l-1]%m;
     */

/*******************************
	Now some special critical DigitVec operations
	(at least for the needs of Integer 2.0)
*********************************/

EXTERN_FUNCTION(void DigitVecCsubto, 
	(DigitType *a, DigitType *b, int l));
        /* a[]-=b[l]; */
EXTERN_FUNCTION(int DigitVecCadd, 
	(DigitType *sum, DigitType *a, DigitType *b, int la, int lb));
	/* sum[]=a[la]+b[lb]; return sum->length */
EXTERN_FUNCTION(int DigitVecCsub, 
	(DigitType *diff, DigitType *a, DigitType *b, int la, int lb));
	/* diff[]=a[la]-b[lb]; return diff->length */
EXTERN_FUNCTION(BOOLEAN DigitVecSr1, (DigitType *u, int l));
	/* b=u[l]%2; u[l]/=2; return b; */
EXTERN_FUNCTION(void DigitVecSri, (DigitType *u, int l, int i));
	/* b=u[l]%2^i; u[l]/=2^i; 	0<i<BitsPerDigit  */

/*******************************
	Some general non-critical DigitVec operations 
*********************************/

EXTERN_FUNCTION(BOOLEAN DigitVecEq, (DigitType *a, DigitType *b, int l));
        /* return a[l]==b[l]; */
EXTERN_FUNCTION(BOOLEAN DigitVecGt, (DigitType *a, DigitType *b, int l));
        /* return a[l]>b[l] lexikographisch */

/*******************************
	At the end an internal function for DigitVec multiplication
		via Karatsubas method
*********************************/

EXTERN_FUNCTION(void DigitVecKaratsubaM, 
	(DigitType *prod, DigitType *a, DigitType *b, DigitType *tmp, int n2));


#endif



/* Integer Version 2.1, RD, 16.7.92 	imod.h			*/

/* Modular arithmetic with Montgomery's method. Based on the large
   integer arithmetic libI. RD, 16.7.93.			*/


#ifndef _IMOD_H
#define _IMOD_H

/* include "iint.h"    */

typedef struct {
	DigitType *vec;
	int length;
	DigitType nprime;
	DigitType *rsquare;
	DigitType *rcube;
	void *memsingfree;
	void *memdoubfree;
	Integer ModIval;
} ModulusType;

typedef struct {
	ModulusType *mod;
	DigitType *val;
} Minteger;

EXTERN_FUNCTION(void Merror, (const char *));		/* Error message */
EXTERN_FUNCTION(void cMod, (ModulusType *, const Integer *));
	/* Creator Modulus */
EXTERN_FUNCTION(void dMod, (ModulusType *));
	/* Destructor Modulus */
EXTERN_FUNCTION(void IasMod, (Integer *, const ModulusType *));
	/* Modulus value */

EXTERN_FUNCTION(const ModulusType * Mmod, (const Minteger *));
	/* Reference Modulus */

EXTERN_FUNCTION(void cM, (Minteger *, ModulusType *));
	/* Creator Minteger */
EXTERN_FUNCTION(void cMasI, (Minteger *, const Integer *, ModulusType *));
	/* Creator Minteger, Init Integer */
EXTERN_FUNCTION(void cMasM, (Minteger *, const Minteger *));	
	/* Creator Minteger, Init Minteger */
EXTERN_FUNCTION(void dM, (Minteger *));			/* Destructor */

EXTERN_FUNCTION(void MasM, (Minteger *, const Minteger *));
EXTERN_FUNCTION(void MasI, (Minteger *, const Integer *));
EXTERN_FUNCTION(void IasM, (Integer *, const Minteger *));

EXTERN_FUNCTION(BOOLEAN Meq0, (const Minteger *));
EXTERN_FUNCTION(void MasMplM, (Minteger *, const Minteger *, const Minteger *));
EXTERN_FUNCTION(void MplasM, (Minteger *, const Minteger *));
EXTERN_FUNCTION(void MasMmiM, (Minteger *, const Minteger *, const Minteger *));
EXTERN_FUNCTION(void MmiasM, (Minteger *, const Minteger *));
EXTERN_FUNCTION(void MasMmuM, (Minteger *, const Minteger *, const Minteger *));
EXTERN_FUNCTION(void MmuasM, (Minteger *, const Minteger *));

EXTERN_FUNCTION(BOOLEAN MasinvM, (Minteger *, const Minteger *));
#define	bMasinvM MasinvM
EXTERN_FUNCTION(void MasMdiM, (Minteger *, const Minteger *, const Minteger *));
EXTERN_FUNCTION(void MdiasM, (Minteger *, const Minteger *));

EXTERN_FUNCTION(void Mrandom, (Minteger * a));


#endif      

/*		random.h		*/

#ifndef SRANDOM_IN_MATH_H
#ifdef HAVE_RANDOM
void 	srandom();	/* void srandom(unsigned); */
#endif
#endif

#ifndef INITSTATE_IN_MATH_H
#ifdef HAVE_RANDOM
char * 	initstate();	/* char* initstate(unsigned, char *, int); */
#endif
#endif

#ifndef SETSTATE_IN_MATH_H
#ifdef HAVE_RANDOM
char *	setstate();	/* char* setstate(char *); */
#endif
#endif

#ifndef RANDOM_IN_MATH_H
#ifdef HAVE_RANDOM
long	random();	/* returns random 31 lower bits */
#endif        
#endif

/* Funktion zur Zeitmessung, liefert 1/100 sec Ticks der user-Zeit.
	und eine Funktion, die eine Saat fuer den Zufallsgenerator
	liefert.

	RD, 12.09.90	*/

#ifndef TIMING_H
#define TIMING_H

#ifndef C_VARIETIES_H

#ifndef EXTERN_FUNCTION
#ifdef __cplusplus
#define EXTERN_FUNCTION( rtn, args ) extern "C" { rtn args; }
#define _VOID_ /* anachronism */
#else
#ifdef __STDC__
#ifdef __PARC__
#define EXTERN_FUNCTION( rtn, args ) rtn()
#define _VOID_
#else
#define EXTERN_FUNCTION( rtn, args ) rtn args
#define _VOID_ void
#endif
#else
#define EXTERN_FUNCTION( rtn, args ) rtn()
#define _VOID_
#endif
#endif
#endif

#endif

EXTERN_FUNCTION( unsigned long timeticks, (void) );
EXTERN_FUNCTION( unsigned int timeseed, (void) );

#endif



#endif
