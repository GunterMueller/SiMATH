/*M
.SH NAME
ecmpdisc - elliptic curve over modular primes, discriminant

.SH SYNOPSIS
.nf
#include<_ec1.h>

int ecmpdisc(p, a1, a2, a3, a4, a6)
int p, a1, a2, a3, a4, a6;

.SH DESCRIPTION
ecmpdisc returns the discriminant of the cubic curve E.
.TP 4                                                                           
.B p                                                                            
is a prime                                                                      
.TP 4                                                                           
.B a1, a2, a3, a4, a6                                                           
are elements of Z/pZ and the coefficients of E, represented in Weierstrass normal form.
.SH SEE ALSO
J.H. Silvermann,                                                                
The arithmetic of elliptic curves, p.46. 

M*/

/*H
	Version 1       06.12.1990      Michael Pfeifer
	Version 2       27.08.1991      von 'arith1 nach 'ec1.  PS
   DATE ecmpdisc      : 910715.910915
H*/

#include <_ec1.h>

int ecmpdisc(p, a1, a2, a3, a4, a6)
	int             p, a1, a2, a3, a4, a6;
{
	int             b2, b4, b6, b8, h1, h2, D;
	list            L;

	bind(p, a1, a2, a3, a4, a6);

	init(b2, b4, b6, b8, h1, h2, D);
	init(L);

	/*
	 * Berechnung von b2, b4, b6 und b8
	 */

	L = ecmptavb8(p, a1, a2, a3, a4, a6);
	b2 = lfirst(L);
	b4 = lsecond(L);
	b6 = lthird(L);
	b8 = lfourth(L);

	/*
	 * Berechnung der Diskriminante
	 */

	D = miprod(p, b4, miprod(p, b4, b4));
	h1 = miprod(p, 27, miprod(p, b6, b6));
	D = midif(p, D, h1);
	h1 = miprod(p, 36, b4);
	h2 = miprod(p, b2, b2);
	h1 = midif(p, h1, h2);
	h1 = miprod(p, b8, h1);
	D = misum(p, D, h1);

	return (D);
}
