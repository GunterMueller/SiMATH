/*M
.SH NAME
upmsjacsym - univariate polynomial over modular singles Jacobi-symbol

.SH SYNOPSIS
.nf
#include<_pol2.h>

single upmsjacsym(p, P1, P2) 
single p; 
pol P1, P2;
    
.SH DESCRIPTION
.TP 4
.B p
is a prime number, 2 < p < BASIS.
.TP 4
.B P1, P2
are coprime univariate polynomials over Z/pZ, nonequal to 0, P2 is monic.
.PP
upmsjacsym returns the Jacobi-symbol [P1/P2].

M*/

/*H
	Version 1	31.05.1987      B. Weis
   DATE upmsjacsym    : 890501.9011__
H*/


#include <_pol2.h>

single upmsjacsym(m,P1,P2)
single m;
pol P1, P2;
{
	single erg=1, a;
	bind2(P1,P2);

/* Aufbereiten der Eingabe */

	P1 = pmsrem(1,m,P1,P2);

/* Anwendung des Reziprozitaetsgesetzes und Ergaenzungssatzes */

	while (lfirst(P1)) {
		a = lsecond(P1);
		if (sodd(lfirst(P2))) erg = erg * ijacsym(a,m);
		a = msinv(m,a);
		P1 = pmsmsprod(1,m,P1,a);
		if (sodd(lfirst(P1))  &&  sodd(lfirst(P2))) erg = erg * ijacsym(-1,m);
		a = P1;
		P1 = P2;
		P2 = a;
		P1 = pmsrem(1,m,P1,P2);
		}
	if (sodd(lfirst(P2))) erg = erg * ijacsym(lsecond(P1),m);

/* Ausgabe */

	return(erg);
}
