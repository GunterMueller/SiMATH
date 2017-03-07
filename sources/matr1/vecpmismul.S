/*M
.SH NAME
vecpmismul - vector of polynomials over modular integers, scalar multiplication

.SH SYNOPSIS
.nf
#include<_matr1.h>

vec vecpmismul(r, m, el, V)
single r;
int m;
pol el;
vec V;

.SH DESCRIPTION
vecpmismul() returns the vector el*V.

.PP
.TP 4
.B V
is a vector of polynomials in r variables over Z/mZ.
.TP 4
.B el
is a polynomial in r variables over Z/mZ.
M*/





/*H
	Version 1       31.01.1992      Bernd Mayr
   DATE vecpmismul    : 920331
H*/

#include <_matr1.h>

vec vecpmismul( r, m, P, V )
single r;
int m;
pol P;
vec V;

{
	vec W;
	pol Q;
	int n;

	bind( P, V, m );
	init( Q, W, n );

	/***    P gleich 0      ***/
	if( !P )
	{       n = llength( V );
		W = _0;
		while( n-- ) W = lcomp( 0, W );
	}

	/***    Anzahl der Variablen gleich 0   ***/
	else if( !r )
		W = vecmismul( m, P, V );

	/***    allgemeiner Fall        ***/
	else
	{       W = _0;
		do
		{       Q = lfirst( V );
			V = lred( V );
			Q = pmiprod( r, m, P, Q );
			W = lcomp( Q, W );
		} while ( V != _0 );
		W = linv( W );
	}

	return( W );
}
