/*M
.SH NAME
upgf2nbqrem - univariate polynomial over Galois-field of characteristic 2, coefficients in normal basis representation, quotient and remainder   (recursive)

.SH SYNOPSIS
.nf
#include<_pol3.h>

pol upgf2nbqrem(G, MT, P1, P2, pR)
obj G; 
list *MT; 
pol P1, P2, *pR;
    
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
multiplication table MT. P2 must not be equal to zero.
.PP                                              
upgf2nbqrem computes the division with remainder of P1 by P2
.TP 4
P1 = P2 * P3 + Prem,
where Prem is the remainder of the division.
.PP
upgf2nbqrem returns P3. Prem can be found at *pR.
                                          
.SH SEE ALSO
.nf
udpm2tosb
gf2nbmt

M*/
                                             
/*H
	Version 1	28.10.94	Josef Gebel
   DATE upgf2nbqrem   : 941201 
H*/

#include <_pol3.h>

pol  upgf2nbqrem( G, MT, P1, P2, PR )
obj  G;
list *MT;
pol P1, P2, *PR;
{
    if( P1 )
    {
	/***   P1 != 0	 ***/

	single d, e1, e2;
	pol    P3, P3S;
	gf2el  a1, a2, q;

	bind( G, P1, P2 );
	init( a1, a2, q, P3, P3S );

	/***   Initializations	 ***/

	e2 = lfirst ( P2 );
	q  = lsecond( P2 );
	a2 = gf2nbinv( G, MT, q );

	P2 = lred2( P2 );
	if( P2 == _0 )
	{
	    /***   P2 = 0   ***/
	    P2 = 0;
	}
	P3 = _0;

	/*** Computation of P1 / P2 and P1 % P2 ***/

	while( P1 ) 
	{
	    e1 = lfirst( P1 );
	    d = e1 - e2;
	    if( d < 0 ) 
	    {
		break;
	    }

	    a1	= lsecond( P1 );
	    q	= gf2nbprod( G, MT, a1, a2 ); 
	    P3	= lcomp2( q, d, P3 );
	    P3S = list2( d, q );
	    P1	= lred2( P1 );
	    if( P1 == _0 )
	    {
		P1 = 0;
	    }
	    P3S = upgf2nbprod( G, MT, P2, P3S );
	    P1	= pgf2sum( 1, G, P1, P3S );
	}

	if( P1 )
	{
	    while( P1 && !lsecond( P1 ) )
	    {
		P1 = lred2( P1 );
		if( P1 == _0 )
		{
		    P1 = 0;
		}
	    }
	}

	*PR = P1;

	if( P3 != _0 )
	{
	    return( linv( P3 ) );
	}
    }
    return( 0 );
}
