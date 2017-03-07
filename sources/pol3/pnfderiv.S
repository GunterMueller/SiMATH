/*M
.SH NAME
pnfderiv - polynomial over number field derivation, main variable

.SH SYNOPSIS
.nf
#include<_pol3.h>

pol pnfderiv(r, F, P)  
single r;  
pol F, P;

.SH DESCRIPTION
.TP 4
.B r
is an integer number, 0 < r < BASIS.
.TP 4
.B F
is an irreducible, univariate polynomial in dense representation over Z. F generates a number field, say K.
.TP 4
.B P
is a polynomial in r variables over K.
.PP               
pnfderiv returns the derivation of P with regard to the main variable.
 
.SH SEE ALSO
pnfderivsv

M*/
              
/*H
	Version 1       23.11.1989      A.Stein
	Version 2       18.11.1991      Ableitung von Konstanten ist 0. AS
   DATE pnfderiv      : 900315.9107__.920331
H*/


#include <_pol3.h>

pol pnfderiv(r,F,P)
single r;
pol F,P;
{
	pol P1;
	init(P1);

/* P gleich 0 */

	if ( !P ) P1 = 0;

/* allgemeiner Fall: P ungleich 0 */

	else {
		single e;
		nfel e1;
		pol k;
		bind(F,P);
		init(k,e1);

		r--;
		P1 = _0;
		do {
			e = lfirst(P);
			P = lred(P);
			k = lfirst(P);
			P = lred(P);
			e1 = itonf(e);
			k = (r) ? (pnfnfprod(r,F,k,e1)) : (nfprod(F,k,e1));
			if (k) P1 = lcomp2(k,e-1,P1);
		}
		while (P != _0);
		P1 = (P1 == _0) ? (0) : (linv(P1));
	}

/* Ausgabe */

	return(P1);
}
