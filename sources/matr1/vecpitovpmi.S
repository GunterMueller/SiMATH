/*M
.SH NAME
vecpitovpmi - vector of polynomials over integers to vector of polynomials over modular integers

.SH SYNOPSIS
.nf
#include<_matr1.h>

vec vecpitovpmi(r, V, m)
single r;
vec V;
int m;

.SH DESCRIPTION
vecpitovpmi() returns the vector V with all entries converted to
polynomials in r variables over Z/mZ.

.PP
.TP 4
.B V
is a vector of polynomials in r variables over integers.
M*/




/*H
	Version  1      25.10.1989      U.Schneiders/C.Hollinger
   DATE vecpitovpmi   : 891101.9011__.9311__
H*/

#include <_matr1.h>

vec vecpitovpmi( r, V, m )
single r;
vec V;
int m;

{
	pol el;
	vec H;
	init( H, el );
	bind( V,m );

	H = V;
	V = _0;
	while( H != _0 )
	{       el = lfirst( H );
		H = lred( H );
		el = pitopmi( r, el, m );
		V = lcomp( el, V );
	}
	V = linv( V );
	return( V );
}
