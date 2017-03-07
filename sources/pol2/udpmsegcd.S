/*M
.SH NAME
udpmsegcd - univariate dense polynomial over modular singles extended greatest common divisor

.SH SYNOPSIS
.nf
#include<_pol2.h>

pol udpmsegcd(p, P1, P2, pP3, pP4)  
single p;                                       
pol P1, P2, *pP3, *pP4;
                              
.SH DESCRIPTION
.TP 4                                                                           
.B p                                                                            
is a prime number, p < BASIS.                                                  
.TP 4                                                                           
.B P1, P2                                                                       
are univariate polynomials in dense representation over Z/pZ.                   
.PP                                                                             
udpmsegcd returns the greatest common divisor of P1 and P2, say P5.            
Beyond that, udpmsegcd computes the polynomials P3 and P4, where                
.PP                                                                             
 1.) P1 * P3 + P2 * P4 = P5,                                                    
 2.) if deg(P1/P5) > 0, then deg(P4) < deg(P1/P5),                              
     else deg(P4) = 0,                                                          
 3.) if deg(P2/P5) > 0, then deg(P3) < deg(P2/P5),                              
     else deg(P3) = 0,                                                          
 4.) if P1 = 0, then P3 = 0,                                                    
 5.) if P2 = 0, then P4 = 0.                                                    
.PP                                                                             
udpmsegcd writes P3, P4 to *pP3, *pP4 respectively.                              
M*/

/*H
	Version 1       09.01.1989      A.Stein
	Version 2       20.08.1991      "bind(*pPY);" eingefuegt.  PS
   DATE udpmsegcd     : 900315.910915
H*/


#include <_pol2.h>


pol udpmsegcd(m,P1,P2,pPX,pPY)
single m;
pol P1, P2;
pol *pPX, *pPY;
{
	pol G,H;
	bind(P1,P2);
	bind(*pPY);
	init(G,H);

	G = udpmshegcd(m,P1,P2,&H);
	*pPY = H;
	if (!P1) *pPX = 0;
	else {
		H = udpmsprod(m,P2,H);
		H = udpmsdif(m,G,H);
		*pPX = udpmsquot(m,H,P1);
	}

/* Ausgabe */

	return(G);
}
