/*M
.SH NAME
mapgf2transf - matrix of polynomials over Galois-field with characteristic 2, transformation 

.SH SYNOPSIS
.nf
#include<_matr3.h>

matrix mapgf2transf(r1,G,M1,V1,r2,P2,V2,Vn,pV3)
single r1, r2; 
list G, V1, V2, Vn, *pV3; 
matrix M1;
pol P2; 


.SH DESCRIPTION
mapgf2transf() returns the matrix of polynomials
which arises by replacing the variable Vn by
the polynomial P2 in the matrix M1.
.PP
.TP 4
.B r1
is the number of variables used in the polynomials of M1.
.TP 4
.B G
is an irreducible monic polynomial in one variable over Z/2Z.
.TP 4
.B M1
is a matrix of polynomials in r1 variables over GF(2^n).
.TP 4
.B V1
is the variable list of M1.
.TP 4
.B P2
is a polynomial in r2 variables over GF(2^n).
.TP 4
.B V2
is the variable list of P2.
.TP 4
.B Vn
is a list which represents a single variable name of V1.
.TP 4
.B *pV3
is the variable list where the union of the two lists
V1 and V2 will be stored in alphabetical order.
M*/


/*H
	Version 1       01.03.1996	S.Schmitt
   DATE mapgf2transf  : 960501
H*/

#include <_matr3.h>

matrix mapgf2transf( r1, G, M1, V1, r2, P2, V2, Vn, pV3 )
single r1;
list G;
matrix M1;
list   V1;
single r2;
pol    P2;
list   V2, Vn, *pV3;

{
	list L, pV, ZL, ZM;
	pol  a, b;

	bind( G, M1, V1, P2, V2, Vn );
	init( L, pV, ZL, ZM, a, b );

	L = _0;
	while ( M1 != _0 )
	{
	   ZL = _0;
	   ZM = lfirst( M1 );
	   while ( ZM != _0 )
	   {
	      a = lfirst( ZM );
	      b = pgf2transf( r1, G, a, V1, r2, P2, V2, Vn, &pV );
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


