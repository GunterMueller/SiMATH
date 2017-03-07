/*M
.SH NAME
masumspec - matrix sum, special

.SH SYNOPSIS
.nf
#include<_matr1.h>

matrix masumspec(M, N, sumfunc, numargs, arg1, ..., arg5)
matrix M, N;
obj (*sumfunc)();
single numargs;
obj arg1, ..., arg5;

.SH DESCRIPTION
masumspec() returns the matrix M+N.

.PP
.TP 4
.B M, N
are matrices over a certain ring R.
M and N must have equal dimensions.
.TP 4
.B sumfunc
is an addition function for the ring R.
This function is given the two elements to add and the additional arguments.
.TP 4
.B numargs
is the number of additional arguments actually used by sumfunc.
.TP 4
.B arg1, ..., arg5
are at most 5 optional arguments for sumfunc.
M*/
/*H
	Version 1       28.03.1990      Th. Weis
   DATE masumspec     : 910915
H*/

#include <_matr1.h>

matrix masumspec(M,N,sum,anzahlargs,arg1,arg2,arg3,arg4,arg5)
matrix M,N;
obj    ( *sum )();
single anzahlargs;
obj    arg1,arg2,arg3,arg4,arg5;
{
	list   ZL, ZM, ZN;
	matrix L;
	obj    *p10, *p20, *p30, *p40, *p50, *p60, *p70, a, b, c;

	bind( M, N );
	bind( arg1,arg2,arg3,arg4,arg5 );
	init( L, ZL, ZM, ZN, a, b, c );

/*** Vorbelegung ***/

	p30 = p40 = p50 = p60 = p70 = &c;

	switch ( anzahlargs )
	{
	   case 0: p10 = &b;               /** Z, Q **/
	           p20 = &a;
	           break;
	   case 1: p10 = &arg1;            /** Z/mZ, Pi, Pr **/
	           p20 = &a;
	           p30 = &b;
	           break;
	   case 2: p10 = &arg1;            /** Pms **/
	           p20 = &arg2;
	           p30 = &a;
	           p40 = &b;
	           break;
	   case 3: p10 = &arg1;            /** Pgfs **/
	           p20 = &arg2;
	           p30 = &arg3;
	           p40 = &a;
	           p50 = &b;
	           break;
	   case 4: p10 = &arg1;
	           p20 = &arg2;
	           p30 = &arg3;
	           p40 = &arg4;
	           p50 = &a;
	           p60 = &b;
	           break;
	   case 5: p10 = &arg1;
	           p20 = &arg2;
	           p30 = &arg3;
	           p40 = &arg4;
	           p50 = &arg5;
	           p60 = &a;
	           p70 = &b;
	           break;
	}
	L = _0;
	while ( M != _0 )
	{
	   ZL = _0;
	   ZM = lfirst( M );
	   ZN = lfirst( N );

/*** Addition zeilenweise ***/

	   while ( ZM != _0 )
	   {
	      a = lfirst( ZM );
	      ZM = lred( ZM );
	      b = lfirst( ZN );
	      ZN = lred( ZN );
	      c = ( *sum )( *p10, *p20, *p30, *p40, *p50, *p60, *p70 );
	      ZL = lcomp( c, ZL );
	   }
	   ZL = linv( ZL );
	   L = lcomp( ZL, L );
	   M = lred( M );
	   N = lred( N );
	}
	return( linv( L ) );
}
