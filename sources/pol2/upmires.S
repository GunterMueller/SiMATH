/*M
.SH NAME
upmires - univariate polynomial over modular integers resultant

.SH SYNOPSIS
.nf
#include<_pol2.h>

int upmires(p, P1, P2)  
int p; 
pol P1, P2;
 
.SH DESCRIPTION
.TP 4
.B p
is a prime number.
.TP 4
.B P1, P2
are univariate polynomials over Z/pZ of degree greater or equal to 1.
.PP
upmires returns the resultant of P1 and P2.

M*/

/*H
	Version 1 	16.08.91	J.Schmitt
   DATE upmires       : 910915
H*/

#include <_pol2.h>

int upmires(m,P1,P2)
int m;
pol P1, P2;
{
	single eP1, eP2, eP3, i, s;
	int a, as;
	pol P3;
	bind(m,P1,P2);
	init(a,as,P3);

	a = 1;
	P1 = ptodp(1,P1);
	P2 = ptodp(1,P2);
	eP1 = lfirst(P1);
	eP2 = lfirst(P2);
	s = 0;
	if (eP1 < eP2) {
		if (sodd(eP1)  &&  sodd(eP2)) s = 1;
		P3 = P1;
		P1 = P2;
		P2 = P3;
	}

	do {
		P3 = udpmirem(m,P1,P2);
		if (!P3) {a = 0; break;}
		eP1 = lfirst(P1);
		eP2 = lfirst(P2);
		eP3 = lfirst(P3);
		if (sodd(eP1)  &&  sodd(eP2)) s = 1-s;
		as = lsecond(P2);
		for (i = eP1-eP3; i; i--) a = miprod(m,a,as);
		P1 = P2;
		P2 = P3;
	} while (eP3);
	if (a) {
		as = lsecond(P2);
		for (i = eP2; i; i--) a = miprod(m,a,as);
		if (s) a = idif(m,a);
	}

/* Ausgabe */

	return(a);
}
