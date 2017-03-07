/*M
.SH NAME
pnfprod - polynomial over number field product
(recursive)

.SH SYNOPSIS
.nf
#include<_pol3.h>

pol pnfprod(r, F, P1, P2) 
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
pnfprod returns a polynomial over K, say P3, where
.IP
P3 = P1 * P2.                                        

M*/
     
/*H
	Version 1       16.11.1989      A.Stein
	Version 2       29.10.1990      C.H.    pnfsum( r, F, ... )
   DATE pnfprod       : 900315.901120
H*/


#include <_pol3.h>

pol pnfprod(r,F,P1,P2)
single r;
pol F, P1, P2;
{
	pol P3;
	bind(F,P1,P2);
	init(P3);

/* P1 oder P2 gleich 0 */

	if ( !P1 || !P2 ) P3 = 0;

/* Anzahl r der Variablen gleich 0 */

	else if ( !r ) P3 = nfprod(F,P1,P2);

/* allgemeiner Fall: r,P1,P2 ungleich 0 */

	else {
		single e1, e2, rs;
		pol P1S, P3S, k1, k2;
		init(P1S,P3S,k1,k2);

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
				k1 = (rs) ? (pnfprod(rs,F,k1,k2))
					  : (nfprod(F,k1,k2));
				P3S = lcomp2(e1+e2,k1,P3S);
				}
			while (P1S != _0);
			P3 = pnfsum(r,F,P3,P3S);
			}
		while (P2 != _0);
		}

/* Ausgabe */

	return(P3);
}
