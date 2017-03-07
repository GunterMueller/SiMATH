/*M
.SH NAME
cdprfupr - common denominator polynomial over the rationals from univariate polynomial over the rationals

.SH SYNOPSIS
.nf
#include<_pol2.h>

pol cdprfupr(P) 
pol P;
 
.SH DESCRIPTION
.TP 4
.B P
is an univariate polynomial over the rational numbers.
.PP
cdprfupr returns the polynomial P as a CD-polynomial (s.cdprfcl).

.SH SEE ALSO
cdprfcl

M*/
                              
/*H
	Version 1       15.05.89        J.Schmitt
   DATE cdprfupr      : 891101.9001__
H*/

#include<_pol2.h>

pol cdprfupr(P)
pol P;
{
	pol P1, P2;
	list Al;
	single e;
	int k,l;
	init(P1,P2,Al,k,l);
	bind(P);

	if (P == 0) return(0);

	k = 1;
	P1 = P;
	while (P1 != _0) {
		P1 = lred(P1);
		l = lfirst(P1);
		P1 = lred(P1);
		l = lsecond(l);
		k = ilcm(l,k);
	}
	Al = list2(k,1);
	P1 = prrprod(1,P,Al);

	P2 = _0;
	while (P1 != _0) {
		e = lfirst(P1);
		P1 = lred(P1);
		l = lfirst(P1);
		l = lfirst(l);
		P1 = lred(P1);
		P2 = lcomp2(l,e,P2);
	}
	P1 = linv(P2);
	P1 = lcomp(k,P1);
	return(P1);
}
