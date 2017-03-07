/*M
.SH NAME
pnfdif - polynomial over number field difference
(recursive)

.SH SYNOPSIS
.nf
#include<_pol3.h>

pol pnfdif(r, F, P1, P2) 
single r; 
pol F, P1, P2;

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
.PP
pnfdif returns a polynomial over K, say P3, where
.IP 
P3 = P1 - P2.

M*/
 
/*H
	Version 1       16.11.1989      A.Stein
	Version 2       24.10.1990      C.H.    ( Placebo F )
   DATE pnfdif        : 900315.901120
H*/


#include <_pol3.h>

pol pnfdif(r,F,P1,P2)
single r;
pol F, P1, P2;
{
	pol P3;
	bind(P1,P2);
	init(P3);

/* P1 oder P2 gleich 0 */

	if ( !P1 ) P3 = pnfneg(r,F,P2);
	else if ( !P2 ) P3 = P1;

/* Anzahl r der Variablen gleich 0 */

	else if ( !r ) P3 = nfdif(F,P1,P2);

/* allgemeiner Fall: r,P1,P2 ungleich 0 */

	else {
		single e1, e2;
		pol k1, k2;
		init(k1,k2);

		P3 = _0;
		r--;
		do {
			e1 = lfirst(P1);
			e2 = lfirst(P2);
			if (e1 > e2) {
				P1 = lred(P1);
				k1 =lfirst(P1);
				P1 = lred(P1);
				P3 = lcomp2(k1,e1,P3);
				}
			else {
				if (e1 < e2) {
					P2 = lred(P2);
					k2 = lfirst(P2);
					P2 = lred(P2);
					k2 = (r) ? (pnfneg(r,F,k2))
						 : (nfneg(F,k2));
					P3 = lcomp2(k2,e2,P3);
					}
				else {
					P1 = lred(P1);
					P2 = lred(P2);
					k1 = lfirst(P1);
					k2 = lfirst(P2);
					P1 = lred(P1);
					P2 = lred(P2);
					k1 = (r) ? (pnfdif(r,F,k1,k2))
						 : (nfdif(F,k1,k2));
					if (k1) P3 = lcomp2(k1,e1,P3);
					}
				}
			}
		while (P1 != _0  &&  P2 != _0);
		if (P2 != _0) P1 = pnfneg(++r,F,P2);
		if (P3 == _0) P3 = P1;
		else {
			P2 = P3;
			P3 = linv(P2);
			lsred(P2,P1);
			}
		if (P3 == _0) P3 = 0;
		}

/* Ausgabe */

	return(P3);
}
