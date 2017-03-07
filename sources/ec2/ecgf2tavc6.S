/*M
.SH NAME
ecgftavc6 - elliptic curve over Galois-field with characteristic 2, Tate's values c4, c6
 
.SH SYNOPSIS
.nf
#include<_ec2.h>

list ecgf2tavc6(G, a1, a2, a3, a4, a6)
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
The a_i's are the coefficients of an cubic curve (say E) in Weierstrass normal form over GF(2^n).
.PP
ecgf2tavc4 computes the Tate's values c4, c6 of E, and returns them as a list of two elements of GF(2^n) in special bit-representation.

.SH SEE ALSO
 udpm2tosb
 Literature: J. H. Silverman: The arithmetic of elliptic
                              curves, p.46.
                                                                            
M*/
    
/*H
	Version 1     	06.07.1992	Michael Pfeifer
   DATE ecgf2tavc6    : 921130
H*/

#include <_ec2.h>

list            ecgf2tavc6(G, a1, a2, a3, a4, a6)
    obj             G;
    gf2el           a1, a2, a3, a4, a6;
{
    gf2el           b2, b4, c4, c6, h;
    list            L;

    bind(G);
    bind(a1, a2, a3, a4, a6);

    init(b2, b4, c4, c6, h);
    init(L);

    L = ecgf2tavb6(G, a1, a2, a3, a4, a6);
    b2 = lfirst(L);
    b4 = lsecond(L);

    /*
     * Berechnung von c4 und c6
     */

    c4 = gf2prod(G, b2, b2);

    c6 = gf2prod(G, b2, b2);
    c6 = gf2prod(G, c6, b2);

    return (list2(c4, c6));
}
