/*M
.SH NAME
marsmul - matrix of rational numbers, scalar multiplication

.SH SYNOPSIS
.nf
#include<_matr1.h>

matrix marsmul(M, el)
matrix M;
rat el;

.SH DESCRIPTION
marsmul() returns the matrix el*M.

.PP
.TP 4
.B M
is a matrix over the rational numbers.
.TP 4
.B el
is a rational number.
M*/
/*H
	Version  1      10.01.1989      C.Hollinger/U.Schneiders
   DATE marsmul       : 890801.9311__
H*/

#include<_matr1.h>

matrix marsmul( M, el )
matrix M;
rat el;
{
	matrix H, N;
	list Z, ZM;
	rat e;
	init( H, N, Z, ZM, e );
	bind( M, el );

	/*** Elementweise Multiplikation. ***/

	H = macopy( M );
	N = _0;
	while( H != _0 )
	{       Z = lfirst( H );
		H = lred( H );
		ZM = _0;
		while( Z != _0 )
		{       e = lfirst( Z );
			Z = lred( Z );
			e = rprod( e, el );
			ZM = lcomp( e,ZM );
		}
		ZM = linv( ZM );
		N = lcomp( ZM, N );
	}
	N = linv( N );
	return( N );
}
