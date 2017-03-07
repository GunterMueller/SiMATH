/*M
.SH NAME
pnfexp - polynomial over number field exponentiation

.SH SYNOPSIS
.nf
#include<_pol3.h>

pol pnfexp(r, F, P, n)  
single r;  
pol F, P;  
single n;

.SH DESCRIPTION
.TP 4
.B r
is an integer number, 0 <= r < BASIS.
.TP 4
.B F
is an irreducible, univariate polynomial in dense representation over Z. F generates a number field, say K.
.TP 4
.B P
is a polynomial in r variables over K.
.TP 4
.B n
is an integer number, 0 <= n < Basis.
.PP
pnfexp returns a polynomial, say P1, where
.IP
P1 = P^n.

M*/
                           
/*H
	Version 1 	03.08.92	U.Schneiders
   DATE pnfexp        : 921130
H*/

#include <_pol3.h>

pol pnfexp(r,F,P,n)
single r;
pol F, P;
single n;
{
	pol P1;
	bind(F,P);
	init(P1);

/* n gleich 0 */

	if (!n) P1 = pvinsert(0,1,r);

/* P gleich 0 */

	else if (!P) P1 = 0;

/* n,P ungleich 0 */

	else {
		P1 = P;
		for (--n; n; n--) P1 = pnfprod(r,F,P1,P);
	}

/* Ausgabe */

	return(P1);
}
