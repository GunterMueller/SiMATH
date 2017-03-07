/*M
.SH NAME
ecmpsnfmul - elliptic curve over modular primes, short normal form, multiplication-map
.SH SYNOPSIS
.nf
#include<_ec1.h>

list ecmpsnfmul(p, a4, a6, n, P1)
int p, a4, a6;
single n;
list P1(x, y, z);
int x, y, z;

.SH DESCRIPTION
ecmpsnfmul computes the multiple of the point P :
.TP 4
 Pn = n*P = (xn, yn, zn) ,
.TP 0
 and returns it as a list of 3 rational numbers.
.TP 4                                                                           
.B p                                                                            
is a prime                                                                      
.TP 4                                                                           
.B a4, a6                                                                       
are elements of Z/pZ, defining the elliptic curve E, represented in short Weierstrass normal form.
.TP 4                                                                           
.B P1                                                                           
is a  list of 3 elements of Z/pZ, defining the projective point P of E.
.TP 4
.B n
is a natural number.  
M*/

/*H
	Version 1       07.12.1990      Michael Pfeifer
	Version 2       21.08.1991      n nicht mehr auf single-Werte
					beschraenkt. M.P.
	Version 3       27.08.1991      von 'arith1 nach 'ec1.  PS
   DATE ecmpsnfmul    : 910715.910915
H*/

#include <_ec1.h>

list            ecmpsnfmul(p, a4, a6, n, P1)
	int             n, p, a4, a6;
	list            P1;
{
	list            P2, Pn;
	int             m, h;

	bind(p, a4, a6, n, P1);

	init(P2, Pn);
	init(m, h);

	/*
	 * Standarddarstellung des projektiven Punktes P1.
	 */

	P1 = ecmpsrpp(p, P1);

	/*
	 * Vorbereitungen, Initialisierungen.
	 */

	m = 1;
	h = n;
	P2 = lcopy(P1);
	Pn = list3(0, 1, 0);

	while (icomp(m, n) <= 0)
	{
		if (mshom(2, h) == 1)
		{
			Pn = ecmpsnfsum(p, a4, a6, P2, Pn);
		}

		m = isprod(m, 2);

		h = isquot(h, 2);

		P2 = ecmpsnfsum(p, a4, a6, P2, P2);
	}
	return (Pn);
}
