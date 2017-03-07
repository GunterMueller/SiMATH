/*M
.SH NAME
upmisfp - univariate polynomial over modular integers square-free part

.SH SYNOPSIS
.nf
#include<_pol2.h>

pol upmisfp(p, P)  
int p; 
pol P;
  
.SH DESCRIPTION
.TP 4
.B p
is a prime number.
.TP 4
.B P
is an univariate, monic polynomial over Z/pZ,     deg(P) > 0.
.PP
upmisfp returns the square-free part of P (say P1), i.e.
.PP
P = P1 * P2^2,  and g.c.d.(P1, P2) = 1.

M*/

/*H
	Version 1 	16.08.91	J.Schmitt
   DATE upmisfp       : 910915
H*/

#include <_pol2.h>

pol upmisfp(m,P)
int m;
pol P;
{
	list L;
	pol P1;
	bind(m,P);
	init(L,P1);

/* Berechnung von P1 */

	L = upmisfact(m,P);
	P1 = list2(0,1);
	while (L != _0) {
		P = lfirst(L);
		L = lred(L);
		if (sodd(lfirst(P))) P1 = pmiprod(1,m,P1,lsecond(P));
	}

/* Ausgabe */

	return(P1);
}
