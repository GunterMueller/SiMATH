/*M
.SH NAME
udpmsjacsym - univariate dense polynomial over modular singles Jacobi-symbol

.SH SYNOPSIS
.nf
#include<_pol2.h>

single udpmsjacsym(p, P1, P2) 
single p; 
pol P1, P2;
  
.SH DESCRIPTION
.TP 4                                                                           
.B p                                                                            
is a prime number, 2 < p < BASIS.                                             
.TP 4                                                                           
.B P1, P2                                                                       
are coprime univariate polynomials in dense representation over Z/pZ, nonequal to 0, P2 is monic.
.PP                                                                             
udpmijacsym returns the Jacobi-symbol [P1/P2].                                  
                                                                                
.SH CAUTION                                                                     
The lists, representing P1 and P2 will be changed !                              
M*/

/*H
	Version 1	31.05.1987      B. Weis
   DATE udpmsjacsym   : 890501.9011__
H*/


#include <_pol2.h>

single udpmsjacsym(m,P1,P2)
single m;
pol P1, P2;
{
	single erg=1, a, b;
	pol P3;
	bind2(P1,P2);

/* Aufbereiten der Eingabe */

	P1 = udpmsrem(m,P1,P2);

/* Anwendung des Reziprozitaetsgesetzes und Ergaenzungssatzes */

	while (lfirst(P1)) {
		a = lsecond(P1);
		if (sodd(lfirst(P2))) erg = erg * ijacsym(a,m);
		a = msinv(m,a);
		P3 = lred(P1);
		while (P3 != _0) {
			b = lfirst(P3);
			b = msprod(m,a,b);
			lsfirst(P3,b);
			P3 = lred(P3);
			}
		if (sodd(lfirst(P1))  &&  sodd(lfirst(P2))) erg = erg * ijacsym(-1,m);
		a = P1;
		P1 = P2;
		P2 = a;
		P1 = udpmsrem(m,P1,P2);
		}
	if (sodd(lfirst(P2))) erg = erg * ijacsym(lsecond(P1),m);

/* Ausgabe */

	return(erg);
}
