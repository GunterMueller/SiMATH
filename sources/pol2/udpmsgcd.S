/*M
.SH NAME
udpmsgcd - univariate dense polynomial over modular singles greatest common divisor

.SH SYNOPSIS
.nf
#include<_pol2.h>

pol udpmsgcd(p, P1, P2) 
single p; 
pol P1, P2;

.SH DESCRIPTION
.TP 4
.B p
is a prime number, p < BASIS.
.TP 4
.B P1, P2
are univariate polynomials in dense representation over Z/pZ.
.PP
udpmsgcd returns the greatest common divisor of P1 and P2.

M*/

/*H
	Version 1	31.05.1987      B. Weis
	Version 2       19.01.1988      B. Weis
			Aufruf von udpmsqrem berichtigt
   DATE udpmsgcd      : 890501.9109__
H*/


#include <_pol2.h>

pol udpmsgcd(m,P1,P2)
single m;
pol P1, P2;
{
	single k;
	pol P3;
	bind2(P1,P2);
	init(P3);

/* P1 gleich 0 */

	if (P1 == 0) P3 = P2;

/* P2 gleich 0 */

	else if (P2 == 0) P3 = P1;

/* allgemeiner Fall: P1,P2 ungleich 0 */

	else {
		if (lfirst(P1) < lfirst(P2)) {
			P3 = P2;
			P2 = P1;
			P1 = P3;
			}
		do {
			udpmsqrem(m,P1,P2,&P3);
			P1 = P2;
			P2 = P3;
			}
		while (P2 != 0);
		P3 = P1;
		}
	if (P3) {
		P1 = P3;
		k = lfirst(P3);
		P3 = list2(1,k);
		P1 = lred(P1);
		P2 = msinv(m,lfirst(P1));
		P1 = lred(P1);
		while (P1 != _0) {
			k = msprod(m,lfirst(P1),P2);
			P3 = lcomp(k,P3);
			P1 = lred(P1);
			}
		P3 = linv(P3);
		}

/* Ausgabe */

	return(P3);
}
