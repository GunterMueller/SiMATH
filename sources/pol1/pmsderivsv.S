/*M
.SH NAME
pmsderivsv - polynomial over modular singles derivation, specified variable, (recursive)

.SH SYNOPSIS
.nf
#include<_pol1.h>

pol pmsderivsv(r, m, P, n) 
single r, m, n; 
pol P;
 
.SH DESCRIPTION
.TP 4
.B r
is an integer number, 0 < r < BASIS.
.TP 4
.B m
is an integer number, 0 < m < BASIS.    
.TP 4
.B P
is a polynomial in r variables over Z/mZ.    
.TP 4                                                                           
.B n                                                                            
is an integer number, 0 < n <= r.                                               
.PP                                    
pmsderivsv returns the derivation of P with respect to the n-th variable of P.

.SH SEE ALSO
pmsderiv

M*/

/*H
	Version 1	31.05.1987      B. Weis
   DATE pmsderivsv    : 890501
H*/


#include <_pol1.h>

pol pmsderivsv(r,m,P,n)
single r;
single m;
pol P;
single n;
{
	single e;
	pol P1, k;
	bind(P);
	init2(P1,k);

/* P gleich 0 */

	if (P == 0) P1 = 0;

/* i gleich r */

	else if (n == r) P1 = pmsderiv(r,m,P);

/* allgemeiner Fall: n ungleich r und P ungleich 0 */

	else {
		r--;
		P1 = _0;
		do {
			e = lfirst(P);
			P = lred(P);
			k = lfirst(P);
			P = lred(P);
			k = pmsderivsv(r,m,k,n);
			if (k) P1 = lcomp2(k,e,P1);
			}
		while (P != _0);
		if (P1 == _0) P1 = 0;
		else P1 = linv(P1);
		}

/* Ausgabe */

	return(P1);
}
