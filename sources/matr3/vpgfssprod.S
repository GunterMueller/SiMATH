/*M
.SH NAME
vpgfssprod - vector of polynomials over Galois-field with single characteristic, scalar product

.SH SYNOPSIS
.nf
#include<_matr3.h>

pol vpgfssprod(r, p, AL, U, V)
single r,p;
list AL;
vec U,V;

.SH DESCRIPTION
vpgfssprod() returns the scalar product U*V.

.PP
.TP 4
.B p
must be prime.
.TP 4
.B AL
= (G,AL1) is the arithmetic list of GF(p^n), see gfsalgen().
.TP 4
.B U,V
are vectors of polynomials in r variables over GF(p^n).
U and V must have equal length.
M*/








/*H
	Version 1       12.04.1990      Th. Weis
   DATE vpgfssprod    : 910915
H*/

#include <_matr3.h>

pol vpgfssprod( r, p, AL, V, W )
single r, p;
list   AL;
vec    V, W;

{
	pol s, v, w;

	bind( AL, V, W );
	init( s, v, w );

	s = 0;
	while ( V != _0 )
	{
	   v = lfirst( V ), V = lred( V );
	   w = lfirst( W ), W = lred( W );
	   s = pgfssum( r, p, AL, pgfsprod( r, p, AL, v, w ), s );
	}
	return( s );
}


