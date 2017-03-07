/*M
.SH NAME    
upmihegcd - univariate polynomial over modular integers half extended greatest common divisor                                                                    
.SH SYNOPSIS                                                                    
.nf                                                                             
#include<_pol2.h>                                                               
                                                                                
pol upmihegcd(p, P1, P2, pP3)  
int p; 
pol P1, P2, *pP3;                                                                                 
.SH DESCRIPTION 
.TP 4                                                                           
.B p                                                                            
is a prime number.           
.TP 4
.B P1, P2
are univariate polynomials over Z/pZ.
.PP
upmihegcd returns the greatest common divisor of P1 and P2, say P4.
Beyond that, upmihegcd computes the polynomial P3 so, that there exists a polynomial P, where 
.PP
 1.) P1 * P + P2 * P3 = P4,
 2.) if deg(P1/P4) > 0, then deg(P3) < deg(P1/P4),
     else deg(P3) = 0.
 3.) if P2 = 0, then P3 = 0.
.PP
upmihegcd writes P3 to *pP3.

M*/                                                                             

/*H
	Version 1	05.08.91	J.Schmitt
   DATE upmihegcd     : 910915
H*/

#include <_pol2.h>

pol upmihegcd(P,P1,P2,pP3)
int P;
pol P1, P2;
pol *pP3;
{
	int a;
	pol P31, P32, P33, P4, Q;
	bind(P,P1,P2);
	init(a,P31,P32,P33,P4,Q);

	P31 = 0;
	P32 = list2(0,1);
	while (P2) {
		Q   = pmiqrem(1,P,P1,P2,&P4);
		P33 = pmiprod(1,P,Q,P32);
		P33 = pmidif(1,P,P31,P33);
		P1  = P2;
		P2  = P4;
		P31 = P32;
		P32 = P33;
	}
	if (!P1) {
		P4   = 0;
		*pP3 = 0;
	}
	else {
		a    = lsecond(P1);
		a    = miinv(P,a);
		P4   = pmimiprod(1,P,P1,a);
		*pP3 = pmimiprod(1,P,P31,a);
	}
	return(P4);
}
