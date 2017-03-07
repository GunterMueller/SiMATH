/*c
			ptosdp( r, P )

	"polynomial to special distributive polynomial" (rekursiv)
	Quellbibliothek: srclib.pol1
	Include-Datei:   _pol1.h
	pol ptosdp(r,P)  single r; pol P;
	P1 = ptosdp(r,P);
	P ist ein Polynom in r (0<=r<BASIS) Variablen.
	P1 = P  (spezielle distributive Darstellung).
c*/
/*H
	Version 1	31.05.1987      B. Weis
   DATE ptosdp        : 890501.9107__
H*/


#include <_pol1.h>

pol ptosdp(r,P)
single r;
pol P;
{
	single eP, rs;
	list ekP;
	pol P1, kP, kP1;
	bind(P);
	init4(P1,kP,kP1,ekP);

/* P gleich 0*/

	if (P == 0) P1 = 0;

/* r gleich 0 */

	else if (r == 0) P1 = list2(P,_0);

/* allgemeiner Fall: P,r ungleich 0 */

	else {
		P1 = _0;
		rs = r-1;
		do {
			eP = lfirst(P);
			P = lred(P);
			kP = lfirst(P);
			P = lred(P);
			kP = ptosdp(rs,kP);
			do {
				kP1 = lfirst(kP);
				kP = lred(kP);
				ekP = lfirst(kP);
				kP = lred(kP);
				if (eP) ekP = lcomp2(r,eP,ekP);
				P1 = lcomp2(ekP,kP1,P1);
				}
			while (kP != _0);
			}
		while (P != _0);
		P1 = linv(P1);
		}

/* Ausgabe */

	return(P1);
}
