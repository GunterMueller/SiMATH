/*M
.SH NAME
vecilc - vector of integers linear combination

.SH SYNOPSIS
.nf
#include<_matr1.h>

vec vecilc(s1, s2, V1, V2)
int s1, s2;
vec V1, V2;

.SH DESCRIPTION
vecilc() returns the linear combination (s1*V1)+(s2*V2).

.PP
.TP 4
.B s1,s2
are integers.
.TP 4
.B V1,V2
are vectors of integers.
V1 and V2 must have equal length.
M*/
/*H
	Version1        25.08.1988      Klaus Petry
	Version 1.2.    29.03.1989      U.Schneiders ( Dok., Bezeichn. )
   DATE vecilc        : 890601
H*/

#include <_matr1.h>

vec vecilc( s1, s2, V1, V2 )
int s1, s2;
vec V1, V2;

{
	bind( s1, s2, V1, V2 );

	V1 = vecismul( s1, V1 );
	V2 = vecismul( s2, V2 );
	V1 = vecisum( V1, V2 );

	return( V1 );
}
