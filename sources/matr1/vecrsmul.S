/*M
.SH NAME
vecrsmul - vector of rational numbers, scalar multiplication

.SH SYNOPSIS
.nf
#include<_matr1.h>

vec vecrsmul(el, V);
rat el;
vec V;

.SH DESCRIPTION
vecrsmul() returns the vector el*V.

.PP
.TP 4
.B V
is a vector over the rational numbers.
.TP 4
.B el
is a rational number.
M*/





/*H
	Version 1       29.03.1989      U.Schneiders
   DATE vecrsmul      : 890601
H*/

# include <_matr1.h>

vec vecrsmul( s, V )
rat s;
vec V;

{
	vec W;
	rat c;
	single n;

	bind( s, V );
	init( c, W );

	/***    s gleich 0      ***/
	if( !s )
	{       n = llength( V );
		W = _0;
		while( n-- ) W = lcomp( 0, W );
	}

	/***    s gleich 1      ***/
	else if( lfirst( s ) == 1 && lsecond( s ) == 1 )
		W = V;

	 /***   s gleich -1     ***/
	else if( lfirst( s ) == -1 && lsecond( s ) == 1 )
		W = vecrneg( V );

	/***    allgemeiner Fall        ***/
	else
	{       W = _0;
		do
		{       c = lfirst( V );
			V = lred( V );
			c = rprod( s, c );
			W = lcomp( c, W );
		} while ( V != _0 );
		W = linv( W );
	}

	return( W );
}
