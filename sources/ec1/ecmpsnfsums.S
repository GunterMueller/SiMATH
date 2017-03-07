/*M
.SH NAME
ecmpsnfsums - elliptic curve over modular primes, short normal form, sum of points, special version

.SH SYNOPSIS
.nf
#include<_ec1.h>

void ecmpsnfsums(p, a4, a6, x1, y1, x2, y2)
int p, a4, a6, *x1, *y1, *x2, *y2;

.SH DESCRIPTION
.TP 4
.B p
is a prime
.TP 4
.B a4, a6
are elements of Z/pZ and the coefficients of the elliptic curve E in short Weierstrass normal form.
.TP 4
.B (*x1, *y1), (*x2, *y2)
define the affine points P and Q on E. P and Q must not be the null point of the curve E.
.P
ecmpsnfsums computes the sum of P and Q, and writes the result back to (*x2, *y2).
.P
If the result of P + Q is the null point of the curve E, ecmpsnfsums writes (-1, -1) to (*x2, *y2).
.P
(*x2, *y2) will be changed, so
.P
    ecmpsnfsums(p, a4, a6, 
.B x1, y1, x1, y1
)
.P
returns in general a wrong result.

M*/

/*H
        Version 1       05.10.1991      Michael Pfeifer
   DATE ecmpsnfsums   : 920331
H*/

#include <_ec1.h>

void            ecmpsnfsums(p, a4, a6, x1, y1, x2, y2)
    int             p, a4, a6, *x1, *y1, *x2, *y2;
{
    int             l, h;

    bind(p, a4, a6, *x1, *y1, *x2, *y2);

    init(l, h);

    h = midif(p, *x2, *x1);

    if (h == 0)
    {
	if (misum(p, *y1, *y2) == 0)
	{

	    /*
	     * (*x1, *y1) + (*x2, *y2) = 0.
	     */

	    *x2 = -1;
	    *y2 = -1;
	    return;
	}
	else
	{
	    h = miinv(p, miprod(p, 2, *y1));
	    l = iprod(*x1, *x1);
	    l = isprod(l, 3);
	    l = iprod(isum(a4, l), h);
	    l = mihom(p, l);
	}
    }
    else
    {
	h = miinv(p, h);
	l = iprod(h, idif(*y2, *y1));
	l = mihom(p, l);
    }

    h = iprod(l, l);
    h = idif(h, *x1);
    h = idif(h, *x2);
    *x2 = mihom(p, h);
    *y2 = idif(*x1, *x2);
    *y2 = iprod(l, *y2);
    *y2 = idif(*y2, *y1);
    *y2 = mihom(p, *y2);

    return;
}
