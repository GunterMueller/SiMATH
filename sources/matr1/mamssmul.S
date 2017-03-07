/*M
.SH NAME
mamssmul - matrix of modular singles, scalar multiplication

.SH SYNOPSIS
.nf
#include<_matr1.h>

matrix mamssmul(m, M, el)
single m;
matrix M;
int el;

.SH DESCRIPTION
mamssmul() returns the matrix el*M.

.PP
.TP 4
.B M
is a matrix over Z/mZ.
.TP 4
.B el
is an element of Z/mZ.
M*/

/*H
	Version  1      22.06.1989      U.Schneiders, Th. Weis
   DATE mamssmul      : 890801.9203__
H*/

#include<_matr1.h>
matrix mamssmul( m, M, el )
single m;
matrix M;
int el;
{
	matrix H, N;
	list Z, ZM;
	int e;
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
			e = msprod( m, e, el );
			ZM = lcomp( e,ZM );
		}
		ZM = linv( ZM );
		N = lcomp( ZM, N );
	}
	N = linv( N );
	return( N );
}
