/*M
.SH NAME
iselecmpsnf - is element of an elliptic curve over modular primes, short normal form

.SH SYNOPSIS
.nf
#include<_ec1.h>

single iselecmpsnf(p, a, b, P1)
int a, b;
list P1;

.SH DESCRIPTION
iselecmpsnf returns 1, if P is a point of the cubic curve E, represented in short Weierstrass normal form,
or 0 else.
.TP 4                                                                           
.B p  
is a prime                                                                      
.TP 4                                                                           
.B a, b                                                           
are elements of Z/pZ, representing E                              
                                                                                
.TP 4                                                                           
.B P1                                                                           
is a list of 3 rationals, defining the projective Point P of E  
M*/

/*H
	Version 1       19.02.1990      Michael Pfeifer
	Version 2       27.08.1991      von 'arith1 nach 'ec1.  PS
   DATE iselecmpsnf   : 910715.910915
H*/

#include <_ec1.h>

single iselecmpsnf(p, a, b, P)
	int             p, a, b;
	list            P;
{
	single          n;
	int             x, y, h1, h2;
	list            Q;

	bind(p, a, b, P);

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
		h2 = miprod(p, x, x);
		h2 = miprod(p, h2, x);
		h1 = midif(p, h1, h2);
		h2 = miprod(p, a, x);
		h1 = midif(p, h1, h2);
		h1 = midif(p, h1, b);
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
