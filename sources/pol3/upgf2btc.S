/*M

.SH NAME
upgf2btc - univariate polynomial over Galois field of characteristic 2 basis transformation of the coefficients

.SH SYNOPSIS
.nf
#include<_pol3.h>    

pol upgf2btc(G, P, T)  
obj  G; 
pol  P; 
list T;

.SH DESCRIPTION   
.TP 4
.B G 
is an irreducible monic univariate polynomial over GF(2)
of degree n > 1 with coefficients in special bit notation
(see udpm2tosb). G is interpreted as a generating polynomial
of the field GF(2^n).
.TP 4
.B P 
is a univariate polynomial over GF(2^n) with coefficients
in GF(2^n) given in special bit notation and represented 
with respect to a power basis,
.TP 4
.B T 
is an (n x n) matrix (with rows in special bit notation)
with full rank n. T is interpreted as a transformation matrix 
between two bases.
.PP
upgf2btc(G, P, PN) transforms the coefficients of P from a given
basis representation into another by multiplying all coefficients
of P with the basis transformation matrix T and returns the new representation.

.SH SEE ALSO
udpm2tosb

M*/

/*H
	Version 1       09.09.1994      Josef Gebel
   DATE upgf2btc      : 941201
H*/

#include <_pol3.h>

pol upgf2btc( G, P, PN )
obj  G;
pol  P;
list PN;
{
    if( P )
    {
        single e;     /***   exponents in P                  ***/
        gf2el  a;     /***   coefficients of P               ***/
        pol    Q;     /***   polynomial with coefficients    ***/
                      /***   in normal basis representation  ***/
     
        bind( G, P, PN );
        init( a, Q );

        Q = _0;

        while( P != _0 )
        {
            e = lfirst ( P );
            a = lsecond( P );
            a = gf2elsbbt( G, PN, a );
            Q = lcomp2( a, e, Q );
            P = lred2( P );
        }
        return( linv( Q ) );
    }
    return( 0 );
}
