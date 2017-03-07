/*M
.SH NAME
pnfneg - polynomial over number field negation 
(recursive)  
.SH SYNOPSIS
.nf
#include<_pol3.h>

pol pnfneg(r, F, P) 
single r; 
pol F, P;

.SH DESCRIPTION
.TP 4
.B r
is an integer number, 0 <= r < BASIS.
.TP 4
.B F
is an irreducible, univariate polynomial in dense representation over Z. F generates a number field, say K.          
.TP 4
.B P
is a polynomial in r variables over K.
.PP
pnfneg returns a polynomial over K, say P1, where
.IP
P1 = -P.

M*/
                           
/*H
	Version 1       16.11.1989      A.Stein
	Version 2       24.10.1990      C.H.  ( Placebo F )
   DATE pnfneg        : 900315.901120
H*/


#include <_pol3.h>

pol pnfneg(r,F,P)
single r;
pol F,P;
{
	pol P1;
	bind(P);
	init(P1);

/* P gleich 0 */

	if ( !P ) P1 = 0;

/* Anzahl r der Variablen gleich 0 */

	else if ( !r ) P1 = nfneg(F,P);

/* allgemeiner Fall: r,P ungleich 0 */

	else {
		single e;
		pol k;
		init(k);

		r--;
		P1 = _0;
		do {
			e = lfirst(P);
			P = lred(P);
			k = lfirst(P);
			P = lred(P);
			k = (r) ? (pnfneg(r,F,k)) : (nfneg(F,k));
			P1 = lcomp2(k,e,P1);
			}
		while (P != _0);
		P1 = linv(P1);
		}

/* Ausgabe */

	return(P1);
}
