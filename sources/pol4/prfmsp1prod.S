/*M
.SH NAME
prfmsp1prod - polynomial over rational functions over modular single prime, transcendence degree 1, product 
(recursive)

.SH SYNOPSIS
.nf
#include<_pol4.h>

pol prfmsp1prod(r, p, P1, P2) 
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
are polynomials in r variables over the rational func-tion field over Z/(pZ).
.PP
prfmsp1prod returns a polynomial, say P, where
.IP
P = P1 * P2.

M*/
      
/*H
	Version 1	21.11.89		J.Schmitt
   DATE prfmsp1prod   : 900301
H*/

#include <_pol4.h>

pol prfmsp1prod(r,p,P1,P2)
single r;
single p;
pol P1, P2;
{
	single e1, e2, rs;
	pol P1S, P3, P3S, k1, k2;
	bind(P1,P2);
	init(P1S,P3,P3S,k1,k2);

	if (P1 == 0  ||  P2 == 0) P3 = 0;
	else if (r == 0) P3 = rfmsp1prod(p,P1,P2);
	else {
		P1 = lcinv(P1);
		P2 = lcinv(P2);
		P3 = 0;
		rs = r-1;
		do {
			k2 = lfirst(P2);
			P2 = lred(P2);
			e2 = lfirst(P2);
			P2 = lred(P2);
			P1S = P1;
			P3S = _0;
			do {
				k1 = lfirst(P1S);
				P1S = lred(P1S);
				e1 = lfirst(P1S);
				P1S = lred(P1S);
				if (rs) k1 = prfmsp1prod(rs,p,k1,k2);
				else k1 = rfmsp1prod(p,k1,k2);
 				if (k1) P3S = lcomp2(e1+e2,k1,P3S);
			}
			while (P1S != _0);
			if (P3S != _0) P3 = prfmsp1sum(r,p,P3,P3S);
		}
		while (P2 != _0);
	}
	return(P3);
}
