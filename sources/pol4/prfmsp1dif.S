/*M
.SH NAME
prfmsp1dif - polynomial over rational functions over modular single prime, transcendence degree 1, difference
(recursive)
 
.SH SYNOPSIS
.nf
#include<_pol4.h>

pol prfmsp1dif(r, p, P1, P2) 
single r, p; 
pol P1, P2; 
 
.SH DESCRIPTION
.TP 4
.B r
is an integer number, 0 < r < BASIS.
.TP 4
.B p
is a prime number, 1 < p < BASIS.
.TP 4
.B P1, P2
are polynomials in r variables over the rational 
func-tion field over Z/(pZ).
.PP
prfmsp1dif returns a polynomial P (say), where
.IP
P = P1 - P2.
  
M*/
                
/*H
	Version 1	21.11.89		J.Schmitt
   DATE prfmsp1dif    : 900301
H*/

#include <_pol4.h>

pol prfmsp1dif(r,p,P1,P2)
single r;
single p;
pol P1, P2;
{
	single e1, e2;
	pol P3, k1, k2;
	bind(P1,P2);
	init(P3,k1,k2);

	if (P1 == 0) P3 = prfmsp1neg(r,p,P2);
	else if (P2 == 0) P3 = P1;
	else if (r == 0) P3 = rfmsp1dif(p,P1,P2);
	else {
		P3 = _0;
		r--;
		do {
			e1 = lfirst(P1);
			e2 = lfirst(P2);
			if (e1 > e2) {
				P1 = lred(P1);
				k1 = lfirst(P1);
				P1 = lred(P1);
				P3 = lcomp2(k1,e1,P3);
			}
			else {
				if (e1 < e2) {
					P2 = lred(P2);
					k2 = lfirst(P2);
					P2 = lred(P2);
					if (r) k2 = prfmsp1neg(r,p,k2);
					else k2 = rfmsp1neg(p,k2);
					P3 = lcomp2(k2,e2,P3);
				}
				else {
					P1 = lred(P1);
					P2 = lred(P2);
					k1 = lfirst(P1);
					k2 = lfirst(P2);
					P1 = lred(P1);
					P2 = lred(P2);
					if (r) k1 = prfmsp1dif(r,p,k1,k2);
					else k1 = rfmsp1dif(p,k1,k2);
					if (k1) P3 = lcomp2(k1,e1,P3);
				}
			}
		}
		while (P1 != _0  &&  P2 != _0);
		if (P2 != _0) P1 = prfmsp1neg(++r,p,P2);
		if (P3 == _0) P3 = P1;
		else {
			P2 = P3;
			P3 = linv(P2);
			lsred(P2,P1);
		}
		if (P3 == _0) P3 = 0;
	}
	return(P3);
}
