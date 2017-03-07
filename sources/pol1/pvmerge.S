/*M
.SH NAME
pvmerge - polynomial variable list merge

.SH SYNOPSIS
.nf
#include<_pol1.h>

list pvmerge(LV, LP, pPL) 
list LV, LP, *pLP;

.SH DESCRIPTION
.TP 4
.B LP
is a list of polynomials.
.TP 4
.B LV 
is a list of variables lists beloning to the polynomials in LP.
.PP
pvmerge returns the alphabetized union of the variables lists in LV (say V), and writes a list consisting of the polynomials in LP (as polynomials with variables list V) to pLP.
 
M*/

/*H
	Version 1       10.03.1988      B. Weis
   DATE pvmerge       : 890501
H*/


#include <_pol1.h>

list pvmerge(LV,LP,pLP)
list LV;
list LP;
list *pLP;
{
	list LVS, V, VL, ppLP;
	pol P;
	bind(LP,LV);
	init(V,ppLP);

/* Initialisierung */

	LVS = LV;
	V = _0;
	while (LVS != _0) {
		VL = lfirst(LVS);
		V = usunion(VL,V);
		LVS = lred(LVS);
		}
	V = vlsort(V,&LVS);

/* Mischen der Variablenlisten */

	ppLP = _0;
	while (LP != _0) {
		P = lfirst(LP);
		if (P) {
			VL = lfirst(LV);
			P = pvext(llength(VL),P,VL,V);
			}
		ppLP = lcomp(P,ppLP);
		LP = lred(LP);
		LV = lred(LV);
		}
	ppLP = linv(ppLP);

/* Ausgabe */

	*pLP = ppLP;
	return(V);
}
