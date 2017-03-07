/*M
.SH NAME
vecmssmul - vector of modular singles, scalar multiplication

.SH SYNOPSIS
.nf
#include<_matr1.h>

vec vecmssmul(m, el, V)
single m, el;
vec V;

.SH DESCRIPTION
vecmssmul() returns the vector el*V.

.PP
.TP 4
.B V
is a vector over Z/mZ.
.TP 4
.B el
is an element of Z/mZ.
M*/








/*H
	Version 1       29.03.1989      U.Schneiders
   DATE vecmssmul     : 890601.9203__
H*/

# include <_matr1.h>

vec vecmssmul( m, s, V )
single m, s;
vec V;

{
	vec W;
	single c, n;

	bind( V );
	init( W );


	switch ( s ) {
		case 0: n = llength( V );
			W = _0;
			while( n-- ) W = lcomp( 0, W );
			break;
		case 1: W = V;
			break;
		default:        W = _0;
				do {
					c = lfirst( V );
					V = lred( V );
					c = msprod( m, s, c );
					W = lcomp( c, W );
				} while ( V != _0 );
				W = linv( W );
				break;
		}
	return( W );
}
