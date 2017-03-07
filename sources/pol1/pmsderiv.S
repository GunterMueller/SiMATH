/*M
.SH NAME
pmsderiv - polynomial over modular singles derivation, main variable

.SH SYNOPSIS
.nf
#include<_pol1.h>

pol pmsderiv(r, m, P) 
single r, m; 
pol P;

.SH DESCRIPTION
.TP 4
.B r
is an integer number, 0 < r < BASIS.
.TP 4
.B m
is an integer number, 0 < m < BASIS.
.TP 4
.B P
is a polynomial in r variables over Z/mZ.    
.PP
pmsderiv returns the derivation of P with respect to the main variable.

.SH SEE ALSO
pmsderivsv

M*/

/*H
	Version 1	31.05.1987      B. Weis
   DATE pmsderiv      : 890501
H*/


#include <_pol1.h>

pol pmsderiv(r,m,P)
single r;
single m;
pol P;
{
	single e;
	pol P1, k;
	bind(P);
	init2(P1,k);

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
			if (r) k = pmsmsprod(r,m,k,e%m);
			else k = msprod(m,k,e%m);
			if (k) P1 = lcomp2(k,e-1,P1);
			}
		while (P != _0);
		if (P1 == _0) P1 = 0;
		else P1 = linv(P1);
		}

/* Ausgabe */

	return(P1);
}
