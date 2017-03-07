/*M
.SH NAME
upmiegcd - univariate polynomial over modular integers extended greatest common divisor

.SH SYNOPSIS
.nf
#include<_pol2.h>

pol upmiegcd(p, P1, P2, pP3, pP4)  int p; 
pol P1, P2, *pP3, *pP4;
  
.SH DESCRIPTION
.TP 4
.B p
is a prime number.
.TP 4
.B P1, P2
are univariate polynomials over Z/pZ.
.PP
upmiegcd returns the greatest common divisor of P1 and P2, say P5.
Beyond that, upmiegcd computes the polynomials P3 and P4, where
.PP
 1.) P1 * P3 + P2 * P4 = P5,
 2.) if deg(P1/P5) > 0, then deg(P4) < deg(P1/P5), 
     else deg(P4) = 0,
 3.) if deg(P2/P5) > 0, then deg(P3) < deg(P2/P5), 
     else deg(P3) = 0,
 4.) if P1 = 0, then P3 = 0,
 5.) if P2 = 0, then P4 = 0.
.PP
upmiegcd writes P3, P4 to *pP3, *pP4 respectively.

M*/

/*H
	Version 1	05.08.91	J.Schmitt
   DATE upmiegcd      : 910915
H*/

#include <_pol2.h>

pol upmiegcd(P,P1,P2,pP3,pP4)
int P;
pol P1,P2;
pol *pP3,*pP4;
{
	pol Q,P4,P5;
	bind(P,P1,P2);
	init(Q,P4,P5);


	P5 = upmihegcd(P,P1,P2,&P4);
	if ( !P1 ) *pP3 = 0;
	else {
		Q = pmiprod(1,P,P2,P4);
		Q = pmidif(1,P,P5,Q);
		*pP3 = pmiquot(1,P,Q,P1);
	}
	*pP4 = P4;
	return(P5);
}
