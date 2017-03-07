/*M
.SH NAME
upgf2gcd - univariate polynomial over Galois-field with characteristic 2 greatest common divisor

.SH SYNOPSIS
.nf
#include<_pol3.h>

pol upgf2gcd(G, P1, P2)  
obj G; 
pol P1, P2;
     
.SH DESCRIPTION
.TP 4
.B G
is an univariate, monic and irreducible polynomial over Z/2Z in special bit-representation (s.udpm2tosb).
.PP
Let n be the degree of G, then G can be interpreted as a generator of GF(2^n)
(Galois-field with characteristic 2).
.TP 4
.B P1, P2
are univariate polynomials over GF(2^n) with coefficients in special bit-representation.
.PP
upgf2gcd returns the greatest common divisor of P1 and P2.         
        
.SH SEE ALSO
udpm2tosb

M*/
             
/*H
	Version 1	28.04.93	J.Schmitt
   DATE upgf2gcd      : 930531
H*/

#include <_pol3.h>

pol upgf2gcd(P,P1,P2)
pol P, P1, P2;
{
	pol P3,H;
	bind(P,P1,P2);
	init(P3,H);

/* P1 gleich 0 */

	if (P1 == 0) P3 = pgf2monic(1,P,P2);

/* P2 gleich 0 */

	else if (P2 == 0) P3 = pgf2monic(1,P,P1);

/* allgemeiner Fall: P1,P2 ungleich 0 */

	else {
		if (lfirst(P1) < lfirst(P2)) {
			P3 = P2;
			P2 = P1;
			P1 = P3;
		}
		do {
			H  = pgf2qrem(1,P,P1,P2,&P3);
			P1 = P2;
			P2 = P3;
		} while (P2 != 0);
		P3 = pgf2monic(1,P,P1);
	}

/* Ausgabe */

	return(P3);
}
