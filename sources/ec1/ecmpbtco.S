/*M
.SH NAME
ecmpbtco - elliptic curve over modular primes, birational transformation of coefficients

.SH SYNOPSIS
.nf
#include<_ec1.h>

list ecmpbtco(p, a1, a2, a3, a4, a6, r, s, t, u)
int p, a1, a2, a3, a4, a6, r, s, t, u;

.SH DESCRIPTION
The elliptic curve E will be birationaly transformed by Bt.

ecmpbtco returns a list
.P
	L = (a1', a2', a3', a4', a6')  ,   where
.P
a1', ... ,a4', a6' are the coefficients of the transformed curve, given in Weierstrass normal form.
.TP 4
.B p
is a prime number.
.TP
.B a1, a2, a3, a4, a6
are elements of Z/pZ and the coefficients of the elliptic curve E, given in Weierstrass normal form.
.TP
.B r, s, t, u 
are elements of Z/pZ , u != 0. They define the birational transformation BT, by
.P
	x = u^2*x' + r,
	y = u^3*y' + u^2*s*x' + t.
	


.SH SEE ALSO
J. H. Silverman: The arithmetic of elliptic curves, p.49.
M*/

/*H
	Version 1       06.12.1990      Michael Pfeifer
	Version 2       27.08.1991      von 'arith1 nach 'ec1.  PS
   DATE ecmpbtco      : 910715.910915
H*/

#include <_ec1.h>

list ecmpbtco(p, a1, a2, a3, a4, a6, r, s, t, u)
	int             p, a1, a2, a3, a4, a6, r, s, t, u;
{
	int             a1s, a2s, a3s, a4s, a6s, h1, h2;

	bind(p, a1, a2, a3, a4, a6, r, s, t, u);

	init(a1s, a2s, a3s, a4s, a6s, h1, h2);

	h2 = u;

	/*
	 * Berechnung von a1' (hier a1s)
	 */

	a1s = a1;
	h1 = 2;
	h1 = miprod(p, h1, s);
	a1s = misum(p, a1s, h1);
	a1s = miquot(p, a1s, h2);

	/*
	 * Berechnung von a2' (hier a2s)
	 */

	h2 = miprod(p, h2, u);
	a2s = a2;
	h1 = miprod(p, s, a1);
	a2s = midif(p, a2s, h1);
	h1 = 3;
	h1 = miprod(p, h1, r);
	a2s = misum(p, a2s, h1);
	h1 = miprod(p, s, s);
	a2s = midif(p, a2s, h1);
	a2s = miquot(p, a2s, h2);

	/*
	 * Berechnung von a3' (hier a3s)
	 */

	h2 = miprod(p, h2, u);
	a3s = a3;
	h1 = miprod(p, r, a1);
	a3s = misum(p, a3s, h1);
	h1 = 2;
	h1 = miprod(p, h1, t);
	a3s = misum(p, a3s, h1);
	a3s = miquot(p, a3s, h2);

	/*
	 * Berechnung von a4' (hier a4s)
	 */

	h2 = miprod(p, h2, u);
	a4s = a4;
	h1 = miprod(p, s, a3);
	a4s = midif(p, a4s, h1);
	h1 = 2;
	h1 = miprod(p, h1, r);
	h1 = miprod(p, h1, a2);
	a4s = misum(p, a4s, h1);
	h1 = miprod(p, r, s);
	h1 = misum(p, h1, t);
	h1 = miprod(p, h1, a1);
	a4s = midif(p, a4s, h1);
	h1 = 3;
	h1 = miprod(p, h1, r);
	h1 = miprod(p, h1, r);
	a4s = misum(p, a4s, h1);
	h1 = 2;
	h1 = miprod(p, h1, s);
	h1 = miprod(p, h1, t);
	a4s = midif(p, a4s, h1);
	a4s = miquot(p, a4s, h2);

	/*
	 * Berechnung von a6' (hier a6s)
	 */

	h2 = miprod(p, h2, u);
	h2 = miprod(p, h2, u);
	a6s = a6;
	h1 = miprod(p, r, a4);
	a6s = misum(p, a6s, h1);
	h1 = miprod(p, r, r);
	h1 = miprod(p, h1, a2);
	a6s = misum(p, a6s, h1);
	h1 = miprod(p, r, r);
	h1 = miprod(p, h1, r);
	a6s = misum(p, a6s, h1);
	h1 = miprod(p, t, a3);
	a6s = midif(p, a6s, h1);
	h1 = miprod(p, t, t);
	a6s = midif(p, a6s, h1);
	h1 = miprod(p, t, r);
	h1 = miprod(p, h1, a1);
	a6s = midif(p, a6s, h1);
	a6s = miquot(p, a6s, h2);

	return (list5(a1s, a2s, a3s, a4s, a6s));
}
