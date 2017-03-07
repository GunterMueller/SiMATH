/*M
.SH NAME
vecpmssmul - vector of polynomials over modular singles, scalar multiplication

.SH SYNOPSIS
.nf
#include<_matr1.h>

vec vecpmssmul(r, m, el, V)
single r, m;
pol el;
vec V;

.SH DESCRIPTION
vecpmssmul() returns the vector el*V.

.PP
.TP 4
.B V
is a vector of polynomials in r variables over Z/mZ.
.TP 4
.B el
is a polynomial in r variables over Z/mZ.
M*/






/*H
	Version 1       29.03.1989      U.Schneiders
   DATE vecpmssmul    : 890601.9203__
H*/

#include <_matr1.h>

vec vecpmssmul( r, m, P, V )
single r, m;
pol P;
vec V;

{
	vec W;
	pol Q;
	single n;

	bind( P, V );
	init( Q, W );

	/***    P gleich 0      ***/
	if( !P )
	{       n = llength( V );
		W = _0;
		while( n-- ) W = lcomp( 0, W );
	}

	/***    Anzahl der Variablen gleich 0   ***/
	else if( !r )
		W = vecmssmul( m, P, V );

	/***    allgemeiner Fall        ***/
	else
	{       W = _0;
		do
		{       Q = lfirst( V );
			V = lred( V );
			Q = pmsprod( r, m, P, Q );
			W = lcomp( Q, W );
		} while ( V != _0 );
		W = linv( W );
	}

	return( W );
}
