/*M
.SH NAME
upgfstf - univariate polynomial over Galois-field with single characteristic, trace function

.SH SYNOPSIS
.nf
#include<_pol3.h>

pol upgfstf(p, AL, P, d, M)  
single p, d;  
list AL;  
pol P, M;
     
.SH DESCRIPTION
.TP 4
.B p
is a prime number, 2 < p < BASIS.
.TP 4
.B AL
= (G AL1) can be seen as an arithmetic list of GF(p^n), where n = lenght(AL1)+1 (s. gfsalgen).
.TP 4
.B d
is a positive integer.
.TP 4
.B M
is an univariate polynomial over GF(p^n), which has only irreducible factors of degree d.
.TP 4
.nf
.B P
is a univariate polynomial over GF(p^n), 
deg(P) < deg(M) (P will be interpreted as an element 
in GF(p^n)[x] / (M)).
.PP
upgfstf returns a polynomial, say P1, such that, 
for q := p^n,
.PP
P1 = Tr(P) = (P + P^q + P^(q^2) +...+ P^(q^(d-1))) mod M.

.SH SEE ALSO
gfsalgen

M*/
                        
/*H
	Version 1	03.11.1992	Joachim Stein
   DATE upgfstf       : 921130
H*/

#include <_pol3.h>

pol upgfstf( p, AL, G, d, M )
single p, d; 
list AL;
pol G, M;
{
	single n, i;
	int q;
	pol P, H;               

        bind( AL, G, M );
	init( q, P, H );

/** Berechnung von n und q  **/
        n = lfirst( lfirst( AL ) );
	q = iexp( p, n );
        P = G;
        H = G;      
        for ( i = 1; i <= d; i++ )
        {
          H = pgfsexpprem( 1, p, AL, H, q, M );
          P = pgfssum( 1, p, AL, P, H ); 
          P = pgfsrem( 1, p, AL, P, M ); 
        }
        return( P );
}
