/*M
.SH NAME
upgf2egcd - univariate polynomial over Galois-field with characteristic 2, extended greatest common divisor

.SH SYNOPSIS
.nf
#include<_pol3.h>

pol upgf2egcd(G, P1, P2, pP3, pP4)
obj G; 
pol P1, P2, *pP3, *pP4;
   
.SH DESCRIPTION
.TP 4
.B G
is an irreducible monic univariate polynomial over GF(2)
of degree n > 1 with coefficients in special bit notation
(see udpm2tosb). G is interpreted as a generating polynomial
of the field GF(2^n).
.TP 4                     
.B P1, P2
are univariate polynomials over GF(2^n), with coefficients given in special bit-representation.
.PP
upgf2egcd returns the greatest common divisor, say Q, of P1 and P2.       
upgf2egcd writes two polynomials, say P3, P4 to *pP3 and *pP4 respectively, where
.PP
P1 * (P3) + P2 * (P4) = Q.
.PP
If deg(P1/Q) > 0, then deg(P4) < deg(P1/Q) and deg(P4) = 0, else.
.PP
If deg(P2/Q) > 0, then deg(P3) < deg(P2/Q) and deg(P3) = 0, else.
.PP
If P1 or P2 is equal to zero, then P3, P4 respectively, is equal to zero.
              
.SH SEE ALSO
udpm2tosb

M*/
           
/*H
	Version 1  	15.07.1994        S.Schmitt
   DATE upgf2egcd     : 941201
H*/

#include <_pol3.h>

pol upgf2egcd(G,P1,P2,pP3,pP4)
obj G;
pol P1, P2;
pol *pP3, *pP4;
{
	pol P, P4, P5;
	bind(G,P1,P2);
	init(P,P4,P5);

	P5 = upgf2hegcd(G,P1,P2,&P4);
	if (!P1) *pP3 = 0;
	else {
		P = pgf2prod(1,G,P2,P4);
		P = pgf2dif(1,G,P5,P);
		*pP3 = pgf2quot(1,G,P,P1);
	}
	*pP4 = P4;
	return(P5);
}
