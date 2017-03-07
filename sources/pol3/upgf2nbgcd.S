/*M
.SH NAME
upgf2nbgcd - univariate polynomial over Galois-field of characteristic 2, coefficients in normal basis representation, greatest common divisor

.SH SYNOPSIS
.nf
#include<_pol3.h>

pol upgf2nbgcd(G, MT, P1, P2)  
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
upgf2nbgcd returns a polynomial, say P3, where
.IP
P3 = gcd(P1, P2).
.PP
P3 is given in special bit notation with respect to the same 
normal basis as P1 and P2.

.SH SEE ALSO
.nf
udpm2tosb
gfsnbmt

M*/

/*H
	Version 1       04.11.1994      Josef Gebel
   DATE upgf2nbgcd    : 941201
H*/

#include <_pol3.h>

pol  upgf2nbgcd( G, MT, P1, P2 )
obj  G;
list *MT;
pol  P1, P2;
{
    pol P3;

    init( P3 );
    bind( G, P1, P2);

    if( !P1 ) 
    {
        /***   P1 = 0   ***/
        P3 = P2;
    }
    else if( !P2 ) 
    {
        /***   P2 = 0   ***/
        P3 = P1;
    }
    else
    {
        /***   P1 and P2 are both non-zero   ***/
        pol H;

        init( H );

        if( lfirst( P1 ) < lfirst( P2 ) ) 
        {
            P3 = P2;
            P2 = P1;
            P1 = P3;
        }

        do
        {
            H  = upgf2nbqrem( G, MT, P1, P2, &P3 );
            P1 = P2;
            P2 = P3;
        }
        while( P2 != 0 );
    }

    /***   Make gcd( P1, P2 ) a monic polynomial   ***/

    P3 = upgf2nbmonic( G, MT, P1 );
    return( P3 );
}
