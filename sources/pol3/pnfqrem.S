/*M
.SH NAME
pnfqrem - polynomial over number field quotient and remainder
(recursive)

.SH SYNOPSIS
.nf
#include<_pol3.h>

pol pnfqrem(r, F, P1, P2, pR) 
single r;  
pol F, P1, P2, *pR; 
   
.SH DESCRIPTION
.TP 4
.B r
is an integer number, 0 <= r < BASIS.
.TP 4
.B F
is an irreducible, univariate polynomial in dense representation over Z. F generates a number field, say K.
.TP 4
.B P1, P2
are polynomials in r variables over K.
.TP 4
.B pR
points on a polynomial.
.PP                   
pnfqrem returns the quotient of P1 and P2 and writes the remainder of the division of P1 by P2 to pR.

M*/
          
/*H
	Version 1       16.11.1989      A.Stein
	Version 2       29.10.1990      C.H.    pnfdif( r, F, ... )
   DATE pnfqrem       : 900315.901120
H*/


#include <_pol3.h>

pol pnfqrem(r,F,P1,P2,pR)
single r;
pol F, P1, P2;
pol *pR;
{
	pol P3;
	bind(F,P1,P2);
	init(P3);

/* r gleich 0 */

	if (!r) {P3 = nfquot(F,P1,P2); *pR = 0;}
	else {
		single d, e1, e2, rs;
		pol k1, k2, q, P3S, s;
		init(k1,k2,q,P3S,s);

/* Initialisierungen */

		e2 = pdegree(r,P2);
		k2 = plc(r,P2);
		P2 = pred(r,P2);
		P3 =_0;
		rs = r-1;

/* Berechnung von P1/P2 und P1%P2 */

		while (P1) {
			e1 = pdegree(r,P1);
			d = e1-e2;
			if (d < 0) break;
			else {
				k1 = plc(r,P1);
				if (rs) q = pnfqrem(rs,F,k1,k2,&s);
				else {q = nfquot(F,k1,k2); s = 0;}
				if (s) break;
				else {
					P3 = lcomp2(q,d,P3);
					P3S = list2(d,q);
					P1 = pred(r,P1);
					P3S = pnfprod(r,F,P2,P3S);
					P1 = pnfdif(r,F,P1,P3S);
					}
				}
			}
		if (P3 == _0) P3 = 0;
		else P3 = linv(P3);
		*pR = P1;
		}

/* Ausgabe */

	return(P3);
}
