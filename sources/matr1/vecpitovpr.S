/*M
.SH NAME
vecpitovpr - vector of polynomials over integers to vector of polynomials over the rational numbers

.SH SYNOPSIS
.nf
#include<_matr1.h>

vec vecpitovpr(r, V)
single r;
vec V;

.SH DESCRIPTION
vecpitovpr() returns the vector V with all entries converted to
polynomials in r variables over the rational numbers.

.PP
.TP 4
.B V
is a vector of polynomials in r variables over integers.
M*/



/*H
	Version  1      31.01.1989      U.Schneiders
	Version  2      23.08.1989      Th. Weis: Funktionsname verkuerzt:
						  "vecpitovecpr" zu "vecpitovpr".
   DATE vecpitovpr  : 890601.891101.9011__
H*/

#include <_matr1.h>

vec vecpitovpr( r, V )
single r;
vec V;

{
	pol el;
	vec H;
	init( H, el );
	bind( V );

	H = V;
	V = _0;
	while( H != _0 )
	{
		el = lfirst( H );
		H = lred( H );
		el = pitopr( r, el );
		V = lcomp( el, V );
	}
	V = linv( V );
	return( V );
}
