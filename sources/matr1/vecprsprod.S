/*M
.SH NAME
vecprsprod - vector of polynomials over the rational numbers, scalar product

.SH SYNOPSIS
.nf
#include<_matr1.h>

pol vecprsprod(r, U, V)
single r;
vec U, V;

.SH DESCRIPTION
vecprsprod() returns the scalar product U*V.

.PP
.TP 4
.B U, V
are vectors of polynomials in r variables over the rational numbers.
U and V must have equal length.
M*/




/*H
	Version 1       29.03.1989      U.Schneiders
   DATE vecprsprod    : 890601
H*/

# include <_matr1.h>

pol vecprsprod( r, V, W )
single r;
vec V, W;

{
	pol P = 0, Pv, Pw;

	bind( V, W, P );
	init( Pv, Pw );

	do {
		Pv = lfirst( V );
		Pw = lfirst( W );
		Pv = prprod( r, Pv, Pw );
		P =  prsum( r, Pv, P );
		V = lred( V );
		W = lred( W );
	} while (V != _0);

	return( P );
}
