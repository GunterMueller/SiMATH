/*M
.SH NAME
vecpitovrfr - vector of polynomials over integers to vector of rational functions over the rational numbers

.SH SYNOPSIS
.nf
#include<_matr3.h>

vec vecpitovrfr(r, V)
single r;
vec V;

.SH DESCRIPTION
vecpitovrfr() returns the vector V with all integer entries converted
to rational functions over the rational numbers.

M*/






/*H
	Version  1      19.06.1989      U.Schneiders, Th. Weis
   DATE vecpitovrfr   : 890801.9109__
H*/

#include <_matr3.h>

vec vecpitovrfr( r, V )
single r;
vec V;

{
	pol el;
	rfunc hel;
	vec H;
	init( H, el, hel );
	bind( V );

	H = V;
	V = _0;
	while( H != _0 )
	{
		el = lfirst( H );
		H = lred( H );
		hel = pitorfr( r, el );
		V = lcomp( hel, V );
	}
	V = linv( V );
	return( V );
}


