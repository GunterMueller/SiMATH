/*M
.SH NAME
ecmptavb6 - elliptic curve over modular primes Tate's values b2, b4, b6

.SH SYNOPSIS
.nf
#include<_ec1.h>

list ecmptavb6(p, a1, a2, a3, a4, a6)  
int p, a1, a2, a3, a4, a6;

.SH DESCRIPTION
.TP 4                                                                           
.B p                                                                            
is a prime number                                                               
.TP 4                                                                           
.B a1, a2, a3, a4, a6                                                           
are elements of Z/pZ and the coefficients of the cubic curve E over Z/pZ, given in Weierstrass normal form.
.P
ecmptavb6 computes the Tate's values b2, b4, b6 of E, and returns them as a list of three elements.
     
. SH SEE ALSO
J.H. Silvermann,                                                                
The arithmetic of elliptic curves, p.46.
M*/

/*H
	Version 1       06.12.1990      Michael Pfeifer
	Version 2       27.08.1991      von 'arith1 nach 'ec1.  PS
   DATE ecmptavb6     : 910715.910915
H*/

#include <_ec1.h>

list ecmptavb6(p, a1, a2, a3, a4, a6)
	int             p, a1, a2, a3, a4, a6;
{
	int             b2, b4, b6, h;

	bind(p, a1, a2, a3, a4, a6);

	init(b2, b4, b6, h);

	/*
	 * Berechnung von b2, b4 und b6
	 */

	h = 4;
	h = miprod(p, a2, h);
	b2 = miprod(p, a1, a1);
	b2 = misum(p, b2, h);
	h = 2;
	h = miprod(p, a4, h);
	b4 = miprod(p, a1, a3);
	b4 = misum(p, b4, h);
	h = 4;
	h = miprod(p, a6, h);
	b6 = miprod(p, a3, a3);
	b6 = misum(p, b6, h);

	return (list3(b2, b4, b6));
}
