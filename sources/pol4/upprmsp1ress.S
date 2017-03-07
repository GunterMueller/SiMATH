/*M
.SH NAME
upprmsp1ress - univariate polynomial over polynomial ring over modular single prime, transcendence degree 1, resultant, Sylvester algorithm

.SH SYNOPSIS
.nf
#include<_pol4.h>

pol upprmsp1ress(p, P1, P2) 
single p; 
pol P1, P2;

.SH DESCRIPTION
.TP 4
.B p
is a prime number, p < BASIS.
.TP 4
.B P1, P2
are univariate polynomials over the polynomial ring in x over Z/(pZ).   
.PP
upprmsp1ress returns the resultant of P1 and P2.

M*/
            
/*H
	Version 1	20.11.89		J.Schmitt
   DATE upprmsp1ress  : 901120
H*/

#include <_pol4.h>

pol upprmsp1ress(p,P1,P2)
single p;
pol P1,P2;
{
	single e1,e2;
	pol H,P3,k1,k2;
	init(H,P3,k1,k2);
	bind(P1,P2);

	if (!P1 || !P2) return(0);
	if ( !lfirst(P1) && !lfirst(P2) ) {
		H = list2(0,1);
		return(H);
	}
	if ( !lfirst(P1) ) {
		H = pmsexp(1,p,lsecond(P1),lfirst(P2));
		return(H);
	}
	if ( !lfirst(P2) ) {
		H = pmsexp(1,p,lsecond(P2),lfirst(P1));
		return(H);
	}
	H = P1;
	while (H != _0) {
		e1 = lfirst(H);
		H = lred(H);
		k1 = lfirst(H);
		H = lred(H);
	}
	H = P2;
	while (H != _0) {
		e2 = lfirst(H);
		H = lred(H);
		k2 = lfirst(H);
		H = lred(H);
	}
	H = list2(0,1);
	if (e1  &&  e2) return(0);
        if (e1) {
		P1 = ppmvquot(1,P1,e1);
		H = pmsexp(1,p,k2,e1);
		if (!lfirst(P1)) {
			P3 = pmsexp(1,p,lsecond(P1),lfirst(P2));
			H = pmsprod(1,p,P3,H);
			return(H);
		}
	}
	if (e2) {
		P2 = ppmvquot(1,P2,e2);
		H = pmsexp(1,p,k1,e2);
		if (sodd(e2)  &&  sodd(lfirst(P1))) H = pmsneg(1,p,H);
		if (!lfirst(P2)) {
			P3 = pmsexp(1,p,lsecond(P2),lfirst(P1));
                        H = pmsprod(1,p,P3,H);
			return(H);
		}
	}	               
	P3 = psylvester(1,P1,P2);
	P3 = mapmsdet(1,p,P3);   
	P3 = pmsprod(1,p,P3,H);
	return(P3);
}



                                            
	
