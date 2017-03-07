/*M
.SH NAME
udpmigcd - univariate dense polynomial over modular integers greatest common divisor

.SH SYNOPSIS
.nf
#include<_pol2.h>

pol udpmigcd(p, P1, P2)  
int p; 
pol P1, P2;

.SH DESCRIPTION
.TP 4
.B p
is a prime number.
.TP 4
.B P1, P2
are univariate polynomials in dense representation over Z/pZ.
.PP
udpmigcd returns the monic greatest common divisor of P1 and P2.

M*/

/*H
	Version 1 	16.08.91	J.Schmitt
   DATE udpmigcd      : 910915
H*/

#include <_pol2.h>

pol udpmigcd(m,P1,P2)
int m;
pol P1, P2;
{
	int k;
	pol P3;
	bind(m,P1,P2);
	init(k,P3);

/* P1 gleich 0 */

	if (P1 == 0) P3 = P2;

/* P2 gleich 0 */

	else if (P2 == 0) P3 = P1;

/* allgemeiner Fall: P1,P2 ungleich 0 */

	else {
		if (lfirst(P1) < lfirst(P2)) {
			P3 = P2;
			P2 = P1;
			P1 = P3;
		}
		do {
			udpmiqrem(m,P1,P2,&P3);
			P1 = P2;
			P2 = P3;
		}
		while (P2 != 0);
		P3 = P1;
	}
	if (P3) {
		P1 = P3;
		k  = lfirst(P3);
		P3 = list2(1,k);
		P1 = lred(P1);
		P2 = miinv(m,lfirst(P1));
		P1 = lred(P1);
		while (P1 != _0) {
			k  = miprod(m,lfirst(P1),P2);
			P3 = lcomp(k,P3);
			P1 = lred(P1);
		}
		P3 = linv(P3);
	}

/* Ausgabe */

	return(P3);
}
