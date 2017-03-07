/*M
.SH NAME
vpgfstransf - vector of polynomials over Galois-field with single characteristic, transformation

.SH SYNOPSIS
.nf
#include<_matr3.h>

vec vpgfstransf(r1, p, AL, W1, V1, r2, P2, V2, Vn, pV3)
single r1,p;
list AL;
vec W1;
list V1;
single r2;
pol P2;
list V2,Vn,*pV3;

.SH DESCRIPTION
vpgfstransf() returns the vector
which arises by replacing the variable Vn by
the polynomial P2 in the vector W1.
The resulting variable list will be stored in *pV3.

.PP
.TP 4
.B p
>2 must be prime.
.TP 4
.B AL
= (G,AL1) is the arithmetic list of GF(p^n), see gfsalgen().
.TP 4
.B W1
is a vector of polynomials in r1 variables over the finite field GF(p^n).
.TP 4
.B V1
is the variable list corresponding to W1.
.TP 4
.B P2
is a polynomial in r2 variables over the finite field GF(p^n).
.TP 4
.B V2
is the variable list corresponding to P2.
.TP 4
.B Vn
is a list containing one of the elements of V1.
.TP
.B *pV3
is the variable list where the union of the two lists
V1 and V2 will be stored in alphabetical order.
M*/






/*H
	Version 1       25.08.1993      S.Schmitt
   DATE vpgfstransf   : 931130
H*/

#include <_matr3.h>

vec vpgfstransf( r1, p, AL, W1, V1, r2, P2, V2, Vn, pV3 )
single r1, p;
list AL;
vec    W1;
list   V1;
single r2;
pol    P2;
list   V2, Vn, *pV3;

{
	list L, pV;
	pol  a, b;

	bind( AL, W1, V1, P2, V2, Vn );
	init( L, pV, a, b );

	L = _0;
	while ( W1 != _0 )
	{
	   a = lfirst( W1 );
	   b = pgfstransf( r1, p, AL, a, V1, r2, P2, V2, Vn, &pV );
	   L = lcomp( b,  L );
	   W1 = lred( W1 );
	}
	L = linv( L );

/* Ausgabe */

	( *pV3 ) = pV;
	return( L );
}


