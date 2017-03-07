/*M
.SH NAME
pgf2prod - polynomial over Galois-field with characteristic 2 product
(recursive)

.SH SYNOPSIS
.nf
#include<_pol3.h>

pol pgf2prod(r, G, P1, P2)  
single r; 
obj G; 
pol P1, P2;

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
are polynomials in r variables over GF(2^n) with coefficients in spezial bit-representation.
.PP
pgf2prod returns a polynomial over GF(2^n), say P3, where
.IP 
P3 = P1 * P2.
           
.SH SEE ALSO
udpm2tosb

M*/
                         
/*H
	Version 1    	28.04.93	J.Schmitt
   DATE pgf2prod      : 930531
H*/

#include <_pol3.h>

pol pgf2prod(r,P,P1,P2)
single r;
pol P, P1, P2;
{
	single e1, e2, rs;
	pol P1S, P3, P3S, k1, k2;
	bind(P,P1,P2);
	init(P1S,P3,P3S,k1,k2);

/* P1 oder P2 gleich 0 */

	if (P1 == 0  ||  P2 == 0) P3 = 0;

/* Anzahl r der Variablen gleich 0 */

	else if (r == 0) P3 = gf2prod(P,P1,P2);

/* allgemeiner Fall: r,P1,P2 ungleich 0 */

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
				if (rs) k1 = pgf2prod(rs,P,k1,k2);
				else k1 = gf2prod(P,k1,k2);
				P3S = lcomp2(e1+e2,k1,P3S);
				}
			while (P1S != _0);
			P3 = pgf2sum(r,P,P3,P3S);
			}
		while (P2 != _0);
		}

/* Ausgabe */

	return(P3);
}
