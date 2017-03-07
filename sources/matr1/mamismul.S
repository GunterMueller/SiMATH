/*M
.SH NAME
mamismul - matrix of modular integers, scalar multiplication

.SH SYNOPSIS
.nf
#include<_matr1.h>

matrix mamismul(m, M, el)
int m;
matrix M;
int el;

.SH DESCRIPTION
mamismul() returns the matrix el*M.

.PP
.TP 4
.B M
is a matrix over Z/mZ.
.TP 4
.B el
is an element of Z/mZ.
M*/

/*H
	Version  1      31.01.1992      Bernd Mayr
   DATE mamismul      : 920331
H*/

#include<_matr1.h>
matrix mamismul( mi, M, el )
int mi;
matrix M;
int el;
{
	matrix H, N;
	list Z, ZM;
	int e;
	init( H, N, Z, ZM, e );
	bind( mi, M, el );

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
			e = miprod( mi, e, el );
			ZM = lcomp( e,ZM );
		}
		ZM = linv( ZM );
		N = lcomp( ZM, N );
	}
	N = linv( N );
	return( N );
}
