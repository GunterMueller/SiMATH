/*M
.SH NAME
upnfegcd - univariate polynomial over number field extended greatest common divisor

.SH SYNOPSIS
.nf
#include<_pol3.h>

pol upnfegcd(F, P1, P2,  pA1, pA2)  
pol F, P1, P2, *pA1, *pA2;
 
.SH DESCRIPTION
Let K be a number field, 
.TP 4
.B F
is the respective univariate minimal polynomial of degree >= 1 in dense representation, i.e. K arises by the adjunction of a root of F.
.TP 4
.B P1, P2 
are univariate polynomials over K.
.TP 4
.B pA1, pA2
point on two polynomials.
.PP
upnfegcd1 returns the (monic) greatest common divisor, say Q, of P1 and P2.
upnfegcd writes two polynomials, say *pA1, *pA2 to pA1 and pA2 respectively, where
.IP
P1 * (*pA1) + P2 * (*pA2) = Q, and
.IP
deg(*pA1) < deg(P2/Q) and deg(*pA2) < deg(P1/Q)
.PP
(Expect for deg(P2/Q) = deg(P1/Q) = 0 or P1 or P2 equal to zero.)

M*/
                                        
/*H
	Version 1	09.03.95	Wolfgang Schwarz
   DATE upnfegcd      : 951201
H*/

#include <_pol3.h>

pol upnfegcd(F,P1,P2,pA1,pA2)
pol F, P1, P2, *pA1, *pA2;
{
	pol Q,R,A1,A2,B1,B2,BB1,BB2;
	nfel c;
	bind(F,P1,P2);
	init(Q,R,A1,A2,B1,B2,BB1,BB2,c);

/* Initialisierung und Spezialfaelle */

	if (P1)
	  {	c = plbc(1,P1);
 		c = nfinv(F,c);
 		P1 = pnfnfprod(1,F,P1,c); /*normieren */
		A1 = list2(0,c);
		A2 = 0;
	  }
	if (P2)
	  {	c = plbc(1,P2);
 		c = nfinv(F,c);
 		P2 = pnfnfprod(1,F,P2,c); /*normieren */
		B2 = list2(0,c);
		B1 = 0;
	  }
	else 
	 {	if (!P1) {*pA1=0;*pA2=0;}
	  	else {*pA1=A1;*pA2=A2;}
	  	return(P1);
	 }

/* Schleife */
 		
	while (1)
	  {	Q = pnfqrem(1,F,P1,P2,&R); 
		if (!R) {		  /* Ausgabe */
		      	*pA1 = B1; 
			*pA2 = B2;
			return(P2);}
	  	P1=P2;
		c = plbc(1,R);
 		c = nfinv(F,c);
 		P2 = pnfnfprod(1,F,R,c); /*normieren */
		BB1 = pnfprod(1,F,Q,B1);
		BB1 = pnfdif(1,F,A1,BB1);	
		BB2 = pnfprod(1,F,Q,B2);
		BB2 = pnfdif(1,F,A2,BB2);	
		A1 = B1;
		A2 = B2;
		B1 = pnfnfprod(1,F,BB1,c);
		B2 = pnfnfprod(1,F,BB2,c);
	  }	
}

