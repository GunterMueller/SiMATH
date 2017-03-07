/*M
.SH NAME
vlsort - variable list sort

.SH SYNOPSIS
.nf
#include<_pol1.h>

list vlsort(V, pPP)  
list VL, *pPP;

.SH DESCRIPTION
.TP 4
.B V
is a list of variables names.
.PP
vlsort sorts the list V alphanumerical and returns it as a new list, say V1.
The permutation with which V becomes V1 will be written to pPP.
  
M*/

/*H
	Version 1       25.02.1988      B. Weis
	Version 2       11.03.1988      B. Weis
			Sonderfall einbuchstabige Variablennamen verboten
	Version 3	16.05.1994	Einige Variablen geschlossen umbenannt
					wegen Portierung auf Linux. MP
   DATE vlsort        : 890501.941201
H*/

#include <_pol1.h>

list vlsort(V,pPP)
list V;
list *pPP;
{
	single i;
	list PP, PPS, V1, VS, VSS, Vn, Vn1;
	bind(V);
	init(PP,V1);

/* Laenge von V kleiner 2 */

	if (V == _0) V1 = V, *pPP = _0;
	else if ((i = llength(V)) == 1) V1 = V, *pPP = list1(1);

/* allgemeiner Fall */

	else {
		for (PP = _0; i; i--) PP = lcomp(i,PP);
		V1 = lcinv(V);
		V1 = linv(V1);
		VS = V1;
		PPS = PP;
		while (VS != _0) {
			Vn = lfirst(VS);
			VSS = lred(VS);
			i = 1;
			while ( VSS != _0) {
				i++;
				Vn1 = lfirst(VSS);
				VSS = lred(VSS);
				if (vncomp(Vn1,Vn) == 1) {
					lerot(VS,1,i);
					lerot(PPS,1,i);
					Vn = Vn1;
					}
				}
			PPS = lred(PPS);
			VS = lred(VS);
			}
		*pPP = PP;
		}

/* Ausgabe */

	return(V1);
}
