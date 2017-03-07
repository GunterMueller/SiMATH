/*M
.SH NAME
pcexp - polynomial over the complex numbers, exponentiation  

.SH SYNOPSIS
.nf
#include<_pol1.h>

pol pcexp(r, P, n)
single r;
pol P;
single n;

.SH DESCRIPTION
pcexp()
returns the n-th power P^n
of the polynomial P in r variables over the complex numbers.
M*/

/*H
	Version 1 	25.01.1995	S.Schmitt
   DATE pcexp         : 951201
H*/

#include <_pol1.h>

pol pcexp(r,P,n)
single r;
pol P;
single n;
{
	pol P1;
	bind(P);
	init(P1);

/* n gleich 0 */

	if (!n) P1 = pvinsert(0,1,r);

/* P gleich 0 */

	else if (!P) P1 = 0;

/* n,P ungleich 0 */

	else {
		P1 = P;
		for (--n; n; n--) P1 = pcprod(r,P1,P);
	}

/* Ausgabe */

	return(P1);
}
