/*M
.SH NAME
upgf2nbprod - univariate polynomial over Galois-field with characteristic 2, coefficients in normal basis representation, product

.SH SYNOPSIS
.nf
#include<_pol3.h>

pol upgf2nbprod(G, MT, P1, P2)  
obj G; 
list *MT; 
pol P1, P2;
        
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
.B P1, P2
are polynomials in one variable over GF(2^n) in
special bit representation with coefficients represented
with respect to the normal basis of GF(2^n) with
multiplication table MT.
.PP     
upgf2nbprod returns a polynomial, say P3, where
.IP
P3 = P1 * P2.
.PP
P3 is given in special bit notation with respect to the same normal basis as P1 and P2.   

.SH SEE ALSO
.nf
udpm2tosb
gfsnbmt

M*/           

/*H
	Version 1	04.11.1994	Josef Gebel
   DATE upgf2nbprod   : 941201
H*/

#include <_pol3.h>

pol  upgf2nbprod( G, MT, P1, P2 )
obj  G;
list *MT;
pol  P1, P2;
{
    if( P1 && P2 ) 
    {
	single e1, e2;
	pol    P1S, P3, P3S;
	gf2el  a1, a2;

	init( P1S, P3, P3S, a1, a2 );
	bind( G, P1, P2 );

	P1 = lcinv( P1 );
	P2 = lcinv( P2 );
	P3 = 0;
	
	do
	{
	    a2 = lfirst ( P2 );
	    e2 = lsecond( P2 );
	    P2 = lred2( P2 );

	    P1S = P1;
	    P3S = _0;

	    do 
	    {
		a1  = lfirst ( P1S );
		e1  = lsecond( P1S );
		P1S = lred2( P1S );
		a1  = gf2nbprod( G, MT, a1, a2 );
		P3S = lcomp2( e1 + e2, a1, P3S );
	    }
	    while( P1S != _0 );

	    P3 = pgf2sum( 1, G, P3, P3S );
	}
	while( P2 != _0 );

	return( P3 );
    }
    return( 0 );
}
