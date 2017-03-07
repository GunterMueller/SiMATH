/*M
.SH NAME
upgfsgcd - univariate polynomial over Galois-field with single characteristic greatest common divisor

.SH SYNOPSIS
.nf
#include<_pol3.h>

pol upgfsgcd(p, AL, P1, P2)  
single p; 
list AL; 
pol P1, P2;
 
.SH DESCRIPTION
.TP 4
.B p
is a prime number, p < BASIS.
.TP 4
.B AL
= (G AL1) can be seen as an arithmetic list of GF(p^n), where n = lenght(AL1)+1 (s. gfsalgen).
.TP 4  
.B P1, P2
are univariate polynomials over GF(p^n).
.PP
upgfsgcd returns the greatest common divisor of P1 and P2.

.SH SEE ALSO
gfsalgen

M*/
                     
/*H
	Version 1         23.03.88           J.Schmitt
   DATE upgfsgcd      : 890501.9203__
H*/


#include <_pol3.h>

pol upgfsgcd(p,AL,P1,P2)
single p;
list AL;
pol P1, P2;
{
	pol P3;
	bind(P1,P2,AL);
	init(P3);

/* P1 gleich 0 */

	if (P1 == 0) P3 = pgfsmonic(1,p,AL,P2);

/* P2 gleich 0 */

	else if (P2 == 0) P3 = pgfsmonic(1,p,AL,P1);

/* allgemeiner Fall: P1,P2 ungleich 0 */

	else {
		if (lfirst(P1) < lfirst(P2)) {
			P3 = P2;
			P2 = P1;
			P1 = P3;
			}
		do {
			P3 = pgfsrem(1,p,AL,P1,P2);
			P1 = P2;
			P2 = P3;
			}
		while (P2 != 0);
		P3 = pgfsmonic(1,p,AL,P1);
		}

/* Ausgabe */

	return(P3);
}
