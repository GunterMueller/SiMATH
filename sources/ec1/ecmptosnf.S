/*M
.SH NAME
ecmptosnf - elliptic curve over modular primes to short normal form

.SH SYNOPSIS
.nf
#include<_ec1.h>

list ecmptosnf(p, a1, a2, a3, a4, a6)  
int p, a1, a2, a3, a4, a6;

.SH DESCRIPTION
.TP 4                                                                           
.B p                                                                            
is a prime number greater or equal 5.                                           
.TP 4                                                                           
.B a1, a2, a3, a4, a6                                                           
are elements of Z/pZ and the coefficients of the elliptic curve E over Z/pZ, given in Weierstrass normal form.
.PP
ecmptosnf computes a curve E' in short Weierstrass normal form with coefficients a and b, which is bi-rational isomorphic to E.
E' is given by the following  transformation : 
.TP 4
.PP
 x = u^2 * x' + r,
 y = u^3 * y' + u^2 * s * x' + t,
 z = z'.
.PP
ecmptosnf returns a list L, (say), containing two other lists:
.TB 4
.PP
L = (( a b ) ( r s t u )).
                     
.SH SEE ALSO
J.H. Silvermann,                                                                
The arithmetic of elliptic curves, p.48.         
M*/

/*H
	Version 1       07.12.1990      Michael Pfeifer
	Version 2       27.08.1991      von 'arith1 nach 'ec1.  PS
	Version 3       07.09.1993      Fehler in der Berechnung der
	                                Transformation beseitigt.  MP
   DATE ecmptosnf     : 910715.910915.931130
H*/

#include <_ec1.h>

list            ecmptosnf(p, a1, a2, a3, a4, a6)
	int             p, a1, a2, a3, a4, a6;
{
	int             c4, c6, a, b, r, s, t, u, h;
	list            C, T;

	bind(p, a1, a2, a3, a4, a6);

	init(c4, c6, a, b, r, s, t, u, h);
	init(C, T);

	/*
	 * Berechnung von c4 und c6
	 */

	C = ecmptavc6(p, a1, a2, a3, a4, a6);
	c4 = lfirst(C);
	c6 = lsecond(C);

	/*
	 * Berechnung der kurzen Weierstrass-Normalform
	 */

	h = -27;
	a = miprod(p, c4, h);
	h = -54;
	b = miprod(p, c6, h);
	C = list2(a, b);

	/*
	 * Berechnung der Transformation
	 */

	/*
	 * s = -a1 / 2
	 */

	s = miquot(p, mineg(p, a1), 2);

	/*
	 * r = (s^2 + a1*s - a2) / 3
	 */

	r = miprod(p, s, s);
	h = miprod(p, a1, s);
	r = misum(p, r, h);
	r = midif(p, r, a2);
	r = miquot(p, r, 3);

	/*
	 * t = (-a1*r - a3) / 2
	 */

	t = miprod(p, mineg(p, a1), r);
	t = midif(p, t, a3);
	t = miquot(p, t, 2);

	u = miinv(p, 6);

	T = list4(r, s, t, u);

	return (list2(C, T));
}
