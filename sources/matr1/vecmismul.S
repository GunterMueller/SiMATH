/*M
.SH NAME
vecmismul - vector of modular integers, scalar multiplication

.SH SYNOPSIS
.nf
#include<_matr1.h>

vec vecmismul(m, el, V)
int m, el;
vec V;

.SH DESCRIPTION
vecmismul() returns the vector el*V.

.PP
.TP 4
.B V
is a vector over Z/mZ.
.TP 4
.B el
is an element of Z/mZ.
M*/




/*H
	Version 1       31.01.1992      Bernd Mayr
   DATE vecmismul     : 920331
H*/

# include <_matr1.h>

vec vecmismul( m, s, V )
int m, s;
vec V;

{
	vec W;
        int n, c;

	bind( m, s, V );
	init( W, n, c );


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
					c = miprod( m, s, c );
					W = lcomp( c, W );
				} while ( V != _0 );
				W = linv( W );
				break;
		}
	return( W );
}
