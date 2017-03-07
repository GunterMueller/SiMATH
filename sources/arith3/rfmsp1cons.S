/*M
.SH NAME
rfmsp1cons - rational function over modular single prime construction, transcendence degree 1

.SH SYNOPSIS
.nf
#include<_arith3.h>

rfunc rfmsp1cons(p, P1, P2) 
single p; 
pol P1, P2;

.SH DESCRIPTION
.TP 4
.B p
is a prime number, p < BASIS.
.TP 4
.B P1, P2
are polynomials in Z/pZ[X], P2 != 0.
.PP
rfmsp1cons returns a rational function, say R, where R is the fraction P1/P2 in its lowest terms.

M*/
          
/*H
	Version 1       15.04.1988      B. Weis
	Version 2       07.10.1988      rfunc eingefuehrt
					J.Schmitt
   DATE rfmsp1cons    : 890501
H*/


#include <_arith3.h>

rfunc rfmsp1cons(p,P1,P2)
single p;
pol P1, P2;
{
	single a;
	pol R;
	bind(P1,P2);
	init(R);

/* P1 ungleich 0 */

	if (P1) {
		R = upmsgcd(p,P1,P2);
		P1 = pmsquot(1,p,P1,R);
		P2 = pmsquot(1,p,P2,R);
		a = lsecond(P2);
		if (a != 1) a = msinv(p,a), P1 = pmsmsprod(1,p,P1,a), P2 = pmsmsprod(1,p,P2,a);
		R = list2(P1,P2);
		}

/* Ausgabe */

	return(R);
}
