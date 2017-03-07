/*M
.SH NAME
gf2quot - Galois-field with characteristic 2 quotient

.SH SYNOPSIS
.nf
#include<_arith2.h>

gf2el gf2quot(G,a,b)  
obj G; 
gf2el a, b;
 
.SH DESCRIPTION
.TP 4
.B G
is an univariate, monic and irreducible polynomial over Z/2Z in special bit-representation (s.udpm2tosb).
.PP
Let n be the degree of G, then G can be seen as a generator of GF(2^n)
( Galois-field with characteristic 2 ).
.TP 4
.B a, b
are elements of GF(2^n), represented as univariate polynomials over Z/2Z of degree < n in special bit-representation, b != 0.
.PP
gf2quot returns an element of GF(2^n), say c, where
.IP
c = a / b.
 
.SH SEE ALSO
udpm2tosb

M*/
                                   
/*H
	Version 1       04.03.1992	A.Stein
	Version 2       03.09.1999 	M.Conrad (G2-Arithmetik)
   DATE gf2quot       : 920331
H*/


# include <_arith2.h>
# include <_G2arith.h>

gf2el gf2quot(G,a,b)
obj G;
gf2el a, b;
{
        if( lfirst(G) <= G2maxdeg() ) { 
              unsigned long G2a[G2LAENGE];
              unsigned long G2b[G2LAENGE];
              unsigned long G2g[G2LAENGE];
              gf2toG2(a,G2a); 
              gf2toG2(b,G2b); 
              gf2toG2(G,G2g); 
              G2diveq(G2g,G2a,G2b);
              return( G2togf2(G2a) ); 
              } 
        else { 
	     bind(G,b,a);
	     b = gf2inv(G,b);
	     return( gf2prod(G,a,b) );
	     } 
}
