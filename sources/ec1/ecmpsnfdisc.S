/*M
.SH NAME
ecmpsnfdisc - elliptic curve over modular primes, short normal form, discriminant
.SH SYNOPSIS
.nf
#include<_ec1.h>

int ecmpsnfdisc(p, a4, a6)
int p, a4, a6;

.SH DESCRIPTION
ecmpsnfdisc returns the discriminant of the cubic curve E.
.TP 4                                                                           
.B p                                                                            
is a prime                                                                      
.TP 4                                                                           
.B a4, a6                                                                       
are elements of Z/pZ, defining the cubic curve E, represented in short Weierstrass normal form.
.SH SEE ALSO
J.H. Silvermann,                                                                
The arithmetic of elliptic curves, p.50.  
M*/

/*H
	Version 1       06.12.1990      Michael Pfeifer
	Version 2       27.08.1991      von 'arith1 nach 'ec1.  PS
   DATE ecmpsnfdisc   : 910715.910915
H*/

#include <_ec1.h>

int ecmpsnfdisc(p, a4, a6)
	int             p, a4, a6;
{
	int             D, h;

	bind(p, a4, a6);

	init(D, h);

	/*
	 * Berechnung der Diskriminante
	 */

	h = 27;
	h = miprod(p, a6, h);
	h = miprod(p, a6, h);
	D = 4;
	D = miprod(p, D, a4);
	D = miprod(p, D, a4);
	D = miprod(p, D, a4);
	D = misum(p, D, h);
	h = 16;
	h = mineg(p, h);
	D = miprod(p, D, h);
	D = mihom(p, D);

	return (D);
}
