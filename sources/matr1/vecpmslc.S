/*M
.SH NAME
vecpmslc - vector of polynomials over modular singles, linear combination

.SH SYNOPSIS
.nf
#include<_matr1.h>

vec vecpmslc(r, m, s1, s2, V1, V2)
single r, m;
pol s1, s2;
vec V1, V2;

.SH DESCRIPTION
vecpmslc() returns the linear combination (s1*V1)+(s2*V2).

.PP
.TP 4
.B s1,s2
are polynomials in r variables over Z/mZ.
.TP 4
.B V1,V2
are vectors polynomials in r variables over Z/mZ.
V1 and V2 must have equal length.
M*/
/*H
	Version 1       29.03.1989      U.Schneiders
   DATE vecpmslc      : 890601.9203__
H*/

#include <_matr1.h>

vec vecpmslc( r, m, P1, P2, V1, V2 )
single r, m;
pol P1, P2;
vec V1, V2;

{
	bind( P1, P2, V1, V2 );

	V1 = vecpmssmul( r, m, P1, V1 );
	V2 = vecpmssmul( r, m, P2, V2 );
	V1 = vecpmssum( r, m, V1, V2 );

	return( V1 );
}
