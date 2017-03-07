/*M
.SH NAME
pvmix - polynomial variable list mix

.SH SYNOPSIS
.nf
#include<_pol1.h>

list pvmix(V1, V2, P1, P2, pP1, pP2) 
list V1, V2; 
pol P1, P2, *pP1, *pP2;

.SH DESCRIPTION
.TP 4
.B P1, P2
are polynomials.
.TP 4
.B V1, V2
are lists of variables names, used by P1, P2 respectively.
.PP
pvmix returns the alphabetized union V3 (say) of V1 and V2, and writes P1 and P2 as polynomials with variables list V3 to pP1, pP2 respectively.  

M*/

/*H
	Version 1       03.02.1988      B. Weis
	Version 2       26.02.1988      B. Weis
			vollstaendig ueberarbeitete Version
			V3 jetzt alphabetisch geordnet
	Version 2 	16.05.1994	Einige Variablen geschlossen umbenannt
					wegen Portierung auf Linux. MP
H*/

#include <_pol1.h>

list pvmix(V1,V2,P1,P2,pP1,pP2)
list V1, V2;
pol P1, P2;
pol *pP1, *pP2;
{
	single i, r;
	list D1, D2, PP, V3, Vn;
	init(D1,D2,PP,V3,Vn);
	bind(V1,V2,P1,P2);

/* Initialisierung */

	PP = _0;
	while (V1 != _0) {
		Vn = lfirst(V1);
		V1 = lred(V1);
		if (isatom(Vn)) Vn = list1(Vn);
		PP = lcomp(Vn,PP);
		}
	V1 = linv(PP);
	PP = _0;
	while (V2 != _0) {
		Vn = lfirst(V2);
		V2 = lred(V2);
		if (isatom(Vn)) Vn = list1(Vn);
		PP = lcomp(Vn,PP);
		}
	V2 = linv(PP);

/* Mischen der Variablenlisten */

	D1 = usdiff(V1,V2);
	D2 = usdiff(V2,V1);
	if (P1) for (i = llength(D2); i; i--) P1 = list2(0,P1);
	V3 = lconc(V1,D2);
	r = llength(V3);
	V3 = vlsort(V3,&PP);
	P1 = pvpermut(r,P1,PP);
	if (P2) for (i = llength(D1); i; i--) P2 = list2(0,P2);
	V3 = lconc(V2,D1);
	V3 = vlsort(V3,&PP);
	P2 = pvpermut(r,P2,PP);

/* Ausgabe */

	*pP1 = P1;
	*pP2 = P2;
	return(V3);
}
