/*M
.SH NAME
vpmstvrfmsp1 - vector of polynomials over modular singles to vector of rational functions over modular single primes, transcendence degree 1

.SH SYNOPSIS
.nf
#include<_matr3.h>

vec vpmstvrfmsp1(p, V)
single p;
vec V;

.SH DESCRIPTION
vpmstvrfmsp1() returns the vector V of polynomials in one variable over Z/pZ
with all entries converted to rational functions in one variable over Z/pZ.
M*/






/*H
	Version  1      19.06.1989      U.Schneiders, Th. Weis
   DATE vpmstvrfmsp1  : 890801.9107__.9109__
H*/

#include <_matr3.h>

vec vpmstvrfmsp1( p, V )
single p;
vec    V;

{
	pol   el;
	rfunc hel;
	vec   H;

	init( H, el, hel );
	bind( V );

	H = V;
	V = _0;
	while( H != _0 )
	{
	   el = lfirst( H );
	   H = lred( H );
	   hel = pmstorfmsp1( p, el );
	   V = lcomp( hel, V );
	}
	V = linv( V );

	return( V );
}


