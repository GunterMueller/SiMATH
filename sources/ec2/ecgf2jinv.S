/*M
.SH NAME
ecgf2jinv - elliptic curve over Galois-field with characteristic 2, j-invariant

.SH SYNOPSIS
.nf
#include<_ec2.h>

gf2el ecgf2jinv(G, a1, a2, a3, a4, a6)
obj G;  
gf2el a1, a2, a3, a4, a6;
  
.SH DESCRIPTION
.TP 4
.B G
is an univariate, monic and irreducible polynomial over Z/2Z in special bit-representation (s.udpm2tosb).
.PP
Let n be the degree of G, then G can be seen as a generator of GF(2^n)
( Galois-field with characteristic 2 ).
.TP 4
.B a1, a2, a3, a4, a6
are elements of GF(2^n), represented as univariate polynomials over Z/2Z of degree < n in special bit-representation.
The a_i's are the coefficients of an elliptic curve (say E) in Weierstrass normal form over GF(2^n).
.PP
ecgf2jinv returns the j-invariant of the curve E.  

.SH SEE ALSO
 udpm2tosb
 Literature: J. H. Silverman: The arithmetic of elliptic
                              curves, p.46.            

M*/
                  
/*H
	Version 1       07.07.1992      Michael Pfeifer
   DATE ecgf2jinv     : 921130
H*/

#include <_ec2.h>

int             ecgf2jinv(G, a1, a2, a3, a4, a6)
    obj             G;
    gf2el           a1, a2, a3, a4, a6;
{
    gf2el           c4, h, j;
    list            L;

    bind(G, a1, a2, a3, a4, a6);

    init(c4, h, j);
    init(L);

    /*
     * Berechnung von c4 und D (hier D = j)
     */

    L = ecgf2tavc6(G, a1, a2, a3, a4, a6);
    c4 = lfirst(L);
    j = ecgf2disc(G, a1, a2, a3, a4, a6);

    /*
     * Berechnung der j-Invarianten
     */

    h = gf2prod(G, c4, c4);
    h = gf2prod(G, c4, h);
    j = gf2quot(G, h, j);

    return (j);
}
