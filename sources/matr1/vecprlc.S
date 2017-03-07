/*M
.SH NAME
vecprlc - vector of polynomials over the rational numbers, linear combination

.SH SYNOPSIS
.nf
#include<_matr1.h>

vec vecprlc(r, s1, s2, V1, V2)
single r;
pol s1, s2;
vec V1, V2;

.SH DESCRIPTION
vecprlc() returns the linear combination (s1*V1)+(s2*V2).

.PP
.TP 4
.B s1,s2
are polynomials in r variables over the rational numbers..
.TP 4
.B V1,V2
are vectors of polynomials in r variables over the rational numbers.
V1 and V2 must have equal length.
M*/
/*H
	Version 1       29.03.1989      U.Schneiders
   DATE vecprlc       : 890601
H*/

#include <_matr1.h>

vec vecprlc( r, P1, P2, V1, V2 )
single r;
pol P1, P2;
vec V1, V2;

{
	bind( P1, P2, V1, V2 );

	V1 = vecprsmul( r, P1, V1 );
	V2 = vecprsmul( r, P2, V2 );
	V1 = vecprsum( r, V1, V2 );

	return( V1 );
}
