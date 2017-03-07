/*M
.SH NAME
udpmshegcd - univariate dense polynomial over modular singles half extended greatest common divisor
 
.SH SYNOPSIS
.nf
#include<_pol2.h>

pol udpmshegcd(p, P1, P2, pP3)                                                  
single p;                                                                       
pol P1, P2, *pP3;                

.SH DESCRIPTION
.TP 4                                                                           
.B p                                                                            
is a prime number, p < BASIS.                                                   
.TP 4                                                                           
.B P1, P2                                                                       
are univariate polynomials in dense representation over Z/pZ.                   
.PP                                                                             
udpmshegcd returns the greatest common divisor of P1 and P2, say P4.            
Beyond that, udpmshegcd computes the polynomial P3 so, that there exists a polynomial P, where
.PP                                                                             
 1.) P1 * P + P2 * P3 = P4,                                                     
 2.) if deg(P1/P4) > 0, then deg(P3) < deg(P1/P4),                              
     else deg(P3) = 0.                                                          
 3.) if P2 = 0, then P3 = 0.                                                    
.PP                                                                             
udpmshegcd writes P3 to *pP3.                                                    
M*/

/*H
	Version 1       09.01.1989      A.Stein
   DATE udpmshegcd    : 900315.9109__
H*/


#include <_pol2.h>

pol udpmshegcd(m,P1,P2,pPY)
single m;
pol P1, P2;
pol *pPY;
{
	pol Q;
	bind(P1,P2);
	init(Q);

	Q = udpmsqrem(m,P2,P1,&P2);

/*      P2 mod P1 == 0  => P1 teilt P2 und GGT(P1,P2) == P1 !!  */
/*      Dann gilt:  1 * P1  +  0 * P2  == P1 == GGT(P1,P2)      */

	if ( !P2 ) *pPY = 0;
	else {
		pol H, S0, S1, S2;
		bind(H,S0,S1,S2);

		S1 = 0;
		S2 = list2(0,1);
		Q = udpmsqrem(m,P1,P2,&H);
		while ( H ) {
			S0 = S1; S1 = S2;
			S2 = udpmsprod(m,Q,S1);
			S2 = udpmsdif(m,S0,S2);
			P1 = P2; P2 = H;
			Q = udpmsqrem(m,P1,P2,&H);
		}
		*pPY = S2;
		P1 = P2;
	}

/* Ausgabe */

	return(P1);
}
