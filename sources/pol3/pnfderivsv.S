/*M
.SH NAME
pnfderivsv - polynomial over number field derivation, specified variable
(recursive)

.SH SYNOPSIS
.nf
#include<_pol3.h>

pol pnfderivsv(r, F, P, n)  
single r; 
pol F, P; 
single n;
       
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
.B n
is an integer number, 0 < n <= r. 
.PP                              
pnfderivsv returns the derivation of P with regard to the n-th variable.
                          
.SH SEE ALSO
pnfderiv

M*/
                          
/*H
	Version 1       23.11.1989      A.Stein
   DATE pnfderivsv    : 900315.9107__
H*/


#include <_pol3.h>

pol pnfderivsv(r,F,P,n)
single r;
pol F,P;
single n;
{
	pol P1;
	bind(F,P);
	init(P1);

/* P gleich 0 */

	if ( !P ) P1 = 0;

/* n gleich r */

	else if (n == r) P1 = pnfderiv(r,F,P);

/* allgemeiner Fall: n ungleich r und P ungleich 0 */

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
			k = pnfderivsv(r,F,k,n);
			if (k) P1 = lcomp2(k,e,P1);
		}
		while (P != _0);
		P1 = (P1 == _0) ? (0) : (linv(P1));
	}

/* Ausgabe */

	return(P1);

}
