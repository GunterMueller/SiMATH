/*M
.SH NAME
upmshegcd univariate polynomial over modular singles half extended greatest common divisor
                                                                        
.SH SYNOPSIS                                                                    
.nf                                                                             
#include<_pol2.h>                                                               
                                                                                
pol upmshegcd(p, P1, P2, pP3) 
single p; 
pol P1, P2, *pP3;                                                                                 
.SH DESCRIPTION
.TP 4
.B p
is a prime number, p < BASIS.
.TP 4
.B P1, P2
are univariate polynomials over Z/pZ.
.PP
upmshegcd returns the greatest common divisor of P1 and P2, say P4.             
Beyond that, upmshegcd computes the polynomial P3 so, that there exists a polynomial P, where
.PP                                                                             
 1.) P1 * P + P2 * P3 = P4,                                                     
 2.) if deg(P1/P4) > 0, then deg(P3) < deg(P1/P4),                              
     else deg(P3) = 0,                                                          
 3.) if P2 = 0, then P3 = 0.                                                    
.PP                                                                             
upmshegcd writes P3 to *pP3.                                                    
                                                                               
M*/                                                                             

/*H
	Version 1	31.05.1987      B. Weis
   DATE upmshegcd     : 890501
H*/


#include <_pol2.h>

pol upmshegcd(m,P1,P2,pP3)
single m;
pol P1, P2;
pol *pP3;
{
	single a;
	pol P31, P32, P33, P4, Q;
	bind2(P1,P2);
	init5(P31,P32,P33,P4,Q);

/* Berechnung von P4 und pP3 */

	P31 = 0;
	P32 = list2(0,1);
	while (P2) {
		Q = pmsqrem(1,m,P1,P2,&P4);
		P33 = pmsprod(1,m,Q,P32);
		P33 = pmsdif(1,m,P31,P33);
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
		a = msinv(m,a);
		P4 = pmsmsprod(1,m,P1,a);
		*pP3 = pmsmsprod(1,m,P31,a);
		}

/* Ausgabe */

	return(P4);
}
