/*M
.SH NAME
picontpp - polynomial over integers content and primitive part

.SH SYNOPSIS
.nf
#include<_pol2.h>

pol picontpp(r, P, pPP) 
single r; 
pol P ,*pPP;

.SH DESCRIPTION
.TP 4
.B r
is an integer number, 0 < r < BASIS.
.TP 4
.B P
is a polynomial in r variables over the integer numbers.
.PP
picontpp computes the content, say P1, and the primitive part, say PP, of the polynomial P ( with regard to the main variable ).
.PP
picontpp returns P1 and writes PP to *pPP.

M*/

/*H
	Version 1       03.11.1987      B. Weis
	Version 2       14.12.1989      J.Schmitt init2(P1,k)
						  --> init(P1,k,ppPP);
   DATE picontpp      : 890501.900101
H*/


#include <_pol2.h>

pol picontpp(r,P,pPP)
single r;
pol P;
pol *pPP;
{
	single e;
	pol P1, ppPP, k;
	bind(P);
	init(P1,ppPP,k);

/* P ungleich 0 */

	if (P) {
		P = piabs(r,P);
		P1 = picont(r,P);
		r--;
		if (ispione(r,P1)) *pPP = P;
		else {
			ppPP = _0;
			while (P != _0) {
				e = lfirst(P);
				P = lred(P);
				k = lfirst(P);
				P = lred(P);
				k = piquot(r,k,P1);
				ppPP = lcomp2(k,e,ppPP);
				}
			*pPP = linv(ppPP);
			}
		}

/* P gleich 0 */

	else {P1 = 0; *pPP = 0;}

/* Ausgabe */

	return(P1);
}
