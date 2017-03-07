/*M
.SH NAME
ecmpsum - elliptic curve over modular primes, sum of points

.SH SYNOPSIS
.nf
#include<_ec1.h>

list ecmpsum(p, a1, a2, a3, a4, a6, P1, Q1)
int p, a1, a2, a3, a4, a6;
list P1(p1, p2, p3), Q1(q1, q2, q3);
int p1, p2, p3, q1, q2, q3;

.SH DESCRIPTION

ecmpsum computes the sum of the points P and Q of the elliptic curve E and returns it as a list of 3 rational numbers.
.TP 4                                                                           
.B p                                                                            
is a prime                                                                      
.TP 4                                                                           
.B a1, a2, a3, a4, a6                                                           
are elements of Z/pZ and the coefficients of E, represented in Weierstrass normal form.
                                                                               
.TP 4                                                                           
.B P1
,
.B Q1                                                                           
are lists of 3 elements of Z/pZ, defining the projective points P and Q of E.   

.SH SEE ALSO
J.H. Silvermann, 
The arithmetic of elliptic curves, p.59. 
M*/

/*H
	Version 1       07.12.1990      Michael Pfeifer
	Version 2       27.08.1991      von 'arith1 nach 'ec1.  PS
   DATE ecmpsum       : 910715.910915
H*/

#include <_ec1.h>

list ecmpsum(p, a1, a2, a3, a4, a6, P1, P2)
	int             p, a1, a2, a3, a4, a6;
	list            P1, P2;
{
	int             x1, x2, x3, y3, z3, l, n, h;
	list            P3, L;

	bind(p, a1, a2, a3, a4, a6, P1, P2);

	init(x1, x2, x3, y3, z3, l, n, h);
	init(P3, L);

	/*
	 * Berechnung der Schnittgeraden
	 */

	L = ecmplp(p, a1, a2, a3, a4, a6, P1, P2);

	if (llength(L) == 1)
	{
		if (lfirst(L) == 0)
		{
			P3 = list3(0, 1, 0);
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
		L = ecmpsrpp(p, P1);
		x1 = lfirst(L);
		L = ecmpsrpp(p, P2);
		x2 = lfirst(L);

		x3 = miprod(p, l, l);
		h = miprod(p, a1, l);
		x3 = misum(p, x3, h);
		x3 = midif(p, x3, a2);
		x3 = midif(p, x3, x1);
		x3 = midif(p, x3, x2);
		y3 = misum(p, l, a1);
		y3 = mineg(p, y3);
		y3 = miprod(p, y3, x3);
		y3 = midif(p, y3, n);
		y3 = midif(p, y3, a3);
		z3 = 1;
		P3 = list3(x3, y3, z3);
	}

	return (P3);
}
