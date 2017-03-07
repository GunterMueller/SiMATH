/*M
.SH NAME
upmigcd - univariate polynomial over modular integers greatest common divisor

.SH SYNOPSIS
.nf
#include<_pol2.h>

pol upmigcd(p, P1, P2)  
int p; 
pol P1, P2; 

.SH DESCRIPTION
.TP 4
.B p
is a prime number.
.TP 4
.B P1, P2
are univariate polynomials over Z/pZ.
.PP
upmigcd returns the greatest common divisor of P1 and P2.

M*/

/*H
	Version 1	24.07.91	J.Schmitt
   DATE upmigcd       : 910915
H*/

#include <_pol2.h>

pol upmigcd(ip,P1,P2)
int ip;
pol P1, P2;
{
	pol P3;
	bind(ip,P1,P2);
	init(P3);

	if (P1 == 0) P3 = pmimonic(1,ip,P2);
	else if (P2 == 0) P3 = pmimonic(1,ip,P1);
	else {
		if (lfirst(P1) < lfirst(P2)) {
			P3 = P2;
			P2 = P1;
			P1 = P3;
		}
		do {
			P3 = upmirem(ip,P1,P2);
			P1 = P2;
			P2 = P3;
		} while (P2 != 0);
		P3 = pmimonic(1,ip,P1);
	}

	return(P3);
}
