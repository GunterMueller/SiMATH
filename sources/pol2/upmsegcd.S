/*M
.SH NAME 
upmsegcd - univariate polynomial over modular singles extended greatest common divisor
                                                                       
.SH SYNOPSIS                                                                    
.nf                                                                             
#include<_pol2.h>                                                               
                                                                                
pol upmsegcd(p, P1, P2, pP3, pP4) 
single p; 
pol P1, P2, *pP3, *pP4;                                                                                 
.SH DESCRIPTION
.TP 4                                                                           
.B p                                                                            
is a prime number, p < BASIS.                 
.TP 4
.B P1, P2
are univariate polynomials over Z/pZ.
.PP
upmsegcd returns the greatest common divisor of P1 and P2, say P5.              
Beyond that, upmsegcd computes the polynomials P3 and P4, where                 
.PP                                                                             
 1.) P1 * P3 + P2 * P4 = P5,                                                    
 2.) if deg(P1/P5) > 0, then deg(P4) < deg(P1/P5),                              
     else deg(P4) = 0,                                                          
 3.) if deg(P2/P5) > 0, then deg(P3) < deg(P2/P5),                              
     else deg(P3) = 0,                                                          
 4.) if P1 = 0, then P3 = 0,                                                    
 5.) if P2 = 0, then P4 = 0.                                                    
.PP                                                                             
upmsegcd writes P3, P4 to *pP3, *pP4 respectively.                              

M*/                                                                             

/*H
	Version 1	31.05.1987      B. Weis
   DATE upmsegcd      : 890501
H*/


#include <_pol2.h>

pol upmsegcd(m,P1,P2,pP3,pP4)
single m;
pol P1, P2;
pol *pP3, *pP4;
{
	pol P, P4, P5;
	bind2(P1,P2);
	init3(P,P4,P5);

/* Berechnung von P5,pP3 und pP4 */

	P5 = upmshegcd(m,P1,P2,&P4);
	if (!P1) *pP3 = 0;
	else {
		P = pmsprod(1,m,P2,P4);
		P = pmsdif(1,m,P5,P);
		*pP3 = pmsquot(1,m,P,P1);
		}
	*pP4 = P4;

/* Ausgabe */

	return(P5);
}
