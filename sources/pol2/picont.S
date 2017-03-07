/*M
.SH NAME
picont - polynomial over integers content

.SH SYNOPSIS
.nf
#include<_pol2.h>

pol picont(r, P) 
single r; 
pol P;

.SH DESCRIPTION
.TP 4
.B r
is an integer number, 0 < r < BASIS.
.TP 4
.B P
is a polynomial in r variables over the integer numbers.
.PP
picont returns the content of P with regard to the main variable.

M*/

/*H
	Version 1       30.10.1987      B. Weis
   DATE picont        : 890501
H*/


#include <_pol2.h>

pol picont(r,P)
single r;
pol P;
{
	pol P1, P1S, H, H1;
	bind(P);
	init2(P1,P1S);
	P1 = 0;

/* P ungleich 0 */

	if (P) {
		P = lred(P);
		P1 = lfirst(P);
		P = lred(P);
		r--;
		while (P != _0) {
			P = lred(P);
			P1S = lfirst(P);
			P = lred(P);
			P1 = pigcdcf(r,P1,P1S,&H,&H1);
			if (ispione(r,P1)) break;
			}
		P1 = piabs(r,P1);
		}

/* Ausgabe */

	return(P1);
}
