/*M
.SH NAME
ecgf2neg - elliptic curve over Galois-field with characteristic 2, negative point

.SH SYNOPSIS
.nf
#include<_ec2.h>

list ecgf2neg(G, a1, a2, a3, a4, a6, PL)
obj G;  
gf2el a1, a2, a3, a4, a6;  
list PL;

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
.TP 4
.B PL
is a list of three elements of GF(2^n) in special bit-representation, defining a point, say P, in projective representation on the curve E.     
.PP
ecgf2neg returns the list PL1, defining the projective point P1 on E, where
.IP
P1 = - P.
                                                                     
.SH SEE ALSO
 udpm2tosb
 Literature: J. H. Silverman: The arithmetic of elliptic 
                              curves, p.58.  

M*/

/*H
	Version 1       12.07.1990      Michael Pfeifer
   DATE ecgf2neg      : 921130
H*/

#include <_ec2.h>

list            ecgf2neg(G, a1, a2, a3, a4, a6, P)
    obj             G;
    gf2el           a1, a2, a3, a4, a6;
    list            P;
{
    gf2el           x, y, z, h;

    bind(G);
    bind(a1, a2, a3, a4, a6);
    bind(P);

    init(x, y, z, h);

    /*
     * Berechnung des additiv inversen Punktes
     */

    x = lfirst(P);
    y = lsecond(P);
    z = lthird(P);

    if (z != 0)
    {
	x = gf2quot(G, x, z);
	y = gf2quot(G, y, z);
	z = udpm2togf2el(G, list2(0, 1));
	h = gf2prod(G, a1, x);
	y = gf2sum(G, y, h);
	y = gf2sum(G, y, a3);
    }
    else
    {
	x = 0;
	y = udpm2togf2el(G, list2(0, 1));
	z = 0;
    }
    return (list3(x, y, z));
}
