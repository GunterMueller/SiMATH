/*M
.SH NAME
pcderiv - polynomial over the complex numbers derivation, main variable  

.SH SYNOPSIS
.nf
#include<_pol1.h>

pol pcderiv(r, P)
single r;
pol P;

.SH DESCRIPTION
pcderiv() returns the derivation of P with
respect to the main variable where P
is a polynomial over the complex numbers.
M*/


/*H
	Version 1       25.01.1995      S.Schmitt
   DATE pcderiv       : 951201
H*/

#include <_pol1.h>

pol pcderiv(r,P)
single r;
pol P;
{
	pol P1;
	init(P1);

/* P gleich 0 */

	if ( !P ) P1 = 0;

/* allgemeiner Fall: P ungleich 0 */

	else {
		single e;
		complex e1;
		pol k;
		bind(P);
		init(k,e1);

		r--;
		P1 = _0;
		do {
			e = lfirst(P);
			P = lred(P);
			k = lfirst(P);
			P = lred(P);
			e1 = itoc(e);
			k = (r) ? (pccprod(r,k,e1)) : (cprod(k,e1));
			if (k) P1 = lcomp2(k,e-1,P1);
		}
		while (P != _0);
		P1 = (P1 == _0) ? (0) : (linv(P1));
	}

/* Ausgabe */

	return(P1);
}
