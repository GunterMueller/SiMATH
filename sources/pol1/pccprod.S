/*M
.SH NAME
pccprod - polynomial over the complex numbers, complex number product  

.SH SYNOPSIS
.nf
#include<_pol1.h>

pol pccprod(r, P, c)
single r;
pol P;
complex c;

.SH DESCRIPTION
pccprod() returns the polynomial c*P
where P is a polynomial in r variables over the complex numbers
and c is a complex number.
M*/

/*H
	Version 1       25.01.1995      S.Schmitt
   DATE pccprod       : 951201
H*/

#include <_pol1.h>
 
pol pccprod(r,P,a)
single r;
pol P;
complex a;
{
	pol P1;
	bind(P,a);
	init(P1);

/* P oder a gleich 0 */

	if ( !P || !a ) P1 = 0;

/* Anzahl r der Variablen gleich 0 */

	else if ( !r ) P1 = cprod(P,a);

/* allgemeiner Fall: r,P,a ungleich 0 */

	else {
		single e;
		pol k;
		init(k);

		P1 = _0;
		r--;
		do {
			e = lfirst(P);
			P = lred(P);
			k = lfirst(P);
			P = lred(P);
			k = (r) ? (pccprod(r,k,a)) : (cprod(k,a));
			P1 = lcomp2(k,e,P1);
			}
		while (P != _0);
		P1 = linv(P1);
		}

/* Ausgabe */

	return(P1);
}
