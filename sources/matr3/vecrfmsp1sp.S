/*M
.SH NAME
vecrfmsp1sp - vector of rational functions over modular single primes, transcendence degree 1, scalar product

.SH SYNOPSIS
.nf
#include<_matr3.h>

rfunc vecrfmsp1sp(p, V, W)
single p;
vec V,W;

.SH DESCRIPTION
vecrfmsp1sp() returns the scalar product <V,W>
which is a rational function in one variable over Z/pZ.

.PP
.TP 4
.B p
must be prime.
.TP 4
.B V,W
are vectors rational functions in one variable over Z/pZ.
V and M must have equal length.
M*/






/*H
	Version 1       14.06.1989      U.Schneiders, Th. Weis
   DATE vecrfmsp1sp   : 890801.9109__
H*/

# include <_matr3.h>

rfunc vecrfmsp1sp( p, V, W )
single p;
vec V, W;

{
	rfunc F = 0, Fv, Fw;

	bind( V, W, F );
	init( Fv, Fw );

	do {
		Fv = lfirst( V );
		Fw = lfirst( W );
		Fv = rfmsp1prod( p, Fv, Fw );
		F =  rfmsp1sum( p, Fv, F );
		V = lred( V );
		W = lred( W );
	} while (V != _0);

	return( F );
}


