/*M
.SH NAME
vecrfrsprod - vector of rational functions over the rational numbers, scalar product

.SH SYNOPSIS
.nf
#include<_matr3.h>

rfunc vecrfrsprod(r, U, V)
single r;
vec U,V;

.SH DESCRIPTION
vecrfrsprod() returns the scalar product U*V.
.PP
.TP 4
.B U,V
are vectors of rational functions in r variables over the rational numbers.
U and V must have equal length.
M*/








/*H
	Version 1       14.06.1989      U.Schneiders, Th. Weis
   DATE vecrfrsprod   : 890801.9011__.9109__
H*/

#include <_matr3.h>

rfunc vecrfrsprod( r, V, W )
single r;
vec V, W;

{
	rfunc F = 0, Fv, Fw;

	bind( V, W, F );
	init( Fv, Fw );

	do {
		Fv = lfirst( V );
		Fw = lfirst( W );
		Fv = rfrprod( r, Fv, Fw );
		F =  rfrsum( r, Fv, F );
		V = lred( V );
		W = lred( W );
	} while (V != _0);

	return( F );
}


