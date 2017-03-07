/*M
.SH NAME
upmssrpp - univariate polynomial over modular singles square root principal part
.SH SYNOPSIS
.nf
#include<_pol2.h>

pol upmssrpp(p, P)  
single p; 
pol P;

.SH DESCRIPTION
.TP 4
.B p
is an odd prime number, p < BASIS.
.TP 4
.B P
is an univariate sparse polynomial over Z/pZ of even degree, whose leading coefficient is a square in Z/pZ.
.PP
upmssrpp returns a polynomial which is the principal part of the power series expansion of P^(1/2) in 1/X. 

M*/

/*H
	Version 1	31.05.1987      B. Weis
	Version 2       30.05.1988      B. Weis
			Korrektur und Verbesserung des Wurzelziehens mod m
	Version 3	06.08.1992	Wurzelziehen mit mpsqrt. Variable b
					nicht notwendig.  AS
   DATE upmssrpp      : 890501.921130
H*/


#include <_pol2.h>

pol upmssrpp(m,P)
single m;
pol P;
{
	single a, bf, e, eh;
	pol B, H, P1=0;
	bind(P,P1);
	init(B,H);

/* P ungleich 0 */

	if (P) {
		eh = (e = lfirst(P))/2;
		P = lred(P);
		a = lfirst(P);
		P = lred(P);
		a = (((m+1)%4)) ? (mpsqrt(m,a)) : (msexp(m,a,(m+1)/4));
		P1 = list2(a,eh);
		B = _0;
		bf = msinv(m,(a*2)%m);
		while (P != _0) {
			if ((e = lfirst(P)-eh) < 0) break;
			P = lred(P);
			a = lfirst(P);
			P = lred(P);
			a = msprod(m,bf,a);
			if (B != _0) {
				H = list2(e,a);
				H = pmsprod(1,m,B,H);
				P = pmsdif(1,m,P,H);
				}
			H = list2(2*e,msprod(m,a,a));
			P = pmsdif(1,m,P,H);
			B = linv(B);
			B = lcomp2((2*a)%m,e,B);
			B = linv(B);
			P1 = lcomp2(a,e,P1);
			}
		P1 = linv(P1);
		}

/* Ausgabe */

	return(P1);
}
