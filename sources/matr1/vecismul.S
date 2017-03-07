/*M
.SH NAME
vecismul - vector of integers, scalar multiplication

.SH SYNOPSIS
.nf
#include<_matr1.h>

vec vecismul(el, V);
int el;
vec V;

.SH DESCRIPTION
vecismul() returns the vector el*V.

.PP
.TP 4
.B V
is a vector of integers.
.TP 4
.B el
is an integer.
M*/




/*H
	Version 1       23.08.1988      Klaus Petry
	Version 1.2.    29.03.1989      U.Schneiders ( Dok., prod->mul )
   DATE vecismul      : 890601
H*/

# include <_matr1.h>

vec vecismul( s, V )
int s;
vec V;

{
	vec W;
	int c;
	single n;

	bind( s, V );
	init( c, W );

	switch ( s ) {
		case 0: n = llength( V );
			W = _0;
			while( n-- ) W = lcomp( 0, W );
			break;
		case 1: W = V;
			break;
		case -1: W = vecineg( V );
			break;
		default:        W = _0;
				do {
					c = lfirst( V );
					V = lred( V );
					c = iprod( s, c );
					W = lcomp( c, W );
				} while ( V != _0 );
				W = linv( W );
				break;
		}
	return( W );
}
