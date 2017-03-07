/*M
.SH NAME
vecpmisprod - vector of polynomials over modular integers, scalar product

.SH SYNOPSIS
.nf
#include<_matr1.h>

pol vecpmisprod(r, m, U, V)
single r;
int m;
vec U, V;

.SH DESCRIPTION
vecpmisprod() returns the scalar product U*V.

.PP
.TP 4
.B U, V
are vectors of polynomials in r variables over Z/mZ.
U and V must have equal length.
M*/



/*H
	Version 1       31.01.1992      Bernd Mayr
   DATE vecpmisprod   : 920331
H*/

# include <_matr1.h>

pol vecpmisprod( r, m, V, W )
single r;
int m;
vec V, W;

{
	pol P = 0, Pv, Pw;

	bind( m, V, W, P );
	init( Pv, Pw );

	do {
		Pv = lfirst( V );
		Pw = lfirst( W );
		Pv = pmiprod( r, m, Pv, Pw );
		P =  pmisum( r, m, Pv, P );
		V = lred( V );
		W = lred( W );
	} while (V != _0);

	return( P );
}
