/*M
.SH NAME
ecgftavb8 - elliptic curve over Galois-field with characteristic 2, Tate's values b2, b4, b6, b8

.SH SYNOPSIS
.nf
#include<_ec2.h>

list ecgf2tavb8(G, a1, a2, a3, a4, a6)
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
ecgf2tavb8 computes the Tate's values b2, b4, b6 and b8 of E, and returns them as a list of four elements of GF(2^n) in special bit-representation.

.SH SEE ALSO
 udpm2tosb
 Literature: J. H. Silverman: The arithmetic of elliptic
                              curves, p.46.

M*/
               
/*H
	Version 1     	06.07.1992	Michael Pfeifer
   DATE ecgf2tavb8    : 921130
H*/

#include <_ec2.h>

list            ecgf2tavb8(G, a1, a2, a3, a4, a6)
    obj             G;
    gf2el           a1, a2, a3, a4, a6;
{
    gf2el           b8, h;
    list            L;

    bind(G);
    bind(a1, a2, a3, a4, a6);

    init(b8, h);
    init(L);

    /*
     * Berechnung von b8
     */

    b8 = gf2prod(G, a1, a1);
    b8 = gf2prod(G, b8, a6);
    h = gf2prod(G, a1, a3);
    h = gf2prod(G, a4, h);
    b8 = gf2dif(G, b8, h);
    h = gf2prod(G, a2, a3);
    h = gf2prod(G, a3, h);
    b8 = gf2sum(G, b8, h);
    h = gf2prod(G, a4, a4);
    b8 = gf2dif(G, b8, h);

    /*
     * Anhaengen an die Liste aus b2, b4, b6
     */

    L = ecgf2tavb6(G, a1, a2, a3, a4, a6);
    L = lconc(L, list1(b8));

    return (L);
}
