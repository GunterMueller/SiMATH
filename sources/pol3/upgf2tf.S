/*M
.SH NAME
upgf2tf - polynomial over Galois-field with characteristic 2, trace function, special

.SH SYNOPSIS
.nf
#include<_pol3.h>

pol upgf2tf(G, F, d, M)  
single d; 
obj G; 
pol F, M;
      
.SH DESCRIPTION
.TP 4
.B G
is an univariate, monic and irreducible polynomial over Z/2Z in special bit-representation (s.udpm2tosb).
.PP
Let n be the degree of G, then G can be interpreted as a generator of GF(2^n)
(Galois-field with characteristic 2).                                           
.TP 4
.B F
is an univariate polynomial over GF(2^n) of degree m (say), with coefficients in special bit-representation.
.TP 4
.B d
is an integer number, d < BASIS.
.TP 4
.B M
is an univariate polynomial over GF(2^n) of degree l (say), with coefficients in special bit-representation. l had to be greater than m.
.PP
upgf2tf returns a polynomial, say P, of the form
.PP
P = Trace(F) = F + F^q + F^q^2 + ... + F^q^d.
.PP
All products, made for the computation of P, are reduced modulo (M * (Z/2Z)[x]) in special bit-representation.
 
.SH SEE ALSO
udpm2tosb
M*/
            
/*H
	Version 1       27.05.93        Joachim Stein
   DATE upgf2tf       : 931130
H*/

#include <_pol3.h>

pol upgf2tf( G, F, d, M )
single d; 
obj G;
pol F, M;
{
	single n, i;
	int q;
	pol P, H;               

        bind( G, F, M );
	init( q, P, H );

/** Berechnung von n und q  **/
        n = lfirst( G );
	q = iexp( 2, n );
        P = F;
        H = F;      
        for ( i = 1; i <= d; i++ )
        {
          H = pgf2expprem( 1, G, H, q, M );
          P = pgf2sum( 1, G, P, H ); 
          P = pgf2rem( 1, G, P, M ); 
        }
        return( P );
}
