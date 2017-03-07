/*M
.SH NAME
pnfnfquot - polynomial over number field, number field element quotient
(recursive)

.SH SYNOPSIS
.nf
#include<_pol3.h>

pol pnfnfquot(r, F, P, a) 
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
is an element in K, a != 0.
.PP   i
pnfnfquot returns a polynomial over K, say P1, where
.IP
P1 = P/a.
                                                                            
M*/

/*H
	Version 1       16.11.1989      A.Stein
   DATE pnfnfquot     : 900315
H*/


#include <_pol3.h>
 
pol pnfnfquot(r,F,P,a)
single r;
pol F,P;
nfel a;
{
	pol P1;
	bind(F,P,a);
	init(P1);

/* P gleich 0 */

	if ( !P ) P1 = 0;

/* Anzahl r der Variablen gleich 0 */

	else if ( !r ) P1 = nfquot(F,P,a);

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
			k = (r) ? (pnfnfquot(r,F,k,a)) : (nfquot(F,k,a));
			P1 = lcomp2(k,e,P1);
			}
		while (P != _0);
		P1 = linv(P1);
		}

/* Ausgabe */

	return(P1);
}
