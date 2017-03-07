/*M
.SH NAME
vecrfmsp1sm - vector of rational functions over modular single primes, transcendence degree 1, scalar multiplication

.SH SYNOPSIS
.nf
#include<_matr3.h>

vec vecrfmsp1sm(p, F, V)
single p;
rfunc F;
vec V;

.SH DESCRIPTION
vecrfmsp1sm() returns the vector F*V.

.PP
.TP 4
.B p
must be prime.
.TP 4
.B F
is a rational function in one variable over Z/pZ.
.TP 4
.B V
is vector of rational functions in one variable over Z/pZ.
M*/



/*H
	Version 1       14.06.1989      U.Schneiders, Th. Weis
   DATE vecrfmsp1sm   : 890801.9107__.9109__
H*/

#include <_matr3.h>

vec vecrfmsp1sm( p, F, V )
single p;
rfunc  F;
vec    V;

{
	vec    W;
	rfunc  G;
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
			G = rfmsp1prod( p, F, G );
			W = lcomp( G, W );
		} while ( V != _0 );
		W = linv( W );
	}

	return( W );
}


