/*M
.SH NAME
vecpmilc - vector of polynomials over modular integers, linear combination

.SH SYNOPSIS
.nf
#include<_matr1.h>

vec vecpmilc(r, m, s1, s2, V1, V2)
single r;
int m;
pol s1, s2;
vec V1, V2;

.SH DESCRIPTION
vecpmilc() returns the linear combination (s1*V1)+(s2*V2).

.PP
.TP 4
.B s1,s2
are polynomials in r variables over Z/mZ.
.TP 4
.B V1,V2
are vectors of polynomials in r variables over Z/mZ.
V1 and V2 must have equal length.
M*/
/*H
	Version 1       31.01.1992      Bernd Mayr
   DATE vecpmilc      : 920331
H*/

#include <_matr1.h>

vec vecpmilc( r, m, P1, P2, V1, V2 )
single r;
int m;
pol P1, P2;
vec V1, V2;

{
	bind( m, P1, P2, V1, V2 );

	V1 = vecpmismul( r, m, P1, V1 );
	V2 = vecpmismul( r, m, P2, V2 );
	V1 = vecpmisum( r, m, V1, V2 );

	return( V1 );
}
