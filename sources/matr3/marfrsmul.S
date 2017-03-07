/*M
.SH NAME
marfrsmul - matrix of rational functions over the rational numbers, scalar multiplication

.SH SYNOPSIS
.nf
#include<_matr3.h>

matrix marfrsmul(r,M,F)
single r;
matrix M;
rfunc F;

.SH DESCRIPTION
marfrsmul() returns the matrix F*M.
.PP
.TP 4
.B M
is a matrix of rational functions in r variables over the rational numbers.
.TP 4
.B F
is a rational function in r variables over the rational numbers.
M*/








/*H
	Version  1      05.06.1989      U.Schneiders, Th. Weis
   DATE marfrsmul     : 890801.9011__.9109__
H*/

#include <_matr3.h>

matrix marfrsmul( r, M, F )
single r;
matrix M;
rfunc F;

{
	matrix H, N;
	list Z, ZM;
	rfunc e;

	bind( M, F );
	init( H, N, Z, ZM, e );

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
			e = rfrprod( r, e, F );
			ZM = lcomp( e,ZM );
		}
		ZM = linv( ZM );
		N = lcomp( ZM, N );
	}
	N = linv( N );
	return( N );
}


