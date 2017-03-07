/*M
.SH NAME
uprfmsp1egcd - univariate polynomial over rational functions over modular single prime, transcendence degree 1, extended greatest common divisor

.SH SYNOPSIS
.nf
#include<_pol4.h>

pol uprfmsp1egcd(p, P1, P2, pF1, pF2) 
single p; 
pol P1, P2,*pF1,*pF2;
  
.SH DESCRIPTION
.TP 4
.B p
is a prime number, p < BASIS.
.TP 4
.B P1, P2
are univariate polynomials over the rational function field over Z/(pZ).
.PP
uprfmsp1egcd returns the monic gcd of P1 and P2, say F. In addition, uprfmsp1egcd writes two polynomials, say F1 and F2, to *pF1 and *pF2 respectively, such that 
.TP 4
1) 
F1 * P1 + F2 * P2 = F,
.TP 4
2) 
deg(F2) < deg(P1/F) for deg(P1/F) > 0, deg(F2) = 0 else.
.TP 4
3)
deg(F1) < deg(P2/F) for deg(P2/F) > 0, deg(F1) = 0 else.
.TP 4
4)
If P1 = 0, then F1 = 0.
.TP 4
4)
If P2 = 0, then F2 = 0.
 
M*/
       
/*H
	Version 1	21.11.89		J.Schmitt
   DATE uprfmsp1egcd  : 900301
H*/

#include <_pol4.h>

pol uprfmsp1egcd(p,P1,P2,pF1,pF2)
single p;
pol P1, P2;                     
pol *pF1, *pF2;
{
	pol F1, F2, P31, P32, P33, P4, Q;
	bind(P1,P2);
	init(F1,F2,P31,P32,P33,P4,Q);

	F1  = P1;                  
	F2  = P2;
        P31 = 0;
	P32 = list2(0,1);
	P33 = list2(0,1);
	P32 = list2(P32,P33);
	P32 = list2(0,P32);
	while ( F2 ) {  
		Q = prfmsp1qrem(1,p,F1,F2,&P4);
		P33 = prfmsp1prod(1,p,Q,P32);
		P33 = prfmsp1dif(1,p,P31,P33);
		F1  = F2;
		F2  = P4;
		P31 = P32;
		P32 = P33;
	}
	if (!F1) {      
		*pF1 = 0;
		*pF2 = 0;
		return(0);
	}
	P32 = lsecond(F1);
	P32 = rfmsp1inv(p,P32);
	F1  = prfmsp1rfprd(1,p,F1,P32);
	P32 = prfmsp1rfprd(1,p,P31,P32);
	if (P1) {
		P33 = prfmsp1prod(1,p,P2,P32);
		P33 = prfmsp1dif(1,p,F1,P33);
		F2  = prfmsp1qrem(1,p,P33,P1,&P4);
	}             	
        else F2 = 0;
        *pF1 = F2;
        *pF2 = P32;
	return(F1);
}
