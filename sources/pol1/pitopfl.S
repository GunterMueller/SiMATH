/*M
.SH NAME
pitopfl - polynomial over integers to polynomial over floating point numbers  

.SH SYNOPSIS
.nf
#include<_pol1.h>

pol pitopfl(r, P)
single r;
pol P;

.SH DESCRIPTION
pitopfl() returns the polynomial P in r variables over
integers as a polynomial over floating point numbers.
M*/


/*H
	Version 1	17.01.1995      S. Schmitt
   DATE pitopfl       : 951201
H*/


#include <_pol1.h>

pol pitopfl(r,P)
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

	else if (r == 0) P1 = itofl(P);

/* allgemeiner Fall: P,r ungleich 0*/

	else {
		r--;
		P1 = _0;
		do {
			e = lfirst(P);
			P = lred(P);
			k = lfirst(P);
			P = lred(P);
			if (r) k = pitopfl(r,k);
			else k = itofl(k);
			P1 = lcomp2(k,e,P1);
			}
		while (P != _0);
		P1 = linv(P1);
		}

/* Ausgabe */

	return(P1);
}
