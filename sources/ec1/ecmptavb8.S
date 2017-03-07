/*M
.SH NAME
ecmptavb8 - elliptic curve over modular primes Tate's values b2, b4, b6, b8

.SH SYNOPSIS
.nf
#include<_ec1.h>

list ecmptavb8(p, a1, a2, a3, a4, a6)
int p, a1, a2, a3, a4, a6;

.SH DESCRIPTION
.TP 4
.B p
is a prime number
.TP 4
.B a1, a2, a3, a4, a6
are elements of Z/pZ and the coefficients of the elliptic curve E over Z/pZ, given in Weierstrass normal form.
.P
ecmptavb8 computes the Tate's values b2, b4, b6, b8 of E, and returns them as a list of four elements.

.SH SEE ALSO
J.H. Silvermann,                                                                
The arithmetic of elliptic curves, p.46.      

M*/

/*H
	Version 1       05.12.1990      Michael Pfeifer
	Version 2	12.08.1991 	Kommentar und Parameterliste  
					geaendert. M.P.
	Version 3       27.08.1991      von 'arith1 nach 'ec1.  PS
   DATE ecmptavb8     : 910715.910915
H*/

#include <_ec1.h>

list            ecmptavb8(p, a1, a2, a3, a4, a6)
	int             p, a1, a2, a3, a4, a6;
{
	int             b8, h;
	list            L;

	bind(p, a1, a2, a3, a4, a6);

	init(b8, h);
	init(L);

	/*
	 * Berechnung von b8.
	 */

	h = miprod(p, a1, a1);
	h = miprod(p, a6, h);
	b8 = 4;
	b8 = miprod(p, a2, b8);
	b8 = miprod(p, a6, b8);
	b8 = misum(p, b8, h);
	h = miprod(p, a1, a3);
	h = miprod(p, a4, h);
	b8 = midif(p, b8, h);
	h = miprod(p, a2, a3);
	h = miprod(p, a3, h);
	b8 = misum(p, b8, h);
	h = miprod(p, a4, a4);
	b8 = midif(p, b8, h);

	/*
	 * Anhaengen an die Liste aus b2, b4 und b6.
	 */

	L = ecmptavb6(p, a1, a2, a3, a4, a6);
	L = lconc(L, list1(b8));

	return (L);
}
