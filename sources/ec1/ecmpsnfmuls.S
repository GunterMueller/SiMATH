/*M
.SH NAME
ecmpsnfmuls - elliptic curve over modular primes, short normal form, multiplication-map, special version

.SH SYNOPSIS
.nf
#include<_ec1.h>

void ecmpsnfmuls(p, a4, a6, x1, y1, n)  
int p, a4, a6, *x1, *y1, n;

.SH DESCRIPTION
.TP 4                                                                           
.B p                                                                            
is a prime                                                                      
.TP 4                                                                           
.B a4, a6                                                           
are elements of Z/pZ and the coefficients of the elliptic curve E in short Weierstrass normal form.
.TP 4
.B *x1, *x2 
define the affine point (x, y) on E. (x, y) must not be the null point of the curve E.
.P
ecmpsnfmuls computs the n-multiply of (x, y), and writes it back to (*x1, *x2).
.P
If the result of n * (x, y) is the null point of the curve E, ecmpsnfmuls writes (-1, -1) to (*x1, *x2).
.P 
(*x1, *x2) will be changed.
       
M*/

/*H
        Version 1       26.11.1991      Michael Pfeifer
   DATE ecmpsnfmuls   : 920331
H*/

#include <_ec1.h>

void            ecmpsnfmuls(p, a4, a6, x1, y1, n)
    int             p, a4, a6, *x1, *y1, n;
{
    int             m, h;
    int             xn, yn, xh, yh;

    bind(p, a4, a6, *x1, *y1, n);

    init(m, h);
    init(xn, yn, xh, yh);

    m = 1;
    h = n;

    xn = -1;
    yn = -1;

    while (icomp(m, n) <= 0)
    {
	if (mshom(2, h) == 1)
	{
	    if ((*x1 != -1) && (xn != -1))
	    {
		ecmpsnfsums(p, a4, a6, x1, y1, &xn, &yn);
	    }
	    else
	    {
		if (xn == -1)
		{
		    if (issingle(*x1))
		    {
			xn = *x1;
		    }
		    else
		    {
			xn = lcopy(*x1);
		    }
		    if (issingle(*y1))
		    {
			yn = *y1;
		    }
		    else
		    {
			yn = lcopy(*y1);
		    }
		}
	    }
	}

	m = isprod(m, 2);
	h = isquot(h, 2);

	if (issingle(*x1))
	{
	    xh = *x1;
	}
	else
	{
	    xh = lcopy(*x1);
	}
	if (issingle(*y1))
	{
	    yh = *y1;
	}
	else
	{
	    yh = lcopy(*y1);
	}
	if (*x1 != -1)
	{
	    ecmpsnfsums(p, a4, a6, &xh, &yh, x1, y1);
	}
    }

    *x1 = xn;
    *y1 = yn;

    return;
}
