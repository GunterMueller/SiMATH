/*M
.SH NAME
pnfeval - polynomial over number field evaluation, main variable

.SH SYNOPSIS
.nf
#include<_pol3.h>

pol pnfeval(r, F, P, a) 
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
pnfeval returns the evaluation of P at a with regard to the main variable.

.SH SEE ALSO
pnfevalsv

M*/
                          
/*H
	Version 1       17.11.1989      A.Stein
	Version 2       29.10.1990      C.H.    pnfsum( r, F, ... )
   DATE pnfeval       : 900315.901120
H*/


#include <_pol3.h>

pol pnfeval(r,F,P,a)
single r;
pol F,P;
nfel a;
{
	pol P1;
	init(P1);

/* P gleich 0 */

	if (!P) P1 = 0;

/* P ungleich 0 */

	else {
		single e, e1;
		pol k;
		bind(F,P,a);
		init(k);

		r--;
		e = lfirst(P);
		P = lred(P);
		P1 = lfirst(P);
		P = lred(P);
		while (P != _0) {
			e1 = lfirst(P);
			P = lred(P);
			k = lfirst(P);
			P = lred(P);
			for (e = e-e1; e; e--) {
				P1 = (r) ? (pnfnfprod(r,F,P1,a))
					 : (nfprod(F,P1,a));
			}
			P1 = (r) ? (pnfsum(r,F,P1,k))
				 : (nfsum(F,P1,k));
			e = e1;
		}
		for (; e; e--) {
			P1 = (r) ? (pnfnfprod(r,F,P1,a))
				 : (nfprod(F,P1,a));
		}
	}

/* Ausgabe */

	return(P1);
}
