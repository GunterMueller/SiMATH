/*M
.SH NAME
ecgf2lp - elliptic curve over Galois-field with characteristic 2, line through points

.SH SYNOPSIS
.nf
#include<_ec2.h>

list ecgf2lp(G, a1, a2, a3, a4, a6, PL1, PL2)
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
ecgf2lp computes the line, say H, trough the points P1 and P2, or the tangent to P1, if P1 = P2.
.IP
H: y = l * x + n.
.P
If possible, ecgf2lp returns the list
.IP
 L = ( l n ),   or
 L = ( 0 ),     for P1 = -P2,
 L = ( 1 ),     for P1 the point at infinity,
 L = ( 2 ),     for P2 the point at infinity.

.SH SEE ALSO
 udpm2tosb
 Literature: J.H. Silverman: The arithmetic of elliptic      
                            curves, p.58
 
M*/
            
/*H
	Version 1       13.07.1992      Michael Pfeifer
   DATE ecgf2lp       : 921130
H*/

#include <_ec2.h>

list            ecgf2lp(G, a1, a2, a3, a4, a6, P1, P2)
    obj             G;
    gf2el           a1, a2, a3, a4, a6;
    list            P1, P2;
{
    gf2el           l, n, h, h1;
    gf2el           x1, y1, x2, y2;
    list            Q, L;

    bind(G);
    bind(a1, a2, a3, a4, a6);
    bind(P1, P2);

    init(l, n, h, h1);
    init(x1, y1, x2, y2);
    init(Q, L);

    /*
     * Standarddarstellung der Punkte.
     */

    Q = ecgf2srpp(G, P1);
    x1 = lfirst(Q);
    y1 = lsecond(Q);
    Q = ecgf2srpp(G, P2);
    x2 = lfirst(Q);
    y2 = lsecond(Q);

    /*
     * Test: P1 = -P2 ?
     */

    Q = ecgf2neg(G, a1, a2, a3, a4, a6, P2);
    if (isppecgf2eq(G, P1, Q))
    {
	return (list1(0));
    }

    /*
     * Test: P1 = (0, 1, 0) oder P2 = (0, 1, 0) ?
     */

    if (isppecgf2pai(G, P1))
    {
	return (list1(1));
    }
    if (isppecgf2pai(G, P2))
    {
	return (list1(2));
    }

    /*
     * Berechnung von l und n.
     */

    if (oequal(x1, x2))
    {
	h = gf2prod(G, a1, x1);
	h = gf2sum(G, h, a3);
	h = gf2inv(G, h);

	l = gf2prod(G, x1, x1);
	l = gf2sum(G, l, a4);
	h1 = gf2prod(G, a1, y1);
	l = gf2sum(G, l, h1);
	l = gf2prod(G, l, h);

	n = gf2prod(G, l, x1);
	n = gf2dif(G, y1, n);
    }
    else
    {
	h = gf2sum(G, x1, x2);
	h = gf2inv(G, h);

	l = gf2sum(G, y1, y2);
	l = gf2prod(G, l, h);

	n = gf2prod(G, x1, l);
	n = gf2sum(G, y1, n);
    }

    return (list2(l, n));
}
