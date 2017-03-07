/*M
.SH NAME
udpmijacsym - univariate dense polynomial over modular integers Jacobi-symbol

.SH SYNOPSIS
.nf
#include<_pol2.h>

single udpmijacsym(p, P1, P2)  
int p; 
pol P1, P2;
 
.SH DESCRIPTION
.TP 4
.B p
is a prime number.
.TP 4
.B P1, P2
are coprime univariate polynomials in dense representation over Z/pZ, nonequal to 0, P2 is monic.
.PP
udpmijacsym returns the Jacobi-symbol [P1/P2].

.SH CAUTION
The lists, representing P1 and P2 will be changed !
 
M*/

/*H
	Version 1 	16.08.91	J.Schmitt
   DATE udpmijacsym   : 910915
H*/

#include <_pol2.h>

single udpmijacsym(m,P1,P2)
int m;
pol P1, P2;
{
	single erg=1;
	int a, b;
	pol P3;
	init(a,b,P3);
	bind(m,P1,P2);

/* Aufbereiten der Eingabe */

	P1 = udpmirem(m,P1,P2);

/* Anwendung des Reziprozitaetsgesetzes und Ergaenzungssatzes */

	while (lfirst(P1)) {
		a = lsecond(P1);
		if (sodd(lfirst(P2))) erg = erg * ijacsym(a,m);
		a = miinv(m,a);
		P3 = lred(P1);
		while (P3 != _0) {
			b = lfirst(P3);
			b = miprod(m,a,b);
			lsfirst(P3,b);
			P3 = lred(P3);
		}
		if (sodd(lfirst(P1))  &&  sodd(lfirst(P2))) 
					erg = erg * ijacsym(-1,m);
		a = P1;
		P1 = P2;
		P2 = a;
		P1 = udpmirem(m,P1,P2);
	}
	if (sodd(lfirst(P2))) erg = erg * ijacsym(lsecond(P1),m);

/* Ausgabe */

	return(erg);
}
