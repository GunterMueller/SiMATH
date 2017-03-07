/*M
.SH NAME
pitopc - polynomial over integers to polynomial over the complex numbers  

.SH SYNOPSIS
.nf
#include<_pol1.h>

pol pitopc(r, P)
single r;
pol P;

.SH DESCRIPTION
pitopc() returns the polynomial P in r variables over
integers as a polynomial over the complex numbers.
M*/


/*H
	Version 1	17.01.1995      S. Schmitt
   DATE pitopc        : 951201
H*/

#include <_pol1.h>

pol pitopc(r,P)
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

	else if (r == 0) P1 = itoc(P);

/* allgemeiner Fall: P,r ungleich 0*/

	else {
		r--;
		P1 = _0;
		do {
			e = lfirst(P);
			P = lred(P);
			k = lfirst(P);
			P = lred(P);
			if (r) k = pitopc(r,k);
			else k = itoc(k);
			P1 = lcomp2(k,e,P1);
			}
		while (P != _0);
		P1 = linv(P1);
		}

/* Ausgabe */

	return(P1);
}
