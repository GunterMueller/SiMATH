/*M
.SH NAME
upgfshegcd - univariate polynomial over Galois-field with single characteristic half extended greatest common divisor

.SH SYNOPSIS
.nf
#include<_pol3.h>

pol upgfshegcd(p, AL, P1, P2, pP3)  
single p; 
list AL; 
pol P1, P2, *pP3;

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
upgfshegcd returns the greatest common divisor, say Q, of P1 and P2.
upgfshegcd writes a univariate polynomial, say P3, to *pP3, such that
.PP
.nf
there exists a polynomial, say P, such that
P1 * P + P2 * P3 = Q.
.PP
If deg(P1/Q) > 0, then deg(P3) < deg(P1/Q) and deg(P3) = 0, else.
.PP
If P2 = 0, then P3 = 0.

.SH SEE ALSO
gfsalgen

M*/
    
/*H
	Version 1       11.04.1989      J.Schmitt
   DATE upgfshegcd    : 900301.9203__
H*/

#include <_pol3.h>

pol upgfshegcd(p,AL,P1,P2,pP3)
single p;
list AL;
pol P1, P2;
pol *pP3;
{
	gfel a;
	pol P31, P32, P33, P4, Q;
	bind(AL,P1,P2);
	init(a,P31,P32,P33,P4,Q);

	P31 = 0;
	P32 = list2(0,1);
	P32 = list2(0,P32);
	while (P2) {
		Q = pgfsqrem(1,p,AL,P1,P2,&P4);
		P33 = pgfsprod(1,p,AL,Q,P32);
		P33 = pgfsdif(1,p,AL,P31,P33);
		P1 = P2;
		P2 = P4;
		P31 = P32;
		P32 = P33;
	}
	if (!P1) {
		P4 = 0;
		*pP3 = 0;
	}
	else {
		a = lsecond(P1);
		a = gfsinv(p,AL,a);
		P4 = pgfsgfsprod(1,p,AL,P1,a);
		*pP3 = pgfsgfsprod(1,p,AL,P31,a);
	}

	return(P4);
}
