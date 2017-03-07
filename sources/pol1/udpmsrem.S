/*M
.SH NAME
udpmsrem - univariate dense polynomial over modular singles remainder

.SH SYNOPSIS
.nf
#include<_pol1.h>

pol udpmsrem(m, P1, P2) 
single m; 
pol P1, P2;

.SH DESCRIPTION
.TP 4
.B m
 is a prime number, 0 < m <= BASIS.
.TP 4
.B P1, P2
 are univariate dense polynomials over Z/mZ,
 P2, P1 != 0, deg(P1) >= deg(P2).
.PP
udpmsrem returns the remainder on dividing P1 by P2.

.SH CAUTION
The list representing P1 will be changed, therefore it is recommended to use a copy of P1.

.SH SEE ALSO
 udpmsqrem
 udpmsquot

M*/

/*H
	Version 1	31.05.1987      B. Weis
	Version 2       13.10.1987      B. Weis
			Dokumentation geaendert
			init geaendert
   DATE udpmsrem      : 890501.9109__
H*/


#include <_pol1.h>

pol udpmsrem(m,P1,P2)
single m;
pol P1, P2;
{
	single c, e1, e2, k1, k2, k2s, s;
	pol P1S, P1SS, P2S, P3;
	bind(P1,P2);
	init(P1S,P1SS);

/* Initialisierungen */

	e2 = lfirst(P2);
	P3 = 0;

/* Grad von P2 groesser 0 */

	if (e2) {
		P2 = lred(P2);
		k2 = lfirst(P2);
		P2 = lred(P2);
		k2s = msinv(m,k2);
		do {
			e1 = lfirst(P1);
			P1S = lred(P1);
			s = -1;
			k1 = lfirst(P1S);
			P1SS = lred(P1S);
			c = msprod(m,k1,k2s);
			P2S = P2;
			do {
				k2 = lfirst(P2S);
				P2S = lred(P2S);
				k2 = msprod(m,k2,c);
				k1 = lfirst(P1SS);
				k1 = msdif(m,k1,k2);
				e1--;
				if (s < 0  &&  k1) {s = e1; P1 = P1S;}
				lsfirst(P1SS,k1);
				P1S = P1SS;
				P1SS = lred(P1S);
				}
			while (P2S != _0);
			while (s < 0  &&  P1SS != _0) {
				e1--;
				if (lfirst(P1SS)) {s = e1; P1 = P1S;}
				P1S = P1SS;
				P1SS = lred(P1S);
				}
			if (s >= 0) lsfirst(P1,s);
			}
		while (s >= e2);
		if (s >= 0) P3 = P1;
		}

/* Ausgabe */

	return(P3);
}
