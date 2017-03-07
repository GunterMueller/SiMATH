/*M
.SH NAME
upmiresulc - univariate polynomial over modular integers resultant and cofactor of resultant equation

.SH SYNOPSIS
.nf
#include<_pol2.h>

int upmiresulc(p, P1, P2, pB)  
int p; 
pol P1, P2, *pB;
 
.SH DESCRIPTION
.TP 4
.B p
is a prime number.
.TP 4
.B P1, P2
are univariate polynomials with positive degree over Z/pZ.
.PP
Let r be the resultant of P1 and P2 (hence r is an element of Z/pZ), and let B be
an univariate polynomial over Z/pZ, such that there exists an 
univariate polynomial A over Z/pZ with
.IP
P1 * A + P2 * B = r.
.PP
upmiresulc returns r and writes B to *pB.

M*/

/*H
	Version 1 	16.08.91	J.Schmitt
   DATE upmiresulc    : 910915
H*/

#include <_pol2.h>

int upmiresulc(m,P1,P2,pC)
int m;
pol P1, P2;
pol *pC;
{
	single eP1, eP2, eP3, i, s;
	int a, as;
	pol P3, Q, v1, v2, v3;
	bind(m,P1,P2);
	init(a,as,P3,Q,v1,v2,v3);

	a = 1;
	eP1 = lfirst(P1);
	eP2 = lfirst(P2);
	s = 0;
	v1 = 0;
	v2 = list2(0,1);
	if ( eP1 < eP2 ) {
		if ( sodd(eP1)  &&  sodd(eP2) ) s = 1;
		P3 = P1;
		P1 = P2;
		P2 = P3;
		v1 = v2;
		v2 = 0;
	}

	do {
		Q = pmiqrem(1,m,P1,P2,&P3);
		v3 = pmidif(1,m,v1,pmiprod(1,m,Q,v2));
		if (!P3) { a = 0; *pC = v3; break; }
		eP1 = lfirst(P1);
		eP2 = lfirst(P2);
		eP3 = lfirst(P3);
		if (sodd(eP1)  &&  sodd(eP2)) s = 1-s;
		as = lsecond(P2);
		for (i = eP1-eP3; i; i--) a = miprod(m,a,as);
		P1 = P2;
		P2 = P3;
		v1 = v2;
		v2 = v3;
	}
	while (eP3);
	if (a) {
		as = lsecond(P2);
		for (i = eP2; i != 1; i--) a = miprod(m,a,as);
		v1 = pmimiprod(1,m,v2,a);
		a = miprod(m,a,as);
		if (s) a = idif(m,a);
		*pC = v1;
	}

	return(a);
}
