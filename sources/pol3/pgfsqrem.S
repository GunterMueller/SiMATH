/*M
.SH NAME
pgfsqrem - polynomial over Galois-field with single characteristic quotient and remainder
(recursive)

.SH SYNOPSIS
.nf
#include<_pol3.h>

pol pgfsqrem(r, p, AL, P1, P2, pR)  
single r, p; 
list AL; 
pol P1, P2, *pR;
 
.SH DESCRIPTION
.TP 4
.B r
is an integer number, 0 <= r < BASIS.
.TP 4
.B p
is a prime number, p < BASIS.
.TP 4
.B AL
= (G AL1) can be seen as an arithmetic list of GF(p^n), where n = lenght(AL1)+1 (s. gfsalgen).
.TP 4
.B P1, P2
are polynomials in r variables over GF(p^n).
.PP                                        
pgfsqrem returns the quotient of P1 and P2 and writes the remainder of the division of P1 by P2 to pR.

.SH SEE ALSO
gfsalgen

M*/
                                        
/*H
	Version 1         23.03.88           J.Schmitt
   DATE pgfsqrem      : 890501.9203__
H*/


#include <_pol3.h>

pol pgfsqrem(r,p,AL,P1,P2,pR)
single r,p;
list AL;
pol P1, P2;
pol *pR;
{
	single d, e1, e2, rs;
	pol k1, k2, q, P3, P3S, s;
	bind(P1,P2,AL);
	init(k1,k2,q,P3,P3S,s);

/* r gleich 0 */

	if (!r) {P3 = gfsquot(p,AL,P1,P2); *pR = 0;}
	else {

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
				if (rs) q = pgfsqrem(rs,p,AL,k1,k2,&s);
				else {q = gfsquot(p,AL,k1,k2); s = 0;}
				if (s) break;
				else {
					P3 = lcomp2(q,d,P3);
					P3S = list2(d,q);
					P1 = pred(r,P1);
					P3S = pgfsprod(r,p,AL,P2,P3S);
					P1 = pgfsdif(r,p,AL,P1,P3S);
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
