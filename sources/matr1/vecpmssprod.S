/*M
.SH NAME
vecpmssprod - vector of polynomials over modular singles, scalar product

.SH SYNOPSIS
.nf
#include<_matr1.h>

pol vecpmssprod(r, m, U, V)
single r, m;
vec U, V;

.SH DESCRIPTION
vecpmssprod() returns the scalar product U*V.

.PP
.TP 4
.B U, V
are vectors of polynomials in r variables over Z/mZ.
U and V must have equal length.
M*/


/*H
	Version 1       29.03.1989      U.Schneiders
   DATE vecpmssprod   : 890601.9203__
H*/

# include <_matr1.h>

pol vecpmssprod( r, m, V, W )
single r, m;
vec V, W;

{
	pol P = 0, Pv, Pw;

	bind( V, W, P );
	init( Pv, Pw );

	do {
		Pv = lfirst( V );
		Pw = lfirst( W );
		Pv = pmsprod( r, m, Pv, Pw );
		P =  pmssum( r, m, Pv, P );
		V = lred( V );
		W = lred( W );
	} while (V != _0);

	return( P );
}
