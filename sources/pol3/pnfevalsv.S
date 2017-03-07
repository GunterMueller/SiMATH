/*M
.SH NAME
pnfevalsv - polynomial over number field evaluation, specified variable
(recursive)

.SH SYNOPSIS
.nf
#include<_pol3.h>

pol pnfevalsv(r, F, P, n, a) 
single r; 
pol F, P; 
single n; 
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
.B n
is an integer number, 0 < n <= r.
.TP 4
.B a
is an element in K.
.PP
pnfevalsv returns the evaluation of P at a with regard to the n-th variable.

.SH SEE ALSO
pnfeval        
M*/
          
/*H
	Version 1       17.11.1989      A.Stein
   DATE pnfevalsv     : 900315
H*/


#include <_pol3.h>

pol pnfevalsv(r,F,P,n,a)
single r;
pol F,P;
single n;
nfel a;
{
	pol P1;
	bind(P,F,a);
	init(P1);

/* P gleich 0 */

	if (!P) P1 = 0;

/* n gleich r */

	else if (n == r) P1 = pnfeval(r,F,P,a);

/* allgemeiner Fall: P ungleich 0, n ungleich r */

	else {
		single e;
		pol  k;
		init(k);

		r--;
		P1 = _0;
		do {
			e = lfirst(P);
			P = lred(P);
			k = lfirst(P);
			P = lred(P);
			k = pnfevalsv(r,F,k,n,a);
			if (k) P1 = lcomp2(k,e,P1);
		}
		while (P != _0);
		P1 = (P1 == _0) ? (0) : (linv(P1));
	}

/* Ausgabe */

	return(P1);
}
