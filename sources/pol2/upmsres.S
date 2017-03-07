/*M
.SH NAME
upmsres - univariate polynomial over modular singles resultant

.SH SYNOPSIS
.nf
#include<_pol2.h>

single upmsres(p, P1, P2) 
single p; 
pol P1, P2;
 
.SH DESCRIPTION
.TP 4
.B p
is a prime number, p < BASIS.
.TP 4
.B P1, P2
are univariate polynomials over Z/pZ of degree greater or equal to 1.
.PP
upmsres returns the resultant of P1 and P2.

M*/

/*H
	Version 1	31.05.1987      B. Weis
	Version 2       31.07.1987      B. Weis
			Fehler in erster for-Schleife beseitigt
   DATE upmsres       : 890501.8908__
H*/


#include <_pol2.h>

single upmsres(m,P1,P2)
single m;
pol P1, P2;
{
	single a, as, eP1, eP2, eP3, i, s;
	pol P3;
	bind2(P1,P2);
	init(P3);

/* Initialisierungen */

	a = 1;
	P1 = ptodp(1,P1);
	P2 = ptodp(1,P2);
	eP1 = lfirst(P1);
	eP2 = lfirst(P2);
	s = 0;
	if (eP1 < eP2) {
		if (sodd(eP1)  &&  sodd(eP2)) s = 1;
		P3 = P1;
		P1 = P2;
		P2 = P3;
		}

/* Berechnung von a */

	do {
		P3 = udpmsrem(m,P1,P2);
		if (!P3) {a = 0; break;}
		eP1 = lfirst(P1);
		eP2 = lfirst(P2);
		eP3 = lfirst(P3);
		if (sodd(eP1)  &&  sodd(eP2)) s = 1-s;
		as = lsecond(P2);
		for (i = eP1-eP3; i; i--) a = msprod(m,a,as);
		P1 = P2;
		P2 = P3;
		}
	while (eP3);
	if (a) {
		as = lsecond(P2);
		for (i = eP2; i; i--) a = msprod(m,a,as);
		if (s) a = m-a;
		}

/* Ausgabe */

	return(a);
}
