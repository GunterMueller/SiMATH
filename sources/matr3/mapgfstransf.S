/*M
.SH NAME
mapgfstransf - matrix of polynomials over Galois-field with single characteristic, transformation

.SH SYNOPSIS
.nf
#include<_matr3.h>

matrix mapgfstransf(r1, p, AL, M1, V1, r2, P2, V2, Vn, pV3)
single r1,p;
list AL;
matrix M1;
list V1;
single r2;
pol P2;
list V2,Vn,*pV3;

.SH DESCRIPTION
mapgfstransf() returns the matrix
which arises by replacing the variable Vn by
the polynomial P2 in the matrix M1.
The resulting variable list will be stored in *pV3.

.PP
.TP 4
.B p
>2 must be prime.
.TP 4
.B AL
= (G,AL1) is the arithmetic list of GF(p^n), see gfsalgen().
.TP 4
.B M1
is a matrix of polynomials in r1 variables over the finite field GF(p^n).
.TP 4
.B V1
is the variable list corresponding to M1.
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
	Version 1       25.08.1993	S.Schmitt
   DATE mapgfstransf  : 931130
H*/

#include <_matr3.h>

matrix mapgfstransf( r1, p, AL, M1, V1, r2, P2, V2, Vn, pV3 )
single r1, p;
list AL;
matrix M1;
list   V1;
single r2;
pol    P2;
list   V2, Vn, *pV3;

{
	list L, pV, ZL, ZM;
	pol  a, b;

	bind( AL, M1, V1, P2, V2, Vn );
	init( L, pV, ZL, ZM, a, b );

	L = _0;
	while ( M1 != _0 )
	{
	   ZL = _0;
	   ZM = lfirst( M1 );
	   while ( ZM != _0 )
	   {
	      a = lfirst( ZM );
	      b = pgfstransf( r1, p, AL, a, V1, r2, P2, V2, Vn, &pV );
	      ZL = lcomp( b, ZL );
	      ZM = lred( ZM );
	   }
	   ZL = linv( ZL );
	   L = lcomp( ZL, L );
	   M1 = lred( M1 );
	}
	L = linv( L );

/* Ausgabe */

	( *pV3 ) = pV;
	return( L );
}


