/*M
.SH NAME
pitopr - polynomial over integers to polynomial over rationals (recursive)

.SH SYNOPSIS
.nf
#include<_pol1.h>

pol pitopr(r, P) 
single r; 
pol P;

.SH DESCRIPTION
.TP 4
.B r
is an integer number, 0 <= r < BASIS.
.TP 4
.B P
is a polynomial in r variables over the integer numbers.
.PP
pitopr returns the polynomial P ( as a polynomial over the rational numbers).

M*/

/*H
	Version 1	31.05.1987      B. Weis
   DATE pitopr        : 890501
H*/


#include <_pol1.h>

pol pitopr(r,P)
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

	else if (r == 0) P1 = itor(P);

/* allgemeiner Fall: P,r ungleich 0*/

	else {
		r--;
		P1 = _0;
		do {
			e = lfirst(P);
			P = lred(P);
			k = lfirst(P);
			P = lred(P);
			if (r) k = pitopr(r,k);
			else k = itor(k);
			P1 = lcomp2(k,e,P1);
			}
		while (P != _0);
		P1 = linv(P1);
		}

/* Ausgabe */

	return(P1);
}
