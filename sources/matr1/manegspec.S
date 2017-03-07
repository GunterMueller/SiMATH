/*M
.SH NAME
manegspec - matrix negation, special

.SH SYNOPSIS
.nf
#include<_matr1.h>

matrix manegspec(M, negfunc numargs, arg1, ..., arg5)
matrix M;
obj (*negfunc)();
single numargs;
obj arg1, ..., arg5;

.SH DESCRIPTION
manegspec() returns the matrix -M.

.PP
.TP 4
.B M
is a matrix of objects.
.TP 4
.B negfunc
is a function to negate a single element of the matrix.
This function is given the element and the additional arguments.
.TP 4
.B numargs
is the number of additional arguments actually used by negfunc.
.TP 4
.B arg1, ..., arg5
are at most 5 optional arguments for negfunc.
M*/



/*H
	Version 1       21.03.1990	Th. Weis
   DATE manegspec     : 910915
H*/

#include <_matr1.h>

matrix manegspec(M,neg,anzahlargs,arg1,arg2,arg3,arg4,arg5)
matrix M;
obj    ( *neg )();
single anzahlargs;
obj    arg1, arg2, arg3, arg4, arg5;
{
	list   ZL, ZM, ZN;
	matrix L, N;
	obj    *p10, *p20, *p30, *p40, *p50, *p60, a;

	bind( M );
	bind( arg1,arg2,arg3,arg4,arg5 );
	init( L, N, ZL, ZM, ZN );

/*** Vorbelegung ***/

	p20 = p30 = p40 = p50 = p60 = &a;

	switch ( anzahlargs )
	{
	   case 0: p10 = &a;               /** Z, Q **/
		   break;
	   case 1: p10 = &arg1;            /** Z/mZ, Pi, Pr, nf(s) **/
		   p20 = &a;
		   break;
	   case 2: p10 = &arg1;            /** Pms, gfs **/
		   p20 = &arg2;
		   p30 = &a;
		   break;
	   case 3: p10 = &arg1;            /** Pgfs **/
		   p20 = &arg2;
		   p30 = &arg3;
		   p40 = &a;
		   break;
	   case 4: p10 = &arg1;
		   p20 = &arg2;
		   p30 = &arg3;
		   p40 = &arg4;
		   p50 = &a;
		   break;
	   case 5: p10 = &arg1;
		   p20 = &arg2;
		   p30 = &arg3;
		   p40 = &arg4;
		   p50 = &arg5;
		   p60 = &a;
		   break;
	}

/*** Negation ***/

	N = _0;
	while ( M != _0 )
	{
	   ZM = lfirst( M );
	   ZN = _0;
	   while ( ZM != _0 )
	   {
	      a = lfirst( ZM );
	      ZM = lred( ZM );
	      a = ( *neg )( *p10, *p20, *p30, *p40, *p50, *p60 );
	      ZN = lcomp( a, ZN );
	   }
	   ZN = linv( ZN );
	   N = lcomp( ZN, N );
	   M = lred( M );
	}
	return( linv( N ) );
}
