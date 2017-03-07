/*M
.SH NAME
upgf2nbmonic - univariate polynomial over Galois-field of characteristic 2, coefficients in normal basis representation, to monic polynomial

.SH SYNOPSIS
.nf
#include<_pol3.h>

pol upgf2nbmonic(G, MT, P)  
obj G; 
list *MT; 
pol P;
 
.SH DESCRIPTION
.TP 4
.B G
is an irreducible monic polynomial in one variable
over Z/2Z of degree n in special bit representation
(see udpm2tosb) as generating polynomial of GF(2^n).
.TP 4
.B *MT
is a pointer on an array containing the multiplication
table of a normal element of GF(2^n) (s. gf2nbmt).
.TP 4  
.B P
is a polynomial in one variable over GF(2^n) in special bit
representation with coefficients represented with respect to 
the normal basis of GF(2^n) with multiplication table MT.
.PP
Let m be the degree and a_m be the leading coefficient of P, 
then upgf2nbmonic returns a polynomial, say P1, where
.IP 
P1 = a_m^(-1) * P = X^m + ... 
.PP
P1 is given in special bit notation with respect to the 
same normal basis as P.

.SH SEE ALSO
.nf
udpm2tosb
gf2nbmt
M*/

/*H
	Version 1	04.11.1994	Josef Gebel
   DATE upgf2nbmonic  : 941201
H*/

#include <_pol3.h>

pol  upgf2nbmonic( G, MT, P )
obj  G;
list *MT;
pol  P;
{
    if( P ) 
    {
	/***   P != 0	***/
    
	single e;
	pol    P1;
	gf2el  a, b;

	init( P1, a, b );
	bind( G, P );

	P1 = _0;

	b = lsecond( P );
	a = gf2nbinv( G, MT, b );
	/***   a = (leading coefficient of P)^(-1)   ***/

	do
	{
	    e  = lfirst ( P );
	    b  = lsecond( P );
	    b  = gf2nbprod( G, MT, a, b );
	    P1 = lcomp2( b, e, P1 );
	    P  = lred2( P );
	}
	while( P != _0 );

	return( linv( P1 ) );
    }

    return( 0 );
}
