/*M
.SH NAME
ecmplp - elliptic curve over modular primes, line through points

.SH SYNOPSIS
.nf
#include<_ec1.h>

list ecmplp(p, a1, a2, a3, a4, a6, P1, Q1)
int p, a1, a2, a3, a4, a6;  
list P1, Q1;

.SH DESCRIPTION
ecmplp computes the line G trough the points P and Q, or the tangent to P, if P = Q.
.P
.IP 
G: y = l * x + n.
.P
If possible, ecmplp returns the list:
.P
.IP 
 L = ( l n ),
or 
 L = ( 0 ),	for P = -Q 
 L = ( 1 ),	for P point at infinity
 L = ( 2 ),	for Q point at infinity
.TP 4 
.B p
is a prime
.TP 4
.B a1, a2, a3, a4, a6
are elements of Z/pZ and the coefficients of the elliptic curve E.
.TP 4                                                                           
.B P1, Q1
are lists of 3 elements of Z/pZ, defining the projective points P and Q of E.

.SH SEE ALSO
J.H. Silvermann,                                                                
The arithmetic of elliptic curves, p.58.
M*/

/*H
	Version 1       06.12.1990      Michael Pfeifer
	Version 2	21.08.1991	"," hinter einer Anweisung durch
					";" ersetzt. M.P.
	Version 3       27.08.1991      von 'arith1 nach 'ec1.  PS
   DATE ecmplp        : 910715.910915
H*/

#include <_ec1.h>

list            ecmplp(p, a1, a2, a3, a4, a6, P1, P2)
	int             p, a1, a2, a3, a4, a6;
	list            P1, P2;
{
	int             l, n, h, h1, h2, x1, y1, x2, y2;
	list            Q, L;

	bind(p, a1, a2, a3, a4, a6, P1, P2);

	init(l, n, h, h1, h2, x1, y1, x2, y2);
	init(Q, L);

	/*
	 * Standarddarstellung der Punkte.
	 */

	Q = ecmpsrpp(p, P1);
	x1 = lfirst(Q);
	y1 = lsecond(Q);
	Q = ecmpsrpp(p, P2);
	x2 = lfirst(Q);
	y2 = lsecond(Q);

	/*
	 * Test: P1 = -P2 ?
	 */

	Q = ecmpneg(p, a1, a2, a3, a4, a6, P2);
	if (isppecmpeq(p, P1, Q))
	{
		return (list1(0));
	}

	/*
	 * Test: P1 = (0, 1, 0) oder P2 = (0, 1, 0) ?
	 */

	if (isppecmppai(p, P1))
	{
		return (list1(1));
	}
	if (isppecmppai(p, P2))
	{
		return (list1(2));
	}

	/*
	 * Berechnung von l und n.
	 */

	if (oequal(x1, x2))
	{
		h = 3;
		h = miprod(p, x1, h);
		h = miprod(p, x1, h);
		h1 = 2;
		h1 = miprod(p, a2, h1);
		h1 = miprod(p, x1, h1);
		h1 = misum(p, h1, h);
		h1 = misum(p, h1, a4);
		h = miprod(p, a1, y1);
		h1 = midif(p, h1, h);
		h2 = 2;
		h2 = miprod(p, y1, h2);
		h = miprod(p, a1, x1);
		h2 = misum(p, h2, h);
		h2 = misum(p, h2, a3);
		l = miquot(p,h1,h2);

		n = miprod(p,l,x1);
		n = midif(p,y1, n);
	}
	else
	{
		h1 = midif(p, y2, y1);
		h2 = midif(p, x2, x1);
		l = miquot(p, h1, h2);

		n = miprod(p,l,x1);
		n = midif(p,y1,n);
	}

	return (list2(l, n));
}
