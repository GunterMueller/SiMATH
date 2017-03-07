/*M
.SH NAME
vecpismul - vector of polynomials over integers, scalar multiplication

.SH SYNOPSIS
.nf
#include<_matr1.h>

vec vecpismul(r, el, V);
single r;
pol el;
vec V;

.SH DESCRIPTION
vecpismul() returns the vector el*V.

.PP
.TP 4
.B V
is a vector of polynomials in r variables over integers.
.TP 4
.B el
is a polynomial in r variables over integers.
M*/




/*H
	Version 1       29.03.1989      U.Schneiders
   DATE vecpismul     : 890601
H*/

#include <_matr1.h>

vec vecpismul( r, P, V )
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
		W = vecismul( P, V );

	/***    allgemeiner Fall        ***/
	else
	{       W = _0;
		do
		{       Q = lfirst( V );
			V = lred( V );
			Q = piprod( r, P, Q );
			W = lcomp( Q, W );
		} while ( V != _0 );
		W = linv( W );
	}

	return( W );
}
