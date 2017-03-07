/*M
.SH NAME
pnfnfprod - polynomial over number field, number field element product 
(recursive)

.SH SYNOPSIS
.nf
#include<_pol3.h>

pol pnfnfprod(r, F, P, a) 
single r; 
pol F, P; 
nfel a;
  
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
.TP 4
.B a
is an element in K.
.PP
pnfnfprod returns a polynomial over K, say P1, where
.IP
P1 = a * P.

M*/
                 
/*H
	Version 1       16.11.1989      A.Stein
   DATE pnfnfprod     : 900315
H*/


#include <_pol3.h>
 
pol pnfnfprod(r,F,P,a)
single r;
pol F,P;
nfel a;
{
	pol P1;
	bind(F,P,a);
	init(P1);

/* P oder a gleich 0 */

	if ( !P || !a ) P1 = 0;

/* Anzahl r der Variablen gleich 0 */

	else if ( !r ) P1 = nfprod(F,P,a);

/* allgemeiner Fall: r,P,a ungleich 0 */

	else {
		single e;
		pol k;
		init(k);

		P1 = _0;
		r--;
		do {
			e = lfirst(P);
			P = lred(P);
			k = lfirst(P);
			P = lred(P);
			k = (r) ? (pnfnfprod(r,F,k,a)) : (nfprod(F,k,a));
			P1 = lcomp2(k,e,P1);
			}
		while (P != _0);
		P1 = linv(P1);
		}

/* Ausgabe */

	return(P1);
}
