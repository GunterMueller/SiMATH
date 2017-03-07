/*M
.SH NAME
printegr - polynomial over rationals integration, main variable

.SH SYNOPSIS
.nf
#include<_pol1.h>

pol printegr(r, P) 
single r; 
pol P;

.SH DESCRIPTION
.TP 4
.B r
is an integer number, 0 <= r < BASIS.
.TP 4
.B P                                                                            
is a polynomial in r variables over the rational numbers.          
.PP
printegr returns the integral of P with regard to the main variable.
The integrations constant is 0.

M*/

/*H
	Version 1	31.05.1987      B. Weis
   DATE printegr      : 890501
H*/


#include <_pol1.h>

pol printegr(r,P)
single r;
pol P;
{
	single e;
	rat es;
	pol P1=0, k;
	bind2(P,P1);
	init2(es,k);

/* P ungleich 0 */

	if (P) {
		r--;
		P1 = _0;
		do {
			e = lfirst(P);
			P = lred(P);
			k = lfirst(P);
			P = lred(P);
			e++;
			es = list2(1,e);
			k = prrprod(r,k,es);
			P1 = lcomp2(k,e,P1);
			}
		while (P != _0);
		P1 = linv(P1);
		}

/* Ausgabe */

	return(P1);
}
