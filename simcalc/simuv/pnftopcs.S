/*C
			pnftopcs( r, P )

	"polynomial over number field to polynomial over the 
	 complex numbers, special"(rekursiv)
	Quellbibliothek: srclib.simuv
	Include-Datei:   _calc.h
	pol pnftopcs(r,P) single r; pol P;
	P1 = pnftopcs(r,P);
	P ist ein Polynom in r (0<=r<=BASIS) Variablen ueber 
	dem Zahlkoerper K=Q((-1)^1/2).
	P1 = P (aufgefasst als Polynom ueber den komplexen Zahlen).
C*/
/*H
	Version 1	17.01.1995      S. Schmitt
H*/


#include <_calc.h>

pol pnftopcs(r,P)
single r;
pol P;
{
	single e;
	pol P1, k;
	bind(P);
	init2(P1,k);

/* P gleich 0 */

	if (P == 0) P1 = 0;

/* r gleich 0 */

	else if (r == 0) P1 = nftocs(P);

/* allgemeiner Fall: P,r ungleich 0*/

	else {
		r--;
		P1 = _0;
		do {
			e = lfirst(P);
			P = lred(P);
			k = lfirst(P);
			P = lred(P);
			if (r) k = pnftopcs(r,k);
			else k = nftocs(k);
			P1 = lcomp2(k,e,P1);
			}
		while (P != _0);
		P1 = linv(P1);
		}

/* Ausgabe */

	return(P1);
}
