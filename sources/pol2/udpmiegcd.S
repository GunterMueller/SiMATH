/*M
.SH NAME
udpmiegcd - univariate dense polynomial over modular integers extended greatest common divisor

.SH SYNOPSIS
.nf
#include<_pol2.h>

pol udpmiegcd(p, P1, P2, pP3, pP4)  
int p;                                       
pol P1, P2, *pP3, *pP4;
                
.SH DESCRIPTION
.TP 4                                                                           
.B p                                                                            
is a prime number.                                                              
.TP 4                                                                           
.B P1, P2                                                                       
are univariate polynomials in dense representation over Z/pZ.                  
.PP                                                                             
udpmiegcd returns the monic greatest common divisor of P1 and P2, say P5.       
Beyond that, udpmiegcd computes the polynomials P3 and P4, where                
.PP                                                                             
 1.) P1 * P3 + P2 * P4 = P5,                                                    
 2.) if deg(P1/P5) > 0, then deg(P4) < deg(P1/P5),                              
     else deg(P4) = 0,                                                          
 3.) if deg(P2/P5) > 0, then deg(P3) < deg(P2/P5),                              
     else deg(P3) = 0,                                                          
 4.) if P1 = 0, then P3 = 0,                                                    
 5.) if P2 = 0, then P4 = 0.                                                    
.PP                                                                             
udpmiegcd writes P3, P4 to *pP3, *pP4 respectively.                              
M*/

/*H
	Version 1 	16.08.91	J.Schmitt
   DATE udpmiegcd     : 910915
H*/

#include <_pol2.h>

pol udpmiegcd(m,P1,P2,pP3,pP4)
int m;
pol P1, P2;
pol *pP3, *pP4;
{
	pol P,P4,P5;
	bind(m,P1,P2);
	init(P,P4,P5);

	P5 = udpmihegcd(m,P1,P2,&P4);
	if (!P1) *pP3 = 0;
	else {
		P = udpmiprod(m,P2,P4);
		P = udpmidif(m,P5,P);
		*pP3 = udpmiqrem(m,P,P1,&P);
	}
	*pP4 = P4;

/* Ausgabe */

	return(P5);
}
