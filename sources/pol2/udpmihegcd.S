/*M
.SH NAME
udpmihegcd - univariate dense polynomial over modular integers half extended greatest common divisor

.SH SYNOPSIS
.nf
#include<_pol2.h>

pol udpmihegcd(p, P1, P2, pP3)
int p;
pol P1, P2, *pP3;

.SH DESCRIPTION
.TP 4                                                                           
.B p                                                                            
is a prime number.                                                              
.TP 4                                                                           
.B P1, P2                                                                       
are univariate polynomials in dense representation over Z/pZ.                  
.PP                                                                             
udpmihegcd returns the greatest common divisor of P1 and P2, say P4, P4 is monic.             
Beyond that, udpmihegcd computes the polynomial P3 so, that there exists a polynomial P, where
.PP                                                                             
 1.) P1 * P + P2 * P3 = P4,                                                     
 2.) if deg(P1/P4) > 0, then deg(P3) < deg(P1/P4),                              
     else deg(P3) = 0.                                                          
 3.) if P2 = 0, then P3 = 0.                                                    
.PP                                                                             
udpmihegcd writes P3 to *pP3.                                                    
M*/

/*H
	Version 1 	16.08.91	J.Schmitt
   DATE udpmihegcd    : 910915
H*/

#include <_pol2.h>

pol udpmihegcd(m,P1,P2,pP3)
int m;
pol P1, P2;
pol *pP3;
{
	int a;
	pol P31, P32, P33, P4, Q;
	bind(m,P1,P2);
	init(a,P31,P32,P33,P4,Q);

/* Berechnung von P4 und pP3 */

	P31 = 0;
	P32 = list2(0,1);
	while (P2) {
		Q   = udpmiqrem(m,P1,P2,&P4);
		P33 = udpmiprod(m,Q,P32);
		P33 = udpmidif(m,P31,P33);
		P1  = P2;
		P2  = P4;
		P31 = P32;
		P32 = P33;
	}
	if (!P1) {
		P4 = 0;
		*pP3 = 0;
	}
	else {
		a  = lsecond(P1);
		a  = miinv(m,a);
		P4 = udpmimiprod(m,P1,a);
		*pP3 = udpmimiprod(m,P31,a);
	}

	return(P4);
}
