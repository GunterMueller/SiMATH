/*M
.SH NAME
vecitovecr - vector of integers to vector of rational numbers

.SH SYNOPSIS
.nf
#include<_matr1.h>

vec vecitovecr(V);
vec V;

.SH DESCRIPTION
vecitovecr() returns the vector V with all entries converted to
rational numbers.

.PP
.TP
.B V
is a vector of integers.
M*/




/*H

	Version  1      31.01.1989      U.Schneiders

   DATE vecitovecr    : 890601
H*/
#include <_matr1.h>

vec vecitovecr( V )
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
		el = itor( el );
		V = lcomp( el, V );
	}
	V = linv( V );
	return( V );
}
