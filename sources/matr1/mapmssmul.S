/*M
.SH NAME
mapmssmul - matrix of polynomials over modular singles, scalar multiplication

.SH SYNOPSIS
.nf
#include<_matr1.h>

matrix mapmssmul(r, m, M, el)
single r;
single m;
matrix M;
pol el;

.SH DESCRIPTION
mapmssmul() returns the matrix el*M.

.PP
.TP 4
.B M
is a matrix of polynomials in r variables over Z/mZ.
.TP 4
.B el
is a polynomial in r variables over Z/mZ.
M*/

/*H
	Version  1      22.06.1989      U.Schneiders, Th. Weis
   DATE mapmssmul     : 890801.9203__
H*/

#include<_matr1.h>
matrix mapmssmul( r, m, M, P )
single r;
single m;
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
			e = pmsprod( r, m, e, P );
			ZM = lcomp( e,ZM );
		}
		ZM = linv( ZM );
		N = lcomp( ZM, N );
	}
	N = linv( N );
	return( N );
}
