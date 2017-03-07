/*M
.SH NAME
vecitovecms - vector of integers to vector of modular singles

.SH SYNOPSIS
.nf
#include<_matr1.h>

vec vecitovecms(m, V)
single m;
vec V;

.SH DESCRIPTION
vecitovecms() returns the vector V with all entries converted to
elements of Z/mZ.

.PP
.TP
.B V
is a vector of integers.
M*/



/*H

	Version  1      20.06.1989      U.Schneiders, Th. Weis

   DATE vecitovecms   : 890801
H*/
#include <_matr1.h>

vec vecitovecms( m, V )
single m;
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
		el = mshom( m, el );
		V = lcomp( el, V );
	}
	V = linv( V );
	return( V );
}
