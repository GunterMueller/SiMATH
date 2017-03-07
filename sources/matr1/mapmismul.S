/*M
.SH NAME
mapmismul - matrix of polynomials over modular integers, scalar multiplication

.SH SYNOPSIS
.nf
#include<_matr1.h>

matrix mapmismul(r, m, M, el)
single r;
int m;
matrix M;
pol el;

.SH DESCRIPTION
mapmismul() returns the matrix el*M.

.PP
.TP 4
.B M
is a matrix of polynomials in r variables over Z/mZ.
.TP 4
.B el
is a polynomial in r variables over Z/mZ.
M*/

/*H
	Version  1      31.01.1992      Bernd Mayr
   DATE mapmismul     : 920331
H*/

#include<_matr1.h>
matrix mapmismul( r, m, M, P )
single r;
int m;
matrix M;
pol P;
{
	matrix H, N;
	list Z, ZM;
	pol e;
	init( H, N, Z, ZM, e );
	bind( m, M, P );

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
			e = pmiprod( r, m, e, P );
			ZM = lcomp( e,ZM );
		}
		ZM = linv( ZM );
		N = lcomp( ZM, N );
	}
	N = linv( N );
	return( N );
}
