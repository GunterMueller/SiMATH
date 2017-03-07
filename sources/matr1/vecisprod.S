/*M
.SH NAME
vecisprod - vector of integers, scalar product

.SH SYNOPSIS
.nf
#include<_matr1.h>

int vecisprod(U, V)
vec U, V;

.SH DESCRIPTION
vecisprod() returns the scalar product U*V.

.PP
.TP 4
.B U, V
are vectors of integers. 
U and V must have equal length.
M*/


/*H
	Version 1       23.08.1988      Klaus Petry (analog vecmssprod)
	Version 1.2.    29.03.1989      U.Schneiders ( Dok. fertig, vec )
   DATE vecisprod     : 890601
H*/

# include <_matr1.h>

int vecisprod( V, W )
vec V,W;

{
	int s = 0, v, w;

	bind( V, W, s );
	init( v, w );

	do {
		v=lfirst(V);
		w=lfirst(W);
		s = isum( iprod(v,w), s );
		V = lred (V);
		W = lred (W);
	} while (V != _0);

	return( s );
}
