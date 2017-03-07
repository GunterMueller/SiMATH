/*M
.SH NAME
marfmsp1smul - matrix of rational functions over modular single primes, transcendence degree 1, scalar multiplication

.SH SYNOPSIS
.nf
#include<_matr3.h>

matrix marfmsp1smul(p, M, F)
single p;
matrix M;
rfunc F;

.SH DESCRIPTION
marfmsp1smul() returns the matrix F*M.
.PP
.TP 4
.B p
must be prime.
.TP 4
.B M
is a matrix of rational functions in one variable over Z/pZ.
.TP 4
.B F
is a rational function in one variable over Z/pZ.
M*/









/*H
	Version  1      05.06.1989      U.Schneiders, Th. Weis
   DATE marfmsp1smul  : 890801.9109__
H*/

#include<_matr3.h>
matrix marfmsp1smul( p, M, F )
single p;
matrix M;
rfunc F;
{
	matrix H, N;
	list Z, ZM;
	rfunc e;
	init( H, N, Z, ZM, e );
	bind( M, F );

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
			e = rfmsp1prod( p, e, F );
			ZM = lcomp( e,ZM );
		}
		ZM = linv( ZM );
		N = lcomp( ZM, N );
	}
	N = linv( N );
	return( N );
}


