/*M
.SH NAME
upgfsegcd - univariate polynomial over Galois-field with single characteristic extended greatest common divisor

.SH SYNOPSIS
.nf
#include<_pol3.h>

pol upgfsegcd(p, AL, P1, P2, pP3, pP4)  
single p; 
list AL; 
pol P1, P2, *pP3, *pP4;
 
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
upgfsegcd returns the greatest common divisor, say Q, of P1 and P2.    
upgfsegcd writes two polynomials, say P3, P4 to *pP3 and *pP4 respectively, where
.PP
P1 * (P3) + P2 * (P4) = Q.
.PP
If deg(P1/Q) > 0, then deg(P4) < deg(P1/Q) and deg(P4) = 0, else.
.PP
If deg(P2/Q) > 0, then deg(P3) < deg(P2/Q) and deg(P3) = 0, else.
.PP
If P1 or P2 is equal to zero, then P3, P4 respectively, is equal to zero.
 
.SH SEE ALSO
gfsalgen

M*/
                                                      
/*H
	Version 1       03.11.88        J.Schmitt
   DATE upgfsegcd     : 900301.9203__
H*/

#include <_pol3.h>

pol upgfsegcd(p,AL,P1,P2,pP3,pP4)
single p;
list AL;
pol P1, P2;
pol *pP3, *pP4;
{
	pol P, P4, P5;
	bind(AL,P1,P2);
	init(P,P4,P5);

	P5 = upgfshegcd(p,AL,P1,P2,&P4);
	if (!P1) *pP3 = 0;
	else {
		P = pgfsprod(1,p,AL,P2,P4);
		P = pgfsdif(1,p,AL,P5,P);
		*pP3 = pgfsquot(1,p,AL,P,P1);
	}
	*pP4 = P4;
	return(P5);
}
