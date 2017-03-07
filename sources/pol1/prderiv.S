/*M
.SH NAME
prderiv - polynomial over rationals derivation, main variable

.SH SYNOPSIS
.nf
#include<_pol1.h>

pol prderiv(r, P) 
single r; 
pol P;

.SH DESCRIPTION
.TP 4
.B r
is an integer, 0 <= r < BASIS.
.TP 4
.B P
is a polynomial in r variables over the rational numbers.
.PP
prderiv returns the derivation of P with respect to the main variable.

M*/

/*H
	Version 1	31.05.1987      B. Weis
   DATE prderiv       : 890501
H*/


#include <_pol1.h>

pol prderiv(r,P)
single r;
pol P;
{
	single e;
	pol P1, k, k1;
	bind(P);
	init3(P1,k,k1);

/* P gleich 0 */

	if (P == 0) P1 = 0;

/* allgemeiner Fall: P ungleich 0 */

	else {
		r--;
		P1 = _0;
		do {
			e = lfirst(P);
			P = lred(P);
			k = lfirst(P);
			P = lred(P);
			k1 = itor(e);
			if (r) k = prrprod(r,k,k1);
			else k = rprod(k,k1);
			if (k) P1 = lcomp2(k,e-1,P1);
			}
		while (P != _0);
		if (P1 == _0) P1 = 0;
		else P1 = linv(P1);
		}

/* Ausgabe */

	return(P1);
}
