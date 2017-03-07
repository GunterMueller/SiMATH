/*M
.SH NAME
iselecgf2 - is element of an elliptic curve over Galois-field with characteristic 2 ?

.SH SYNOPSIS
.nf
#include<_ec2.h>

single iselecgf2(G, a1, a2, a3, a4, a6, PL)
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
The a_i's are the coefficients of a cubic curve (say E) in Weierstrass normal form over GF(2^n).
.TP 4
.B PL
is a list of three elements of GF(2^n) in special bit-representation, defining a point, say P, in projective representation on an elliptic curve.
.PP
iselecgf2 returns
.IP
 1, if P is a point on E,
 0, else. 

.SH SEE ALSO
udpm2tosb

M*/

/*H
	Version 1       07.07.1992      Michael Pfeifer
   DATE iselecgf2     : 921130
H*/

#include <_ec2.h>

single          iselecgf2(G, a1, a2, a3, a4, a6, P)
    obj             G;
    gf2el           a1, a2, a3, a4, a6;
    list            P;
{
    gf2el           x, y, h1, h2;
    list            Q;

    bind(G);
    bind(a1, a2, a3, a4, a6);
    bind(P);

    init(x, y, h1, h2);
    init(Q);

    Q = ecgf2srpp(G, P);
    if (isppecgf2pai(G, P))
    {
	return (1);
    }
    else
    {
	x = lfirst(Q);
	y = lsecond(Q);
	h1 = gf2prod(G, y, y);
	h2 = gf2prod(G, a1, x);
	h2 = gf2prod(G, h2, y);
	h1 = gf2sum(G, h1, h2);
	h2 = gf2prod(G, a3, y);
	h1 = gf2sum(G, h1, h2);
	h2 = gf2prod(G, x, x);
	h2 = gf2prod(G, h2, x);
	h1 = gf2dif(G, h1, h2);
	h2 = gf2prod(G, x, x);
	h2 = gf2prod(G, h2, a2);
	h1 = gf2dif(G, h1, h2);
	h2 = gf2prod(G, a4, x);
	h1 = gf2dif(G, h1, h2);
	h1 = gf2dif(G, h1, a6);
	if (h1 == 0)
	{
	    return (1);
	}
	else
	{
	    return (0);
	}
    }

}
