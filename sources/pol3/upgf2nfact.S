/*M
.SH NAME
upgf2nfact - univariate polynomial over Galois-field with characteristic 2 Niederreiter factorization

.SH SYNOPSIS
.nf
#include <_pol3.h>

upgf2nfact( G, P )
obj G;
pol P;

L = upgf2nfact(G, P);

.SH DESCRIPTION
.TP 4
.B G
is an irreducible monic polynomial in one variable over
F2 := Z/2Z of degree n in special bit representation 
(see 'udpm2tosb') as generating polynomial of the field 
F := GF(2^n).
.TP 4
.B P 
is a polynomial of positiv degree in one variable
over F in special bit representation.
.TP 4
.B L
is a list of all irreducible factors
P_i of P over F:
 L = ( P_1, ... , P_t ) pol P_1, ..., P_t, and
 P = P_1 * ... * P_t.

The list L is ordered by the following rules:
Let a_l and b_l be the coefficients at x^l of P_i and P_(i+1), 
respectively. Then:
 0. P_i = P_(i+1) or
 1. deg( P_i ) > deg( P_(i+1) ) or
 2. deg( P_i ) == deg( P_(i+1) ) =: d and
    a_d = b_d, a_(d-1) = b_(d-1), ..., 
    a_(k+1) = b_(k+1) and
  2a. deg( a_k ) > deg( b_k ), a_k and b_k are
      interpreted as polynomials over GF(2), or
  2b. deg( a_k ) = deg( b_k ) and: 
      Running from left to right through the special 
      bit representation of a and b, b has the 
      first 0.

.SH LITERATURE
Harald Niederreiter: "Factorization of Polynomials
and Some Linear Algebra Over Finite Fields", 
Linear Algebra Appl. 192 (1993).

.SH SEE ALSO
.BR udpm2tosb(),
.BR upgf2nbnfact()
M*/

/*H
	Version 1       09.09.1994      Josef Gebel
	Version 2       10.11.1995      Anpassung an neue Matrixarithmetik JG
	Version 3	30.09.96	back trafo inserted; A. Stein
   DATE upgf2nfact	: 961201
H*/

#include <_pol3.h>

list upgf2nfact( G, P )
obj G;
pol P;
{
    if( !P ) return( ERROR );
    else  {
        single n, k;
        list   E, F, *MT, NP, PN;
        pol    Q;
        gf2el  a;
        single time;
    
        bind( G, P );
        init( a, Q , E, F, NP, PN );

        n = lfirst( G );
        k = ( ( n + 1 ) * n ) / 2;
    
        if((MT=(list * ) malloc(k * sizeof(list))) == NULL) return( ERROR );
        k--;
        init( MT[0..k] );

        a = gf2normel( G );
         
        /***   a is a normal element of F = GF(2^n).               ***/
        /***   Let x be a formal zero of the polynomial G(x).      ***/
        /***   Then { 1, x, x^2, ..., x^(n-1) } forms a power      ***/
        /***   basis of F. Compute the matrices PN and NP that     ***/
        /***   transform the power basis into the normal basis     ***/
        /***   and vice versa, respectively.                       ***/
        /***   We have PN, NP in (F_2)^(n x n) and PN - NP^(-1).   ***/

        NP = gf2nbtpbtm( G, a );
        PN = gf2pbtnbtm( G, a, NP);

        /***   Compute the table of the representation with       ***/
        /***   respect to the normal basis                        ***/
        /***            { a, a^2, ..., a^(2^(n-1)) }              ***/
        /***   of all                                             ***/
        /***         a^k = a^(2^i+2^j)), 0 <= i, j < n.           ***/
        /***   These a^k appear when two elements of F in normal  ***/
        /***   basis representation are multiplied. The result    ***/
        /***   must also be in normal basis representation.       ***/
        /***   The table is set up in order to find the normal    ***/
        /***   basis representation of the a^k.                   ***/

        gf2nbmt( G, a, MT, PN );
    
        /***   Transformation of the coefficients of the      ***/
        /***   polynomial from power basis to normal basis    ***/
        /***   representation.                                ***/
        Q = upgf2btc( G, P, PN );

        /***   Niederreiter factorization                     ***/
        F = upgf2nbnfact( G, MT, PN, Q );

        

        /***   Transformation of the coefficients of the      ***/
        /***   polynomials from normal basis to power basis   ***/
        /***   representation.                                ***/
        for( E = _0; F != _0; F = lred2(F) ) {
            Q = lfirst ( F );
            n = lsecond( F );
            P = upgf2btc( G, Q, NP );
            E = lcomp2( n, P, E );
        }
        return( linv( E ) );
    }
}



