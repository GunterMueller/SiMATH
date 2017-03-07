/*M
.SH NAME
pgf2qrem - polynomial over Galois-field with characteristic 2 quotient and remainder
(recursive)

.SH SYNOPSIS
.nf
#include<_pol3.h>

pol pgf2qrem(r, G, P1, P2, pR)  
single r; 
obj G; 
pol P1, P2, *pR; 
  
.SH DESCRIPTION
.TP 4
.B r
is an integer number, 0 <= r < BASIS.
.TP 4
.B G
is an univariate, monic and irreducible polynomial over Z/2Z in special bit-representation (s.udpm2tosb).
.PP
Let n be the degree of G, then G can be seen as a generator of GF(2^n)
( Galois-field with characteristic 2 ).
.TP 4
.B P1, P2
are polynomials in r variables over GF(2^n) with coefficients in spezial bit-representation, P2 != 0.
.TP 4
.B pR
points on a polynomial.
.PP     
pgf2qrem returns the quotient of P1 and P2 and writes the remainder of the division of P1 by P2 to pR.

.SH SEE ALSO
udpm2tosb

M*/
                     
/*H
	Version 1	28.04.93	J.Schmitt
   DATE pgf2qrem      : 930531
H*/

#include <_pol3.h>

pol pgf2qrem(r,P,P1,P2,pR)
single r;
pol P, P1, P2;
pol *pR;
{
	single d, e1, e2, rs;
	pol k1, k2, q, P3, P3S, s;
	bind(P,P1,P2);
	init(k1,k2,q,P3,P3S,s);

/* r gleich 0 */

	if (!r) {P3 = gf2quot(P,P1,P2); *pR = 0;}
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
				if (rs) q = pgf2qrem(rs,P,k1,k2,&s);
				else {q = gf2quot(P,k1,k2); s = 0;}
				if (s) break;
				else {
					P3 = lcomp2(q,d,P3);
					P3S = list2(d,q);
					P1 = pred(r,P1);
					P3S = pgf2prod(r,P,P2,P3S);
					P1 = pgf2sum(r,P,P1,P3S);
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
