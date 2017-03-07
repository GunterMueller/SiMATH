/*M
.SH NAME
vecpisprod - vector of polynomials over integers, scalar product

.SH SYNOPSIS
.nf
#include<_matr1.h>

pol vecpisprod(r, U, V)
single r;
vec U, V;

.SH DESCRIPTION
vecpisprod() returns the scalar product U*V.

.PP
.TP 4
.B U, V
are vectors of polynomials in r variables over integers.
U and V must have equal length.
M*/


/*H
	Version 1       29.03.1989      U.Schneiders
   DATE vecpisprod    : 890601
H*/

# include <_matr1.h>

pol vecpisprod( r, V, W )
single r;
vec V, W;

{
	pol P = 0, Pv, Pw;

	bind( V, W, P );
	init( Pv, Pw );

	do {
		Pv = lfirst( V );
		Pw = lfirst( W );
		Pv = piprod( r, Pv, Pw );
		P =  pisum( r, Pv, P );
		V = lred( V );
		W = lred( W );
	} while (V != _0);

	return( P );
}
