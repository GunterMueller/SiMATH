/*M
.SH NAME
vecrtovecpr - vector of rational numbers to vector of polynomials over the rational numbers

.SH SYNOPSIS
.nf
#include<_matr1.h>

vec vecrtovecpr(r, V)
single r;
vec V;

.SH DESCRIPTION
vecrtovecpr() the vector V with all entries converted to
polynomials over the rational numbers.

.PP
.TP
.B V
is a vector of rational numbers.
M*/










/*H

	Version  1      31.01.1989      U.Schneiders
   DATE vecrtovecpr   : 890601
H*/
#include <_matr1.h>

vec vecrtovecpr( r, V )
single r;
vec V;

{
	obj el;
	vec H;
	init( H, el );
	bind( V );

	H = V;
	V = _0;
	while( H != _0 )
	{
		el = lfirst( H );
		H = lred( H );
		el = pvinsert( 0, el, r );
		V = lcomp( el, V );
	}
	V = linv( V );
	return( V );
}
