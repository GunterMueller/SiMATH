/*M
.SH NAME
 vecitovecpi - vector of integers to vector of polynomials over integers

.SH SYNOPSIS
.nf
#include<_matr1.h>

vec vecitovecpi(r, V)
single r;
vec V;

.SH DESCRIPTION
vecitovecpi() returns the vector V with all entries converted to
polynomials in r variables over integers.

.PP
.TP
.B V
is a vector of integers.
M*/




/*H

	Version  1      31.01.1989      U.Schneiders

   DATE vecitovecpi   : 890601
H*/
#include <_matr1.h>

vec vecitovecpi( r, V )
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
