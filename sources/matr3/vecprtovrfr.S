/*M
.SH NAME
vecprtovrfr - vector of polynomials over the rational numbers to vector over rational  functions over the rational numbers

.SH SYNOPSIS
.nf
#include<_matr3.h>

vec vecprtovrfr(r, V)
single r;
vec V;

.SH DESCRIPTION
vecprtovrfr() returns the vector V with all entries converted
to rational functions over the rational numbers.
M*/





/*H
	Version  1      19.06.1989      U.Schneiders, Th. Weis
   DATE vecprtovrfr   : 890801.9109__
H*/

#include <_matr3.h>

vec vecprtovrfr( r, V )
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
		hel = prtorfr( r, el );
		V = lcomp( hel, V );
	}
	V = linv( V );
	return( V );
}


