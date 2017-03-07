/*M
.SH NAME
ecmpsnfneg - elliptic curve over modular primes, short normal form, negative point

.SH SYNOPSIS
.nf
#include<_ec1.h>

list ecmpsnfneg(p, a4, a6, P1)
int p, a4, a6;
list P1(x, y, z);
int x, y, z;

.SH DESCRIPTION
ecmpsnfneg computes the negativ of the point P as projectiv point and returns it as a list of 3 rational numbers.
.TP 4                                                                           
.B p                                                                            
is a prime                                                                      
.TP 4                                                                           
.B a4, a6                                                           
are elements of Z/pZ, defining the elliptic curve E, represented in short Weierstrass normal form.
.TP 4                                                                           
.B P1                                                                           
is a list of 3 elements of Z/pZ, defining the projective point P of E.   
                               
M*/

/*H
	Version 1       07.12.1990      Michael Pfeifer
	Version 2 	21.08.1991	mshom --> mihom. M.P.
	Version 3       27.08.1991      von 'arith1 nach 'ec1.  PS
   DATE ecmpsnfneg    : 910715.910915
H*/

#include <_ec1.h>

list            ecmpsnfneg(p, a4, a6, P)
	int             p, a4, a6;
	list            P;
{
	int             x, y, z, h;

	bind(p, a4, a6, P);

	init(x, y, z, h);

	x = lfirst(P);
	y = lsecond(P);
	z = lthird(P);

	/*
	 * Berechnung des additiv inversen Punktes.
	 */

	if (z != 0)
	{
		x = miquot(p, x, z);
		y = miquot(p, y, z);
		z = 1;
		y = mineg(p, y);
		x = mihom(p, x);
		y = mihom(p, y);
	}
	else
	{
		x = 0;
		y = 1;
		z = 0;
	}
	return (list3(x, y, z));
}
