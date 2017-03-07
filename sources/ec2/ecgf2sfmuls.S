/*M
.SH NAME
ecgf2sfmuls - elliptic curve over Galois-field with characteristic 2, special form, multiplication-map, special version

.SH SYNOPSIS
.nf
#include<_ec2.h>

void ecmpsnfmuls(G, a6, x1, y1, n)
obj G; 
gfel a6, *x1, *y1; 
int n;
     
.SH DESCRIPTION
.TP 4
.B G
is an univariate, monic and irreducible polynomial over Z/2Z in special bit-representation (s.udpm2tosb).
.PP
Let n be the degree of G, then G can be seen as a generator of GF(2^n)
( Galois-field with characteristic 2 ). 
.TP 4
.B a6
is an element of GF(2^n), defining an elliptic curve, say E, by the equation
.IP
y^2 + y*x = x^3 + a6.
.TP 4
.B *x1, *y1 
are elements of GF(2^n), defining a point, say P, in affine representation on E.
P must not be the zero point of the curve.
.PP
ecgf2sfmuls computes a point, say P1, on E, where
.IP
P1 = n * P.
.PP
ecgf2sfmuls writes the result back to *x1 and *y1 or writes the empty list to each *x1, *y1, if P1 is the zero point of the curve. 

.SH CAUTION
*x1, *y1 will be changed.

.SH SEE ALSO
udpm2tosb

M*/
                            
/*H
        Version 1 	29.04.1993	Michael Pfeifer
   DATE ecgf2sfmuls   : 930531.9311__
H*/

#include <_ec2.h>

void            ecgf2sfmuls(G, a6, x1, y1, n)
    obj             G;
    gf2el           a6, *x1, *y1;
    int             n;
{
    int             m, h;
    gf2el           xn, yn, xh, yh;

    bind(G);
    bind(a6, *x1, *y1);
    bind(n);

    init(m, h);
    init(xn, yn, xh, yh);

    m = 1;
    h = n;

    xn = _0;
    yn = _0;

    while (icomp(m, n) <= 0)
    {
	if (mshom(2, h) == 1)
	{
	    if ((*x1 != _0) && (xn != _0))
	    {
		ecgf2sfsums(G, a6, x1, y1, &xn, &yn);
	    }
	    else
	    {
		if (xn == _0)
		{
		    xn = lcopy(*x1);
		    yn = lcopy(*y1);
		}
	    }
	}

	m = isprod(m, 2);
	h = isquot(h, 2);

	xh = lcopy(*x1);
	yh = lcopy(*y1);


	if (*x1 != _0)
	{
	    ecgf2sfsums(G, a6, &xh, &yh, x1, y1);
	}
    }

    *x1 = xn;
    *y1 = yn;

    return;
}
