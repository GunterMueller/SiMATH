/*M
.SH NAME
upgf2nbsqrt - polynomial over Galois-field with characteristic 2, coefficients in normal basis representation, square root

.SH SYNOPSIS
.nf
#include<_pol3.h>

pol upgf2nbsqrt(G, P)  
obj G; 
pol P;
  
.SH DESCRIPTION
.TP 4
.B G
is an irreducible monic polynomial in one variable
over Z/2Z of degree n in special bit representation
(see udpm2tosb) as generating polynomial of GF(2^n).
.TP 4                                         
.B P
is a monic polynomial of positive degree in one variable over GF(2^n) in special bit representation.
.PP
upgf2nbsqrt(G, P) returns the square root, say Q,
of the polynomial P in GF(2^n) :
.IP
P = Q * Q    
.PP
if such a polynomial Q exists in GF(2^n), and (0) else.
         
.SH SEE ALSO
udpm2tosb

M*/
                                                           
/*H
	Version 1	09.09.1994	Josef Gebel
   DATE upgf2nbsqrt   : 941201
H*/

#include <_pol3.h>
	
pol  upgf2nbsqrt( G, P )  
obj  G; 
pol  P;
{
    if( P )
    {
	single s;
	pol    Q;
	gf2el  a, b;

	bind( G, P );

	init( Q );
	init( a, b );

	Q = P;

	while( Q != _0 )
	{
	    s = lfirst( Q );
	    if( s & 1 )
	    {
		/***   odd exponent in P		 ***/
		/***   ==> P is not a square in GF(2^n)	 ***/
		return( list1( 0 ) );
	    }
	    Q = lred2( Q );
	}
  
	while( P != _0 )
	{
	    s = lfirst( P ) >> 1;
	    a = lsecond( P );
	    b = gf2nbsqrt( G, a );
	    Q = lcomp2( b, s, Q );
	    P = lred2( P );
	}
	return( linv( Q ) );
    }
    return( 0 );
}
