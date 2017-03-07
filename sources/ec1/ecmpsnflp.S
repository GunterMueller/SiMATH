/*M
.SH NAME
ecmpsnflp - elliptic curve over modular primes, short normal form, line through points

.SH SYNOPSIS
.nf
#include<_ec1.h>

list ecmpsnflp(p, a4, a6, P1, Q1)  
int p, a4, a6;  
list P1, Q1;

.SH DESCRIPTION
ecmpsnflp computes the line G trough the points P and Q, or, if P = Q, the tangent to P.
.P                                                                              
.IP                                                                             
G: y = l * x + n.                                                               
.P                                                                              
If possible, ecmplp returns the list:                                           
.P                                                                              
.IP                                                                             
 L = ( l n ),                                                                   
or                                                                              
 L = ( 0 ),     for P = -Q                                                      
 L = ( 1 ),     for P point at infinity                                         
 L = ( 2 ),     for Q point at infinity                                         
.TP 4                                                                           
.B p                                                                            
is a prime number                                                              
.TP 4                                                                           
.B a4, a6                                                           
are elements of Z/pZ and the coefficients of the elliptic curve E in short Weierstrass normal form.              
.TP 4                                                                           
.B P1, Q1                                                                       
are lists of 3 elements of Z/pZ, defining the projective points P and Q of E.
 
.SH SEE ALSO
J.H. Silvermann,                                                                
The arithmetic of elliptic curves, p.58. 
M*/

/*H
	Version 1       16.01.1990      Michael Pfeifer
	Version 2       27.08.1991      von 'arith1 nach 'ec1.  PS
   DATE ecmpsnflp     : 910715.910915
H*/

#include <_ec1.h>

list ecmpsnflp(p, a4, a6, P1, P2)
	int             p, a4, a6;
	list            P1, P2;
{
	int             l, n, h, h1, h2;
	int             x1, y1, x2, y2;
	list            Q, L;

	bind(p, a4, a6, P1, P2);

	init(l, n, h, h1, h2);
	init(x1, y1, x2, y2);
	init(Q, L);

	/*
	 * Standarddarstellungen der Punkte
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

	Q = ecmpsnfneg(p, a4, a6, P2);
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
	 * Berechnung von l und n
	 */

	if (oequal(x1, x2))
	{
		h = 3;
		h = miprod(p, x1, h);
		h = miprod(p, x1, h);
		h1 = misum(p, a4, h);
		h = 2;
		h2 = miprod(p, h, y1);
		l = miquot(p,h1,h2);

		n = miprod(p,l,x1);
		n = midif(p,y1,n);
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
