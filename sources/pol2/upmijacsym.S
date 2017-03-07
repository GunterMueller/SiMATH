/*M
.SH NAME
upmijacsym - univariate polynomial over modular integers Jacobi-symbol

.SH SYNOPSIS
.nf
#include<_pol2.h>

single upmijacsym(p, P1, P2)  
int p; 
pol P1, P2;
 
.SH DESCRIPTION
.TP 4
.B p
is a prime number.
.TP 4
.B P1, P2
are coprime univariate polynomials over Z/pZ, nonequal to 0, P2 is monic.
.PP
upmijacsym returns the Jacobi-symbol [P1/P2].

M*/

/*H
	Version 1 	16.08.91	J.Schmitt
   DATE upmijacsym    : 910915
H*/

#include <_pol2.h>

single upmijacsym(m,P1,P2)
int m;
pol P1, P2;
{
	single erg=1;
	int a;
	init(a);
	bind(m,P1,P2);

/* Aufbereiten der Eingabe */

	P1 = pmirem(1,m,P1,P2);

/* Anwendung des Reziprozitaetsgesetzes und Ergaenzungssatzes */

	while (lfirst(P1)) {
		a = lsecond(P1);
		if (sodd(lfirst(P2))) erg = erg * ijacsym(a,m);
		a = miinv(m,a);
		P1 = pmimiprod(1,m,P1,a);
		if (sodd(lfirst(P1))  &&  sodd(lfirst(P2))) 
					erg = erg * ijacsym(-1,m);
		a = P1;
		P1 = P2;
		P2 = a;
		P1 = pmirem(1,m,P1,P2);
		}
	if (sodd(lfirst(P2))) erg = erg * ijacsym(lsecond(P1),m);

/* Ausgabe */

	return(erg);
}
