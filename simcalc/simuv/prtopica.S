/*C
			prtopica(r,P,ps)

	"polynomial over rationals to polynomial over integers, if
	possible, calculator".
	pol prtopica(r,P,ps) single r; pol P; single *ps;
	P1 = prtopica(r,P,ps);

	P ist ein Polynom in r (0<=r<BASIS) Variablen ueber den
	rationalen Zahlen.
	P1 = P, und zwar als Polynom ueber den ganzen Zahlen Z,
		falls die Basis-Koeffizienten von P schon in Z
		liegen; in diesem Fall ist *ps gleich 1;
		sonst ist P1 Polynom ueber den rationalen Zahlen
		und *ps gleich 0.
	Die include-Datei <_arith3.h> wird benoetigt.
C*/
/*H
	Version  1      24.11.1987      B. Weis
H*/
/*cS
	prtopica ruft auf: diptop, linv, ptodip

		 Macros: lcomp2, lfirst, lred, lred2, lsecond
Sc*/

#include<_arith3.h>

pol prtopica(r,P,ps)
single r;
pol P;
single *ps;
{
	rat A;
	list E;
	pol P1, PS;
	bind(P);
	init4(A,E,P1,PS);

	*ps = 1;
	if ( P == 0 ) P1 = P;
	else if (!r) {
		if (lsecond(P) == 1) P1 = lfirst(P);
		else {P1 = P; *ps = 0;}
		}
	else {
		PS = ptodip(r,P);
		P1 = PS;
		while (P1 != _0) {
			A = lfirst(P1);
			P1 = lred2(P1);
			if (lsecond(A) != 1) {*ps = 0; break;}
			}
		if (*ps) {
			P1 = _0;
			while (PS != _0) {
				A = lfirst(PS);
				PS = lred(PS);
				E = lfirst(PS);
				PS = lred(PS);
				A = lfirst(A);
				P1 = lcomp2(E,A,P1);
				}
			P1 = linv(P1);
			P1 = diptop(r,P1);
			}
		else P1 = P;
		}

/* Ausgabe */

	return(P1);
}
