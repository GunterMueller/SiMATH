/*M
.SH NAME
prqrem - polynomial over rationals quotient and remainder, (recursive)

.SH SYNOPSIS
.nf
#include<_pol1.h>

pol prqrem(r, P1, P2, pR) 
single r; 
pol P1, P2; 
pol *pR;

.SH DESCRIPTION
.TP 4
.B r
is an integer number, 0 <= r < BASIS.
.TP 4
.B P1, P2                                                                       
are polynomials in r variables over the rational numbers. P2 != 0.
.TP 4
.B pR
is a pointer on a pol.
.PP
prqrem computes the division with remainder of P1 by P2
.TP 4
P1 = P2 * P3 + Prem,
where Prem is the remainder of the division.                                    
.PP                                                
prqrem returns the polynomial P3 and writes Prem to *pR.

.SH SEE ALSO
 prrem
 prquot

M*/

/*H
	Version 1	31.05.1987      B. Weis
   DATE prqrem        : 890501
H*/


#include <_pol1.h>

pol prqrem(r,P1,P2,pR)
single r;
pol P1, P2;
pol *pR;
{
	single d, e1, e2, rs;
	pol k1, k2, q, P3, P3S, s;
	bind2(P1,P2);
	init3(k1,k2,q);
	init3(P3,P3S,s);

/* r gleich 0 */

	if (!r) {P3 = rquot(P1,P2); *pR = 0;}
	else {

/* Initialisierungen */

		e2 = pdegree(r,P2);
		k2 = plc(r,P2);
		P2 = pred(r,P2);
		P3 = _0;
		rs = r-1;

/* Berechnung von P1/P2 und P1%P2 */

		while (P1) {
			e1 = pdegree(r,P1);
			d = e1-e2;
			if (d < 0) break;
			else {
				k1 = plc(r,P1);
				if (rs) q = prqrem(rs,k1,k2,&s);
				else {
					q = rquot(k1,k2);
					s = 0;
					}
				if (s) break;
				else {
					P3 = lcomp2(q,d,P3);
					P3S = list2(d,q);
					P1 = pred(r,P1);
					P3S = prprod(r,P2,P3S);
					P1 = prdif(r,P1,P3S);
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
