/*M
.SH NAME
vecrsprod - vector of rational numbers, scalar product

.SH SYNOPSIS
.nf
#include<_matr1.h>

rat vecrsprod(U, V)
vec U, V;

.SH DESCRIPTION
vecrsprod() returns the scalar product U*V.

.PP
.TP 4
.B U, V
are vectors of rational numbers.
U and V must have equal length.
M*/



/*H
	Version 1       29.03.1989      U.Schneiders
   DATE vecrsprod     : 890601
H*/

# include <_matr1.h>

rat vecrsprod( V, W )
vec V,W;

{
	rat s = 0, v, w;

	bind( V, W, s );
	init( v, w );

	do {
		v=lfirst(V);
		w=lfirst(W);
		v = rprod( v, w );
		s = rsum( v, s );
		V = lred (V);
		W = lred (W);
	} while (V != _0);

	return( s );
}
