/*M
.SH NAME
ecgf2sum - elliptic curve over Galois-field with characteristic 2, sum of points

.SH SYNOPSIS
.nf
#include<_ec2.h>

list ecgf2sum(G, a1, a2, a3, a4, a6, PL1, PL2)
obj G;  
gf2el a1, a2, a3, a4, a6;  
list PL1, PL2;
    
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
.B PL1
is a list of three elements of GF(2^n) in special bit-representation, defining a point, say P1, in projective representation on the curve E.
.TP 4
.B PL2
is a list of three elements of GF(2^n) in special bit-representation, defining a point, say P2, in projective representation on the curve E. 
.PP
ecgf2sum returns the list PL3, defining the projective point P3 on E, where
.IP
P3 = P1 + P2.

.SH SEE ALSO
 udpm2tosb
 Literature: J.H. Silverman: The arithmetic of elliptic
                             curves, p.59.                       

M*/
                   
/*H
	Version 1       13.07.1992      Michael Pfeifer
   DATE ecgf2sum      : 921130
H*/

#include <_ec2.h>

list            ecgf2sum(G, a1, a2, a3, a4, a6, P1, P2)
    obj             G;
    gf2el           a1, a2, a3, a4, a6;
    list            P1, P2;
{
    gf2el           x1, x2, x3, y3, z3, l, n, h;
    list            P3, L;

    bind(G);
    bind(a1, a2, a3, a4, a6);
    bind(P1, P2);

    init(x1, x2, x3, y3, z3, l, n, h);
    init(P3, L);

    /*
     * Berechnung der Schnittgeraden
     */

    L = ecgf2lp(G, a1, a2, a3, a4, a6, P1, P2);

    if (llength(L) == 1)
    {
	if (lfirst(L) == 0)
	{
	    h = udpm2togf2el(G, list2(0, 1));
	    P3 = list3(0, h, 0);
	}
	if (lfirst(L) == 1)
	{
	    P3 = P2;
	}
	if (lfirst(L) == 2)
	{
	    P3 = P1;
	}
    }
    else
    {
	l = lfirst(L);
	n = lsecond(L);
	L = ecgf2srpp(G, P1);
	x1 = lfirst(L);
	L = ecgf2srpp(G, P2);
	x2 = lfirst(L);

	x3 = gf2prod(G, l, l);
	h = gf2prod(G, a1, l);
	x3 = gf2sum(G, x3, h);
	x3 = gf2sum(G, x3, a2);
	x3 = gf2sum(G, x3, x1);
	x3 = gf2sum(G, x3, x2);
	y3 = gf2sum(G, l, a1);
	y3 = gf2prod(G, y3, x3);
	y3 = gf2sum(G, y3, n);
	y3 = gf2sum(G, y3, a3);
	z3 = udpm2togf2el(G, list2(0, 1));

	P3 = list3(x3, y3, z3);
    }

    return (P3);
}
