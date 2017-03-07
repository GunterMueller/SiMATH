/*M
.SH NAME
pflexp - polynomial over floating point numbers, exponentiation  

.SH SYNOPSIS
.nf
#include<_pol1.h>

pol pflexp(r, P, n)
single r;
pol P;
single n;

.SH DESCRIPTION
pflexp() returns the n-th power P^n
of the polynomial P in r variables over floating point numbers.
M*/

/*H
	Version 1 	25.01.1995	S.Schmitt
   DATE pflexp        : 951201
H*/

#include <_pol1.h>

pol pflexp(r,P,n)
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
		for (--n; n; n--) P1 = pflprod(r,P1,P);
	}

/* Ausgabe */

	return(P1);
}
