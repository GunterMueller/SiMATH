/*M
.SH NAME
prfmsp1qrem - polynomial over rational functions over modular single prime, transcendence degree 1, quotient and remainder
(recursive)

.SH SYNOPSIS
.nf
#include<_pol4.h>

pol prfmsp1qrem(r, p, P1, P2, pR) 
single r, p; 
pol P1, P2, *pR;

.SH DESCRIPTION
.TP 4
.B r
is an integer number, 0 < r < BASIS.
.TP 4
.B p
is a prime number, 1 < p < BASIS.
.TP 4
.B P1, P2
are polynomials in r variables over the rational func-tion field over Z/(pZ), 
P2 != 0.
.TP 4
.B pR
points on a polynomial.
.PP
prfmsp1qrem returns the quotient of P1 and P2 and writes the remainder of the division of P1 by P2 to pR. 
 
M*/
         
/*H
	Version 1	21.11.89 		J.Schmitt
   DATE prfmsp1qrem   : 900301
H*/

#include <_pol4.h>

pol prfmsp1qrem(r,p,P1,P2,pR)
single r,p;
pol P1,P2;
pol *pR;
{
	single d, e1, e2, rs;
	pol k1, k2, q, P3, P3S, s;
	bind(P1,P2);
	init(k1,k2,q,P3,P3S,s);

	if (!r) {P3 = rfmsp1quot(p,P1,P2); *pR = 0;}
	else {
		e2 = pdegree(r,P2);
		k2 = plc(r,P2);
		P2 = pred(r,P2);
		P3 =_0;
		rs = r-1;
		while (P1) {
			e1 = pdegree(r,P1);
			d = e1-e2;
			if (d < 0) break;
			else {
				k1 = plc(r,P1);
				if (rs) q = prfmsp1qrem(rs,p,k1,k2,&s);
				else {q = rfmsp1quot(p,k1,k2); s = 0;}
				if (s) break;
				else {
					P3 = lcomp2(q,d,P3);
					P3S = list2(d,q);
					P1 = pred(r,P1);
					P3S = prfmsp1prod(r,p,P2,P3S);
					P1 = prfmsp1dif(r,p,P1,P3S);
				}
			}
		}
		if (P3 == _0) P3 = 0;
		else P3 = linv(P3);
		*pR = P1;
	}

	return(P3);
}
