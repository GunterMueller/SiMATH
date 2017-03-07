/*M
.SH NAME
ecmpsnfjinv - elliptic curve over modular primes, short normal form, j-invariant
.SH SYNOPSIS
.nf
#include<_ec1.h>

int ecmpsnfjinv(p, a4, a6)
int p, a4, a6;

.SH DESCRIPTION
ecmpsnfjinv returns the j-invariant of the elliptic curve E.
.TP 4                                                                           
.B p                                                                            
is a prime                                                                      
.TP 4                                                                           
.B a4, a6                                                                       
are elements of Z/pZ, defining the elliptic curve E, represented in short Weierstrass normal form.

.SH SEE ALSO
J.H. Silvermann,                                                                
The arithmetic of elliptic curves, p.50.        
M*/

/*H
	Version 1       06.12.1990      Michael Pfeifer
	Version 2       27.08.1991      von 'arith1 nach 'ec1.  PS
   DATE ecmpsnfjinv   : 910715.910915
H*/

#include <_ec1.h>

int ecmpsnfjinv(p, a4, a6)
	int             p, a4, a6;
{
	int             j, D, h;

	bind(p, a4, a6);

	init(j, D, h);

	/*
	 * Berechnung der Diskriminante
	 */

	D = ecmpsnfdisc(p, a4, a6);

	/*
	 * Berechnung der j-Invariante
	 */

	j = 64;
	j = miprod(p, j, a4);
	j = miprod(p, j, a4);
	j = miprod(p, j, a4);
	h = 1728;
	h = mineg(p, h);
	j = miprod(p, j, h);
	j = miquot(p, j, D);
	j = mihom(p, j);

	return (j);
}
