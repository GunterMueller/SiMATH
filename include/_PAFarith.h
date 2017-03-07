/*
 * Copyright (c) 1993 Algebraic Software 
 * written by 
 *                   Papanikolaou Thomas
 *                (papanik@cs.uni-sb.de)
 */

#ifndef _FFLOAT_H
#define _FFLOAT_H

/* #include </home/marc/HEIDEL/iint.h>   */
/* #include <math.h>                     */

#include<_HDarith.h>        /* Marc Conrad */
#include <string.h>         /* MATSUI Fe2+ Tetsushi */

#ifndef HAVE_LOG2
#define log2( F ) (log( F ) / LOG2)
#endif

#define LogDigit      	5 
#define BigDigit1      	2147483648ul 
#define BigDigit       	4294967296.0 
#define LogPow10       	9 
#define BigPow10        1000000000
#define DigitsPerDouble sizeof(double)/sizeof(DigitType)

/* Constants */

#define L2B10           0.30102999566398119521 /* log(2)/log(10) */
#define LOG2            0.69314718055994530942 /* log(2) */
#define INVLOG2         1.44269504088896340735 /* 1/log(2) */

#define MaxPrec		(1 << MEMLISTMAX)
#define MaxBinPrec	MaxPrec << LogDigit
#define MaxDecPrec	(long) (0.5 * MaxBinPrec * L2B10)

#define MP_TRUNC        0 /* round to zero */
#define MP_RND          1 /* round to nearest */
#define MP_RND_UP       2 /* round to +infinity */
#define MP_RND_DOWN     3 /* round to -infinity */


/* Globals */

extern long     DecPrec; /* stores the precision in decimal digits */
extern long     BinPrec; /* stores the precision in binary digits */
extern long     Prec; /* stores the precision in words */
extern int      RoundMode; /* stores the rounding direction */
extern long     ExitOnError; /* selfexplanatory */
extern long     ErrorHasOccured; /* selfexplanatory */

/* c_varieties */
#ifndef C_VARIETIES_H
#define C_VARIETIES_H    /* Marc Conrad fuer SIMATH  */
#endif

/* c_varieties */

#ifndef C_VARIETIES_H

#ifdef __cplusplus
#define EXTERN_FUNCTION( rtn, args ) extern "C" { rtn args; }
#define _VOID_			/* anachronism */
#else
#ifdef __STDC__
#ifdef __PARC__
#define EXTERN_FUNCTION( rtn, args ) rtn()
#define _VOID_
#define const
#else
#define EXTERN_FUNCTION( rtn, args ) rtn args
#define _VOID_ void
#endif
#else
#define EXTERN_FUNCTION( rtn, args ) rtn()
#define _VOID_
#define const
#endif
#endif

#endif

/* Main data type */

typedef struct {
	Integer         m;	/* mantisse */
	long            e;	/* exponent */
}               Float, *pFloat;

extern Float    F_e; /* to store e */
extern Float    F_pi; /* to store pi */
extern Float    F_euler; /* to store euler */
extern Float	F_catalan; /* to store catalan */

EXTERN_FUNCTION(void cF, (Float *)
);
EXTERN_FUNCTION(void cFasF, (Float *, const Float *)
);
EXTERN_FUNCTION(void cFasI, (Float *, const Integer *)
);
EXTERN_FUNCTION(void cFasdbl, (Float *, double)
);
EXTERN_FUNCTION(void cFasint, (Float *, int)
);
EXTERN_FUNCTION(void cFasuint, (Float *, unsigned int)
);
EXTERN_FUNCTION(void cFaslong, (Float *, long)
);
EXTERN_FUNCTION(void cFasulong, (Float *, unsigned long)
);
EXTERN_FUNCTION(void cFmaxlength, (Float *, int)
);
EXTERN_FUNCTION(void dF, (Float *)
);

EXTERN_FUNCTION(Float * ncF, (void)
);
EXTERN_FUNCTION(Float * ncFasF, (Float *)
);
EXTERN_FUNCTION(Float * ncFasI, (Integer *)
);
EXTERN_FUNCTION(Float * ncFasdbl, (double)
);
EXTERN_FUNCTION(Float * ncFasint, (int)
);
EXTERN_FUNCTION(Float * ncFmaxlength, (int)
);
EXTERN_FUNCTION(void ddF, (Float *)
);

EXTERN_FUNCTION(void FasF, (Float *, const Float *)
);
EXTERN_FUNCTION(void FasI, (Float *, const Integer *)
);
EXTERN_FUNCTION(void Fasdbl, (Float *, double)
);
EXTERN_FUNCTION(void Fasint, (Float *, int)
);
EXTERN_FUNCTION(void Fas0, (Float *)
);
EXTERN_FUNCTION(void Fas1, (Float *)
);
EXTERN_FUNCTION(void IasF, (Integer *, const Float *)
);
EXTERN_FUNCTION(void dblasF, (double *, const Float *)
);

EXTERN_FUNCTION(BOOLEAN Fisint, (const Float *)
);
EXTERN_FUNCTION(BOOLEAN Fisuint, (const Float *)
);
EXTERN_FUNCTION(BOOLEAN Fislong, (const Float *)
);
EXTERN_FUNCTION(BOOLEAN Fisulong, (const Float *)
);
EXTERN_FUNCTION(BOOLEAN Fisdbl, (const Float *)
);

EXTERN_FUNCTION(void FasFplF, (Float *, const Float *, const Float *)
);
EXTERN_FUNCTION(void FplasF, (Float *, const Float *)
);
EXTERN_FUNCTION(void FasFplint, (Float *, const Float *, int)
);
EXTERN_FUNCTION(void Fplasint, (Float *, int)
);
EXTERN_FUNCTION(void Finc, (Float *)
);
EXTERN_FUNCTION(void Fabs, (Float *)
);

EXTERN_FUNCTION(void FasFmiF, (Float *, const Float *, const Float *)
);
EXTERN_FUNCTION(void FmiasF, (Float *, const Float *)
);
EXTERN_FUNCTION(void FasFmiint, (Float *, const Float *, int)
);
EXTERN_FUNCTION(void Fmiasint, (Float *, int)
);
EXTERN_FUNCTION(void Fdec, (Float *)
);
EXTERN_FUNCTION(void Fneg, (Float *)
);

EXTERN_FUNCTION(void FasFmuF, (Float *, const Float *, const Float *)
);
EXTERN_FUNCTION(void FmuasF, (Float *, const Float *)
);
EXTERN_FUNCTION(void FasFmuint, (Float *, const Float *, int)
);
EXTERN_FUNCTION(void Fmuasint, (Float *, int)
);
EXTERN_FUNCTION(void FasFmu10, (Float *, const Float *, int)
);
EXTERN_FUNCTION(void Fmuas10, (Float *, int)
);

EXTERN_FUNCTION(void FasFdiF, (Float *, const Float *, const Float *)
);
EXTERN_FUNCTION(void FasFdiF1, (Float *, const Float *, const Float *)
);
EXTERN_FUNCTION(void FdiasF, (Float *, const Float *)
);
EXTERN_FUNCTION(void FasFdiint, (Float *, const Float *, int)
);
EXTERN_FUNCTION(void Fdiasint, (Float *, int)
);
EXTERN_FUNCTION(void FasintdiF, (Float *, int, const Float *)
);
EXTERN_FUNCTION(void Fasintdiint, (Float *, int, int)
);

EXTERN_FUNCTION(void FasFslint, (Float *, const Float *, unsigned int)
);
EXTERN_FUNCTION(void Fslasint, (Float *, unsigned int)
);
EXTERN_FUNCTION(void FasFsrint, (Float *, const Float *, unsigned int)
);
EXTERN_FUNCTION(void Fsrasint, (Float *, unsigned int)
);

EXTERN_FUNCTION(void Fsqrt, (Float *, const Float *)
);
EXTERN_FUNCTION(void Fexp, (Float *, const Float *)
);
EXTERN_FUNCTION(void Flog, (Float *, const Float *)
);
EXTERN_FUNCTION(void FasFpowF, (Float *, const Float *, const Float *)
);
EXTERN_FUNCTION(void FasFpowint, (Float *, const Float *, int)
);
EXTERN_FUNCTION(void FsqrF, (Float *, const Float *)
);
EXTERN_FUNCTION(void Fsqr, (Float *)
);
EXTERN_FUNCTION(void Fbesselj, (Float *, int, const Float *)
);
EXTERN_FUNCTION(void Fe, (Float *)
);
EXTERN_FUNCTION(void Fpi, (Float *)
);
EXTERN_FUNCTION(void Feuler, (Float *)
);
EXTERN_FUNCTION(void Fcatalan, (Float *)
);
EXTERN_FUNCTION(void Fsin, (Float *, const Float *)
);
EXTERN_FUNCTION(void Fcos, (Float *, const Float *)
);
EXTERN_FUNCTION(void Ftan, (Float *, const Float *)
);
EXTERN_FUNCTION(void Fcot, (Float *, const Float *)
);
EXTERN_FUNCTION(void Fasin, (Float *, const Float *)
);
EXTERN_FUNCTION(void Facos, (Float *, const Float *)
);
EXTERN_FUNCTION(void Fatan, (Float *, const Float *)
);
EXTERN_FUNCTION(void Fatan2, (Float *, const Float *, const Float *)
);
EXTERN_FUNCTION(void Facot, (Float *, const Float *)
);
EXTERN_FUNCTION(void Fsinh, (Float *, const Float *)
);
EXTERN_FUNCTION(void Fcosh, (Float *, const Float *)
);
EXTERN_FUNCTION(void Ftanh, (Float *, const Float *)
);
EXTERN_FUNCTION(void Fcoth, (Float *, const Float *)
);
EXTERN_FUNCTION(void Fasinh, (Float *, const Float *)
);
EXTERN_FUNCTION(void Facosh, (Float *, const Float *)
);
EXTERN_FUNCTION(void Fatanh, (Float *, const Float *)
);
EXTERN_FUNCTION(void Facoth, (Float *, const Float *)
);
EXTERN_FUNCTION(void Frndtoi, (Float *, const Float *)
);
EXTERN_FUNCTION(void Fceil, (Float *, const Float *)
);
EXTERN_FUNCTION(void Ffloor, (Float *, const Float *)
);
EXTERN_FUNCTION(void Ftrunc, (Float *, const Float *)
);

EXTERN_FUNCTION(BOOLEAN FeqF, (const Float *, const Float *)
);
EXTERN_FUNCTION(BOOLEAN FgtF, (const Float *, const Float *)
);
EXTERN_FUNCTION(BOOLEAN FneF, (const Float *, const Float *)
);
EXTERN_FUNCTION(BOOLEAN FgeF, (const Float *, const Float *)
);
EXTERN_FUNCTION(BOOLEAN FltF, (const Float *, const Float *)
);
EXTERN_FUNCTION(BOOLEAN FleF, (const Float *, const Float *)
);
EXTERN_FUNCTION(BOOLEAN Fge0, (const Float *)
);
EXTERN_FUNCTION(BOOLEAN Fgt0, (const Float *)
);
EXTERN_FUNCTION(BOOLEAN Fle0, (const Float *)
);
EXTERN_FUNCTION(BOOLEAN Flt0, (const Float *)
);
EXTERN_FUNCTION(BOOLEAN Feq0, (const Float *)
);
EXTERN_FUNCTION(BOOLEAN Fne0, (const Float *)
);
EXTERN_FUNCTION(BOOLEAN Fis0, (const Float *)
);
EXTERN_FUNCTION(BOOLEAN FcompF, (const Float *, const Float *)
);

EXTERN_FUNCTION(int Fsign, (Float *)
);
EXTERN_FUNCTION(void Fsetsign, (Float *, int)
);
EXTERN_FUNCTION(long Fexpo, (Float *)
);
EXTERN_FUNCTION(void Fsetexpo, (Float *, long)
);

EXTERN_FUNCTION(void Fsetprec, (long)
);
EXTERN_FUNCTION(int Flead0s, (unsigned long)
);
EXTERN_FUNCTION(int Fleadzeros, (Float *)
);
EXTERN_FUNCTION(int Flength, (const Float *)
);
EXTERN_FUNCTION(void Fbinul, (unsigned long)
);
EXTERN_FUNCTION(void Fbinary, (Float *)
);
EXTERN_FUNCTION(void Fnorm, (Float *)
);
EXTERN_FUNCTION(void Froundb, (Float *, unsigned int)
);
EXTERN_FUNCTION(void Fnormalize, (Float *)
);

EXTERN_FUNCTION(int Flog2, (const Float *)
);
EXTERN_FUNCTION(int fscanF, (FILE *, Float *)
);
EXTERN_FUNCTION(int fprintF, (FILE *, const Float *)
);
EXTERN_FUNCTION(int Ftoa, (const Float * n, char s[])
);
EXTERN_FUNCTION(int atoF, (char s[], Float * n)
);
EXTERN_FUNCTION(void printF, (char s[], const Float * n)
);

EXTERN_FUNCTION(void Ferror, (const char *)
);
EXTERN_FUNCTION(char *Fmalloc, (int)
);
EXTERN_FUNCTION(void Ffree, (char *)
);
EXTERN_FUNCTION(void FprintStatistics, (void)
);

#endif
