/*M
.SH NAME
pitopms - polynomial over integers to polynomial over modular singles
(recursive)

.SH SYNOPSIS
.nf
#include<_pol1.h>

pol pitopms(r, P, m) 
single r, m; 
pol P; 
 
.SH DESCRIPTION
.TP 4
.B r
is an integer number, 0 <= r < BASIS.
.TP 4
.B P
is a polynomial in r variables over the integer numbers.
.TP 4
.B m
is an integer number, 0 < m < BASIS.
.PP
pitopms returns the polynomial P (as polynomial over Z/mZ).

M*/

/*H
	Version 1	31.05.1987      B. Weis
   DATE pitopms       : 890501
H*/


#include <_pol1.h>

pol pitopms(r,P,m)
single r;
pol P;
single m;
{
	single e;
	pol P1, k;
	bind(P);
	init2(P1,k);

/* P gleich 0 */

	if (P == 0) P1 = 0;

/* r gleich 0 */

	else if (r == 0) P1 = mshom(m,P);

/* allgemeiner Fall: P,r ungleich 0*/

	else {
		r--;
		P1 = _0;
		do {
			e = lfirst(P);
			P = lred(P);
			k = lfirst(P);
			P = lred(P);
			if (r) k = pitopms(r,k,m);
			else k = mshom(m,k);
			if (k) P1 = lcomp2(k,e,P1);
			}
		while (P != _0);
		if (P1 == _0) P1 = 0;
		else P1 = linv(P1);
		}

/* Ausgabe */

	return(P1);
}
