/*M
.SH NAME
vecprsmul - vector of polynomials over the rational numbers, scalar multiplication

.SH SYNOPSIS
.nf
#include<_matr1.h>

vec vecprsmul(r, el, V);
single r;
pol el;
vec V;

.SH DESCRIPTION
vecprsmul() returns the vector el*V.

.PP
.TP 4
.B V
is a vector of polynomials in r variables over the rational numbers.
.TP 4
.B el
is a polynomial in r variables over the rational numbers.
M*/





/*H
	Version 1       29.03.1989      U.Schneiders
   DATE vecprsmul     : 890601
H*/

#include <_matr1.h>

vec vecprsmul( r, P, V )
single r;
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
		W = vecrsmul( P, V );

	/***    allgemeiner Fall        ***/
	else
	{       W = _0;
		do
		{       Q = lfirst( V );
			V = lred( V );
			Q = prprod( r, P, Q );
			W = lcomp( Q, W );
		} while ( V != _0 );
		W = linv( W );
	}

	return( W );
}
