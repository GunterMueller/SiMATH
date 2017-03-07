/*M
.SH NAME
upgf2hegcd - univariate polynomial over Galois-field with characteristic 2, half extended greatest common divisor

.SH SYNOPSIS
.nf
#include<_pol3.h>

pol upgf2hegcd(G, P1, P2, pP3)  
list G; 
pol P1, P2, *pP3;
 
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
upgf2hegcd returns the greatest common divisor, say Q, of P1 and P2.
upgf2hegcd writes a univariate polynomial, say P3, to *pP3, such that
.PP
.nf
there exists a polynomial, say P, such that
P1 * P + P2 * P3 = Q.
.PP
If deg(P1/Q) > 0, then deg(P3) < deg(P1/Q) and deg(P3) = 0, else.
.PP
If P2 = 0, then P3 = 0.
                              
.SH SEE ALSO
udpm2tosb

M*/
                    
/*H
	Version 1       15.07.1994      S.Schmitt
   DATE upgf2hegcd    : 941201
H*/

#include <_pol3.h>

pol upgf2hegcd(G,P1,P2,pP3)
obj G;
pol P1, P2;
pol *pP3;
{
	gfel a;
	pol P31, P32, P33, P4, Q;
	bind(G,P1,P2);
	init(a,P31,P32,P33,P4,Q);

	P31 = 0;
	P32 = list2(0,1);
	P32 = list2(0,P32);
	while (P2) {
		Q = pgf2qrem(1,G,P1,P2,&P4);
		P33 = pgf2prod(1,G,Q,P32);
		P33 = pgf2dif(1,G,P31,P33);
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
		a = gf2inv(G,a);
		P4 = pgf2gf2prod(1,G,P1,a);
		*pP3 = pgf2gf2prod(1,G,P31,a);
	}

	return(P4);
}
