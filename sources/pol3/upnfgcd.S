/*M
.SH NAME
upnfgcd - univariate polynomial over number field greatest common divisor

.SH SYNOPSIS
.nf
#include<_pol3.h>

pol upnfgcd(F, P1, P2) 
pol F, P1, P2;
  
.SH DESCRIPTION
Let K be a number field,
.TP 4
.B F
is the respective univariate minimal polynomial of degree >= 1 in dense representation, i.e. K arises by the adjunction of a root of F.
.TP 4
.B P1, P2
are univariate polynomials over K.
.PP
upnfgcd returns a monic polynomial over K, which is the greatest common divisor of P1 and P2.

.SH SEE ALSO
upnfegcd

M*/
  
/*H
	Version 1       16.11.1989      A.Stein
   DATE upnfgcd       : 900315
H*/


#include <_pol3.h>

pol upnfgcd(F,P1,P2)
pol F, P1, P2;
{
	pol P3;
	bind(F,P1,P2);
	init(P3);

/* P1 gleich 0 */

	if ( !P1 ) P3 = pnfmonic(1,F,P2);

/* P2 gleich 0 */

	else if ( !P2 ) P3 = pnfmonic(1,F,P1);

/* allgemeiner Fall: P1,P2 ungleich 0 */

	else {
		if (lfirst(P1) >= lfirst(P2)) P2 = pnfmonic(1,F,P2);
		else {
			P3 = P2;
			P2 = pnfmonic(1,F,P1);
			P1 = P3;
		}
		do {
			P3 = pnfrem(1,F,P1,P2);
			P1 = P2;
			P2 = pnfmonic(1,F,P3);
		}
		while ( P2 );
	}

/* Ausgabe */

	return(P1);
}
