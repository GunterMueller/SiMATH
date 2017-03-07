/*M
.SH NAME
upmsgsd - univariate polynomial over modular singles greatest squarefree divisor, (recursive)

.SH SYNOPSIS
.nf
#include<_pol2.h>

pol upmsgsd(p, P) 
single p; 
pol P;
 
.SH DESCRIPTION
.TP 4
.B p
is an integer number, 0 < p < BASIS.
.TP 4
.B P
is an univariate polynomial over Z/pZ.
.PP
upmsgsd returns an univariate and square-free polynomial over Z/pZ, so that
.IP
 there exist a natural number, say s, with
 P divides S^s, and
 S divides P.
  
M*/

/*H
	Version 1       09.05.89        J.Schmitt
   DATE upmsgsd       : 891101.9001__
H*/

#include<_pol2.h>

pol upmsgsd(m,P)
single m;
pol P;
{
	single k, e, l;
	pol P1, P2, P3;
	bind(P);
	init(P1,P2,P3);

	if (pdegree(1,P) < 2) return(P);

	k = 0;
	P1 = P;

	while (P1 != _0) {
		e = lfirst(P1);
		P1 = lred(P1);
		P1 = lred(P1);
		k = sgcd(e,k);
	}
	l = intpp(m,k);

	P1 = P;
	if ( l != 1) {
		P2 = _0;
		while (P1 != _0) {
			e = lfirst(P1);
			P1 = lred(P1);
			k = lfirst(P1);
			P1 = lred(P1);
			e = divs(e,l);
			P2 = lcomp2(k,e,P2);
		}
		P1 = linv(P2);
	}

	P2 = pmsderiv(1,m,P1);
	P3 = upmsgcd(m,P1,P2);
	P1 = pmsquot(1,m,P1,P3);

	P2 = pmsmonic(1,m,P1);
	while (pdegree(1,P2) != 0) {
		P2 = upmsgcd(m,P3,P2);
		P3 = pmsquot(1,m,P3,P2);
	}
	P2 = upmsgsd(m,P3);
	P3 = pmsprod(1,m,P1,P2);

	return(P3);
}
