/*M
.SH NAME
macconc - matrix constructive concatenation

.SH SYNOPSIS
.nf
#include<_matr1.h>

matrix macconc(M, N)
matrix M, N;

.SH DESCRIPTION
macconc() returns the mx(n+l) matrix obtained by
concatenating the rows of the matrices M and N.
M and N remain unchanged.

.PP
.TP 4
.B M
is a mxn matrix.
.TP 4
.B N
is a mxl matrix.
M*/
/*H
	Version 1       25.02.1992      U.Schneiders
   DATE macconc       : 920331
H*/

#include <_matr1.h>

matrix macconc( M, N )
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
		Lm = lcconc( Lm, Ln );
		L = lcomp( Lm, L );
	}
	L = linv( L );
	return( L );
}
