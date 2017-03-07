/*M
.SH NAME
ecmpfp - elliptic curve over modular primes, find point

.SH SYNOPSIS
.nf
#include <_ec1.h>

list ecmpfp (p, a1, a2, a3, a4, a6)
int     p, a1, a2, a3, a4, a6;

.SH DESCRIPTION
ecmpfp computes a point P on the elliptic curve E.           P = (x, y, 1) is a list of three integers and represents the projective point (x:y:1). P is not the point at infinity, i.e. p != (0, 1, 0).  

.TP 4                                                                           
.B p                                                                            
is a prime                                                                      
.TP 4                                                                           
.B a1, a2, a3, a4, a6                                                           
are elements of Z/pZ and the coefficients of E, represented in Weierstrass normal form.
.TP 0
The output of ecmpfp depends on the global variable SEMIRAND. For a description of SEMIRAND, see irand.

.SH SEE ALSO
irand
M*/

/*H
	Version 1	03.04.1991	Michael Pfeifer
	Version 2       27.08.1991      von 'arith1 nach 'ec1.  PS
	Version 3	01.05.1996	Neue Doku. 	Georg Lay
   DATE ecmpfp        : 910715.910915.9612__
H*/

#include<_ec1.h>

list ecmpfp(p, a1, a2, a3, a4, a6)
	int             p, a1, a2, a3, a4, a6;
{
	single          i, j;
	int             x0, y0, x0s, y0s, r, s, t, u, a4s, a6s, h;
	list            P0, L1, L2;

	bind(p, a1, a2, a3, a4, a6);

	init(x0, y0, x0s, y0s, r, s, t, u, a4s, a6s, h);
	init(P0, L1, L2);

	if (icomp(p, 5) >= 0)
	{

		/*
		 * Falls p >= 5 ist wird die Kurve in kurze
		 * Weierstrass-Normalform transformiert
		 */

		P0 = ecmptosnf(p, a1, a2, a3, a4, a6);

		L1 = lfirst(P0);
		L2 = lsecond(P0);
		a4s = lfirst(L1);
		a6s = lsecond(L1);
		r = lfirst(L2);
		s = lsecond(L2);
		t = lthird(L2);
		u = lfourth(L2);

		/*
		 * Fuer das Modell in kurzer Weierstrass-Normalform wird ein
		 * Punkt gesucht, die Koordinaten werden spaeter
		 * ruecktransformiert
		 */

		P0 = ecmpsnffp(p, a4s, a6s);

		x0s = lfirst(P0);
		y0s = lsecond(P0);

		h = miprod(p, u, u);
		h = miprod(p, h, x0s);
		x0 = misum(p, h, r);

		h = miprod(p, u, u);
		h = miprod(p, h, u);
		h = miprod(p, h, y0s);
		y0 = miprod(p, u, u);
		y0 = miprod(p, y0, s);
		y0 = miprod(p, y0, x0s);
		y0 = misum(p, h, y0);
		y0 = misum(p, y0, t);

		return (list3(x0, y0, 1));
	}

	if ((p == 2) || (p == 3))
	{
		for (i = 0; i < p; i++)
		{
			for (j = 0; j < p; j++)
			{
				P0 = list3(i, j, 1);
				if (iselecmp(p, a1, a2, a3, a4, a6, P0) == 1)
				{
					return (P0);
				}
			}
		}
	}
}
