/*M
.SH NAME
pgfsprod - polynomial over Galois-field with single characteristic product
(recursive)

.SH SYNOPSIS
.nf
#include<_pol3.h>

pol pgfsprod(r, p, AL, P1, P2)  
single r, p; 
list AL;  
pol P1, P2;
 
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
pgfsprod returns a polynomial over GF(p^n), say P3, where
.IP
P3 = P1 * P2.

.SH SEE ALSO
gfsalgen

M*/
                     
/*H
	Version 1         23.03.88           J.Schmitt
   DATE pgfsprod      : 890501.9203__
H*/


#include <_pol3.h>

pol pgfsprod(r,p,AL,P1,P2)
single r,p;
list AL;
pol P1, P2;
{
	single e1, e2, rs;
	pol P1S, P3, P3S, k1, k2;
	bind(P1,P2,AL);
	init(P1S,P3,P3S,k1,k2);

/* P1 oder P2 gleich 0 */

	if (P1 == 0  ||  P2 == 0) P3 = 0;

/* Anzahl r der Variablen gleich 0 */

	else if (r == 0) P3 = gfsprod(p,AL,P1,P2);

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
				if (rs) k1 = pgfsprod(rs,p,AL,k1,k2);
				else k1 = gfsprod(p,AL,k1,k2);
				P3S = lcomp2(e1+e2,k1,P3S);
				}
			while (P1S != _0);
			P3 = pgfssum(r,p,AL,P3,P3S);
			}
		while (P2 != _0);
		}

/* Ausgabe */

	return(P3);
}
