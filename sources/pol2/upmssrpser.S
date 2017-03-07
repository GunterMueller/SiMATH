/*M
.SH NAME
upmssrpser - univariate polynomial over modular singles square root power series
 
.SH SYNOPSIS
.nf
#include<_pol2.h>

pol upmssrpser(p, P, i)  
single p, i; 
pol P;
 
.SH DESCRIPTION
.TP 4
.B p
is an odd prime number, p < BASIS.
.TP 4
.B P
is an univariate polynomial over Z/pZ of even degree, whose leading coefficient is a square in Z/pZ.
.TP 4
.B i
is an integer number, 0 < i < BASIS.
.PP
upmssrpser returns the top of the power series of P^(1/2) in 1/X up to the power X^(-i).

M*/

/*H
	Version 1	04.02.1993	A.Stein
   DATE upmssrpser    : 930531
H*/

#include <_pol2.h>

pol upmssrpser(m,P,i)
single m, i;
pol P;
{
	single a, bf, e, eh;
	pol B, H, P1=0;
	bind(P);
	init(B,H,P1);

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
			if ((e = lfirst(P)-eh) < i) break;
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

	return(P1);
}
