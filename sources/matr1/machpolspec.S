/*M
.SH NAME
machpolspec - matrix characteristic polynomial, special

.SH SYNOPSIS
.nf
#include<_matr1.h>

pol machpolspec(M, detfunc, minusone, numargs, arg1, ..., arg5)
matrix M;
obj (*det)(), minusone;
single numargs;
obj arg1, ..., arg5;

.SH DESCRIPTION
machpolspec() returns the characteristic polynomial of the matrix M,
which is a polynomial in a new variable X.
It is calculated as Det(M-X*E).

.PP
.TP 4
.B M
is a matrix over a certain ring R.
.TP 4
.B detfunc
is a function to calculate the determinant of the matrix M-X*E.
This function is given M-X*E and the additional arguments.
.TP 4
.B minusone
is the element representing -1 in the ring R.
.TP 4
.B numargs
is the number of additional arguments actually used by detfunc.
.TP 4
.B arg1, ..., arg5
are at most 5 optional arguments for detfunc.
M*/


/*H
	Version 1       16.05.1990	Th. Weis
   DATE machpolspec   : 910915
H*/

#include <_matr1.h>

pol machpolspec(M,det,minusEins,anzahlargs,arg1,arg2,arg3,arg4,arg5)
matrix M;
obj    ( *det )(), minusEins;
single anzahlargs;
obj    arg1,arg2,arg3,arg4,arg5;
{
	list   ZM, ZL;
	matrix L = _0;
	obj    a;
	pol    b, D;
	single i = 0, j = 0;

	bind( M, L, minusEins );
	bind( arg1,arg2,arg3,arg4,arg5 );

	init( ZM, ZL, b, D );

	while ( M != _0 )
	{
	   ZL = _0;
	   ZM = lfirst( M );
	   while ( ZM != _0 )
	   {
	      a = lfirst( ZM );
	      b = ( i == j++ ) ? ( ( a ) ? list4( 1, minusEins, 0, a ) : list2( 1, minusEins ) )
			        : ( ( a ) ? list2( 0, a ) : 0 );
	      ZL = lcomp( b, ZL );
	      ZM = lred( ZM );
	   }
	   i++; j = 0;
	   ZL = linv( ZL );
	   L = lcomp( ZL, L );
	   M = lred( M );
	}
	L = linv( L );
	switch ( anzahlargs )
	{
	   case 0: D = ( *det )( 1, L );          /* taucht nicht auf */
		   break;
	   case 1: D = ( *det )( arg1, L );       /* Z, Q, MS, Pi, Pr */
		   break;
	   case 2: D = ( *det )( arg1, arg2, L ); /* Pms */
		   break;
	   case 3: D = ( *det )( arg1, arg2, arg3, L );
		   break;
	   case 4: D = ( *det )( arg1, arg2, arg3, arg4, L );
		   break;
	   case 5: D = ( *det )( arg1, arg2, arg3, arg4, arg5, L );
		   break;
	}
	return( D );
}
