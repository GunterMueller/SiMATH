/*M
.SH NAME
iselecmp - is element of an elliptic curve over modular primes 

.SH SYNOPSIS
.nf
#include<_ec1.h>

single iselecmp(p, a1, a2, a3, a4, a6, P1)
int p, a1, a2, a3, a4, a6;
list P1;

.SH DESCRIPTION
iselecmp returns 1, if P is a point of the cubic curve E, represented in Weierstrass normal form,
or 0 else.
.TP 4
.B p                                                                            
is a prime                                                                      
.TP 4                                                                           
.B a1, a2, a3, a4, a6
are elements of Z/pZ and the coefficients of E                                                           
.TP 4                                                                           
.B P1
is a list of 3 elements of Z/pZ, defining the projective Point P of E
M*/

/*H
	Version 1       07.12.1990      Michael Pfeifer
	Version 2       27.08.1991      von 'arith1 nach 'ec1.  PS
   DATE iselecmp      : 910715.910915
H*/

#include <_ec1.h>

single iselecmp(p, a1, a2, a3, a4, a6, P)
	int             p, a1, a2, a3, a4, a6;
	list            P;
{
	single          n;
	int             x, y, h1, h2;
	list            Q;

	bind(p, a1, a2, a3, a4, a6, P);

	init(x, y, h1, h2);
	init(Q);

	Q = ecmpsrpp(p, P);
	if (isppecmppai(p, P))
	{
		n = 1;
	}
	else
	{
		x = lfirst(Q);
		y = lsecond(Q);
		h1 = miprod(p, y, y);
		h2 = miprod(p, a1, x);
		h2 = miprod(p, h2, y);
		h1 = misum(p, h1, h2);
		h2 = miprod(p, a3, y);
		h1 = misum(p, h1, h2);
		h2 = miprod(p, x, x);
		h2 = miprod(p, h2, x);
		h1 = midif(p, h1, h2);
		h2 = miprod(p, x, x);
		h2 = miprod(p, h2, a2);
		h1 = midif(p, h1, h2);
		h2 = miprod(p, a4, x);
		h1 = midif(p, h1, h2);
		h1 = midif(p, h1, a6);
		if (mihom(p, h1) == 0)
		{
			n = 1;
		}
		else
		{
			n = 0;
		}
	}

	return (n);
}
