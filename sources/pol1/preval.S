/*M
.SH NAME
preval - polynomial over rationals evaluation, main variable

.SH SYNOPSIS
.nf
#include<_pol1.h>

pol preval(r, P, A) 
single r; 
pol P; 
rat A;

.SH DESCRIPTION
.TP 4
.B r
is an integer number, 0 <= r < BASIS.
.TP 4
.B P                                                                            
is a polynomial in r variables over the rational numbers.            
.PP
preval returns P(A) (the evaluation of P at A) with regard to the main variable.

M*/

/*H
	Version 1	31.05.1987      B. Weis
   DATE preval        : 890501
H*/


#include <_pol1.h>

pol preval(r,P,A)
single r;
pol P;
rat A;
{
	single e, e1, i;
	pol P1, k;
	bind2(P,A);
	init2(P1,k);

/* P gleich 0 */

	if (P == 0) P1 = 0;

/* P ungleich 0 */

	else {
		r--;
		e = lfirst(P);
		P = lred(P);
		P1 = lfirst(P);
		P = lred(P);
		while (P != _0) {
			e1 = lfirst(P);
			P = lred(P);
			k = lfirst(P);
			P = lred(P);
			for (e -= e1; e; e--) {
				if (r) P1 = prrprod(r,P1,A);
				else P1 = rprod(P1,A);
				}
			if (r) P1 = prsum(r,P1,k);
			else P1 = rsum(P1,k);
			e = e1;
			}
		for (; e; e--) {
				if (r) P1 = prrprod(r,P1,A);
				else P1 = rprod(P1,A);
				}
		}

/* Ausgabe */

	return(P1);
}
