/*M
.SH NAME
maconc - matrix concatenation

.SH SYNOPSIS
.nf
#include<_matr1.h>

matrix maconc(M, N)
matrix M, N;

.SH DESCRIPTION
maconc() returns the mx(n+l) matrix obtained by
concatenating the rows of the matrices M and N.

.PP
.TP 4
.B M
is a mxn matrix.
.TP 4
.B N
is a mxl matrix.

.SH CAUTION
M will be changed.
M*/
/*H
	Version 1       25.02.1992      U.Schneiders
   DATE maconc        : 920331
H*/

#include <_matr1.h>

matrix maconc( M, N )
matrix M, N;
{
	list L, Lm, Ln;
	init( L, Lm, Ln );
	bind( M, N );

	L = _0;
	while( M != _0 )
	{       Lm = lfirst( M );
		Ln = lfirst( N );
		M = lred( M );
		N = lred( N );
		Lm = lconc( Lm, Ln );
		L = lcomp( Lm, L );
	}
	L = linv( L );
	return( L );
}
