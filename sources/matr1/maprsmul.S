/*M
.SH NAME
maprsmul - matrix of polynomials over the rational numbers, scalar multiplication

.SH SYNOPSIS
.nf
#include<_matr1.h>

matrix maprsmul(r, M, el)
single r;
matrix M;
pol el;

.SH DESCRIPTION
maprsmul() returns the matrix el*M.

.PP
.TP 4
.B M
is a matrix of polynomials in r variables over the rational numbers.
.TP 4
.B el
is a polynomial in r variables over the rational numbers.
M*/

/*H
	Version  1      10.01.1989      C.Hollinger/U.Schneiders
   DATE maprsmul      : 890801.9311__
H*/

#include<_matr1.h>

matrix maprsmul( r, M, P )
single r;
matrix M;
pol P;
{
	matrix H, N;
	list Z, ZM;
	pol e;
	init( H, N, Z, ZM, e );
	bind( M, P );

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
			e = prprod( r, e, P );
			ZM = lcomp( e,ZM );
		}
		ZM = linv( ZM );
		N = lcomp( ZM, N );
	}
	N = linv( N );
	return( N );
}
