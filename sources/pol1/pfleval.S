/*M
.SH NAME
pfleval - polynomial over floating point numbers evaluation, main  variable  

.SH SYNOPSIS
.nf
#include<_pol1.h>

pol pfleval(r, P, c)
single r;
pol P;
floating a;

.SH DESCRIPTION
pfleval() returns the evaluation P(c) with respect to the main variable
where P is a polynomial in r variables over floating point numbers
and c is a floating point number.
M*/

/*H
	Version 1       25.01.1995      S.Schmitt
   DATE pfleval       : 951201
H*/

#include <_pol1.h>

pol pfleval(r,P,a)
single r;
pol P;
floating a;
{
	pol P1;
	init(P1);

/* P gleich 0 */

	if (!P) P1 = 0;

/* P ungleich 0 */

	else {
		single e, e1;
		pol k;
		bind(P,a);
		init(k);

		r--;
		e = lfirst(P);
		P = lred(P);
		P1 = lfirst(P);
		P = lred(P);
		while (P != _0) {
			e1 = lfirst(P);
			P = lred(P);
			k = lfirst(P);
			P = lred(P);
			for (e = e-e1; e; e--) {
				P1 = (r) ? (pflflprod(r,P1,a))
					 : (flprod(P1,a));
			}
			P1 = (r) ? (pflsum(r,P1,k))
				 : (flsum(P1,k));
			e = e1;
		}
		for (; e; e--) {
			P1 = (r) ? (pflflprod(r,P1,a))
				 : (flprod(P1,a));
		}
	}

/* Ausgabe */

	return(P1);
}
