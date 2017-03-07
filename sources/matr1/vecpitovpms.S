/*M
.SH NAME
vecpitovpms - vector of polynomials over integers to vector of polynomials over modular singles

.SH SYNOPSIS
.nf
#include<_matr1.h>

vec vecpitovpms(r, V, m)
single r;
vec V;
single m;

.SH DESCRIPTION
vecpitovpms() returns he vector V with all entries converted to
polynomials in r variables over Z/mZ.

.PP
.TP 4
.B V
is a vector of polynomials in r variables over integers.
M*/



/*H
	Version  1      20.06.1989      U.Schneiders, Th. Weis
   DATE vecpitovpms   : 890801.9011__
H*/

#include <_matr1.h>

vec vecpitovpms( r, V, m )
single r;
vec V;
single m;

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
		el = pitopms( r, el, m );
		V = lcomp( el, V );
	}
	V = linv( V );
	return( V );
}
