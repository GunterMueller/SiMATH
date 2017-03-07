/*M
.SH NAME
upgf2nbsqu - univariate polynomial over Galois-field with characteristic 2, coefficients in normal basis representation, square

.SH SYNOPSIS
.nf
#include<_pol3.h>

pol upgf2nbsqu(G, P)  
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
is a polynomial in one variable over GF(2^n) in special bit representation with coefficients represented with respect to some normal basis of GF(2^n).
.PP
upgf2nbsqu returns a polynomial, say Q, where
.IP
Q = P^2 = P * P, the square of the polynomial P. 
.PP
Q is given in special bit notation with respect to the 
same normal basis as P. 

.SH SEE ALSO
udpm2tosb

M*/
                           
/*H
	Version 1	04.11.1994	Josef Gebel
   DATE upgf2nbsqu    : 941201
H*/

#include <_pol3.h>

pol upgf2nbsqu( G, P )
obj G;
pol P;
{
    if( !P ) 
    {
	single e;
	pol    Q;
	gf2el  a, b;

	init( Q,  a, b );
	bind( G, P );

	P = lcinv( P );
	Q = _0;
	
	do
	{
	    a = lfirst ( P );
	    e = lsecond( P );
	    P = lred2( P );
      
	    b = gf2nbsqu( G, a );
	    e <<= 2;
	    Q = lcomp2( e, b, Q );
	}
	while( P != _0 );

	return( Q );
    }
    return( 0 );
}
