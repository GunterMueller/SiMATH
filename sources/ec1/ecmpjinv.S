/*M
.SH NAME
ecmpjinv - elliptic curve over modular primes, j-invariant

.SH SYNOPSIS
.nf
#include<_ec1.h>

int ecmpjinv(p, a1, a2, a3, a4, a6)
int p, a1, a2, a3, a4, a6;

.SH DESCRIPTION
ecmpjinv returns the j-invariant of the elliptic curve E.
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
   DATE ecmpjinv      : 910715.910915
H*/

#include <_ec1.h>

int ecmpjinv(p, a1, a2, a3, a4, a6)
	int             p, a1, a2, a3, a4, a6;
{
	int             h, c4, j;
	list            L;

	bind(p, a1, a2, a3, a4, a6);

	init(h, c4, j);
	init(L);

	/*
	 * Berechnung von c4 und D (hier D = j)
	 */

	L = ecmptavc6(p, a1, a2, a3, a4, a6);
	c4 = lfirst(L);
	j = ecmpdisc(p, a1, a2, a3, a4, a6);

	/*
	 * Berechnung der j-Invarianten
	 */

	h = miprod(p, c4, c4);
	h = miprod(p, c4, h);
	j = miquot(p, h, j);

	return (j);
}
