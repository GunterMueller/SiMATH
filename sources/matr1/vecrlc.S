/*M
.SH NAME
vecrlc - vector of rational numbers, linear combination

.SH SYNOPSIS
.nf
#include<_matr1.h>

vec vecrlc(s1, s2, V1, V2)
rat s1, s2;
vec V1, V2;

.SH DESCRIPTION
vecrlc() returns the linear combination (s1*V1)+(s2*V2).

.PP
.TP 4
.B s1,s2
are rational numbers.
.TP 4
.B V1,V2
are vectors over the  rational numbers.
V1 and V2 must have equal length.
M*/
/*H
	Version 1       29.03.1989      U.Schneiders
   DATE vecrlc        : 890601
H*/

#include <_matr1.h>

vec vecrlc( s1, s2, V1, V2 )
rat s1, s2;
vec V1, V2;

{
	bind( s1, s2, V1, V2 );

	V1 = vecrsmul( s1, V1 );
	V2 = vecrsmul( s2, V2 );
	V1 = vecrsum( V1, V2 );

	return( V1 );
}
