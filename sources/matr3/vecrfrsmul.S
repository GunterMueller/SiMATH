/*M
.SH NAME
vecrfrsmul - vector of rational functions over the rational numbers, scalar multiplication

.SH SYNOPSIS
.nf
#include<_matr3.h>

vec vecrfrsmul(r, F, V)
single r;
rfunc F;
vec V;

.SH DESCRIPTION
vecrfrsmul() returns the vector F*V.

.PP
.TP 4
.B F
is a rational function in r variables over the rational numbers.
.TP 4
.B V
is a vector of rational functions in r variables over the rational numbers.
M*/









/*H
	Version 1       14.06.1989      U.Schneiders, Th. Weis
   DATE vecrfrsmul    : 890801.9109__
H*/

#include <_matr3.h>

vec vecrfrsmul( r, F, V )
single r;
rfunc F;
vec V;

{
	vec W;
	rfunc G;
	single n;

	bind( F, V );
	init( G, W );

	/***    F gleich 0      ***/
	if( !F )
	{       n = llength( V );
		W = _0;
		while( n-- ) W = lcomp( 0, W );
	}

	/***    allgemeiner Fall        ***/
	else
	{       W = _0;
		do
		{       G = lfirst( V );
			V = lred( V );
			G = rfrprod( r, F, G );
			W = lcomp( G, W );
		} while ( V != _0 );
		W = linv( W );
	}

	return( W );
}


