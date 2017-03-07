/*M
.SH NAME
pflderivsv - polynomial over floating point numbers derivation, specified  variable  

.SH SYNOPSIS
.nf
#include<_pol1.h>

pol pflderivsv(r, P, n)
single r;
pol P;
single n;

.SH DESCRIPTION
pflderivsv() returns the derivation of P with
respect to the n-th variable where P
is a polynomial over floating point numbers.
M*/

/*H
	Version 1       25.01.1995      S.Schmitt
   DATE pflderivsv    : 951201
H*/

#include <_pol1.h>

pol pflderivsv(r,P,n)
single r;
pol P;
single n;
{
	pol P1;
	bind(P);
	init(P1);

/* P gleich 0 */

	if ( !P ) P1 = 0;

/* n gleich r */

	else if (n == r) P1 = pflderiv(r,P);

/* allgemeiner Fall: n ungleich r und P ungleich 0 */

	else {
		single e;
		pol k;
		init(k);

		r--;
		P1 = _0;
		do {
			e = lfirst(P);
			P = lred(P);
			k = lfirst(P);
			P = lred(P);
			k = pflderivsv(r,k,n);
			if (k) P1 = lcomp2(k,e,P1);
		}
		while (P != _0);
		P1 = (P1 == _0) ? (0) : (linv(P1));
	}

/* Ausgabe */

	return(P1);

}
