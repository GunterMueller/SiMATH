/*M
.SH NAME
vecpgfslc - vector of polynomials over Galois-field with single characteristic, linear combination

.SH SYNOPSIS
.nf
#include<_matr3.h>

vec vecpgfslc(r, p, AL, s1, s2, V1, V2)
single r,p;
list AL;
pol s1,s2;
vec V1,V2;

.SH DESCRIPTION
vecpgfslc() returns the linear combination (s1*L1)+(s2*L2).

.PP
.TP 4
.B p
>2, must be prime.
.TP 4
.B AL
= (G,AL1) is the arithmetic list of GF(p^n), see gfsalgen().
.TP 4
.B s1,s2
are polynomials over GF(p^n).
.TP 4
.B V1,V2
are vectors of polynomials in r variables over GF(p^n).
V1 and V2 must have equal length.
M*/






/*H
	Version 1       12.04.1990      Th. Weis
   DATE vecpgfslc     : 910915
H*/

#include <_matr3.h>

vec vecpgfslc( r, p, AL, s1, s2, L1, L2 )
single r, p;
list   AL;
pol    s1, s2;
vec    L1, L2;

{
	vec Z;
	pol a1, a2;

	bind( AL, s1, s2, L1, L2 );
	init( Z, a1, a2 );

	Z = _0;
	while ( L1 != _0 )
	{
	   a1 = pgfsprod( r, p, AL, s1, lfirst( L1 ) );
	   a2 = pgfsprod( r, p, AL, s2, lfirst( L2 ) );
	   a1 = pgfssum( r, p, AL, a1, a2 );
	   L1 = lred( L1 );
	   L2 = lred( L2 );
	   Z = lcomp( a1, Z );
	}
	Z = linv( Z );
	return( Z );
}


