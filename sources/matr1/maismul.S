/*M
.SH NAME
maismul - matrix of integers, scalar multiplication

.SH SYNOPSIS
.nf
#include<_matr1.h>

matrix maismul(M, el)
matrix M;
int el;

.SH DESCRIPTION
maismul() returns the matrix el*M.

.PP
.TP 4
.B M
is a matrix of integers.
.TP 4
.B el
is an integer.
M*/


/*H
	Version  1      10.01.1989      C.Hollinger/U.Schneiders
   DATE maismul       : 890801.9311__
H*/

#include<_matr1.h>

matrix maismul( M, el )
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
			e = iprod( e, el );
			ZM = lcomp( e,ZM );
		}
		ZM = linv( ZM );
		N = lcomp( ZM, N );
	}
	N = linv( N );
	return( N );
}
