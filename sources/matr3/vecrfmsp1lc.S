/*M
.SH NAME
vecrfmsp1lc - vector of rational functions over modular single primes, transcendence degree 1, linear combination

.SH SYNOPSIS
.nf
#include<_matr3.h>

vec vecrfmsp1lc(p, F1, F2, V1, V2)
single p;
rfunc F1,F2;
vec V1,V2;

.SH DESCRIPTION
vecrfmsp1lc() returns the linear combination (F1*V1)+(F2*V2).
.PP
.TP 4
.B p
must be prime.
.TP 4
.B F1,F2
are rational functions in r variables over Z/pZ.
.TP 4
.B  V1,V2
are rational functions in r variables over Z/pZ.
V1 and V2 must have equal length.
M*/







/*H
	Version 1       14.06.1989      U.Schneiders, Th. Weis
   DATE vecrfmsp1lc   : 890801.9011__.9109__
H*/

#include <_matr3.h>

vec vecrfmsp1lc( p, F1, F2, V1, V2 )
single p;
rfunc F1, F2;
vec V1, V2;

{
	bind( F1, F2, V1, V2 );

	V1 = vecrfmsp1sm( p, F1, V1 );
	V2 = vecrfmsp1sm( p, F2, V2 );
	V1 = vecrfmsp1sum( p, V1, V2 );

	return( V1 );
}


