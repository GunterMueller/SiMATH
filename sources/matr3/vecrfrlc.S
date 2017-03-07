/*M
.SH NAME
vecrfrlc - vector of rational functions over the rational numbers, linear combination

.SH SYNOPSIS
.nf
#include<_matr3.h>

vec vecrfrlc(r, F1, F2, V1, V2)
single r;
rfunc F1,F2;
vec V1,V2;

.SH DESCRIPTION
vecrfrlc() returns the linear combination (s1*V1)+(s2*V2).

.PP
.TP 4
.B F1,F2
are rational functions in r variables over the rational numbers.
.TP 4
.B  V1,V2
are vectors of rational functions in r variables over the rational numbers.
V1 and V2 must have equal length.
M*/






/*H
	Version 1       14.06.1989      U.Schneiders, Th. Weis
   DATE vecrfrlc      : 890801.9109__
H*/

#include <_matr3.h>

vec vecrfrlc( r, F1, F2, V1, V2 )
single r;
rfunc F1, F2;
vec V1, V2;

{
	bind( F1, F2, V1, V2 );

	V1 = vecrfrsmul( r, F1, V1 );
	V2 = vecrfrsmul( r, F2, V2 );
	V1 = vecrfrsum( r, V1, V2 );

	return( V1 );
}


