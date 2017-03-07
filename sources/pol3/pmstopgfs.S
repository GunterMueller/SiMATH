/*M
.SH NAME
pmstopgfs - polynomial over modular singles to polynomial over Galois-field with single characteristic 
(recursive)

.SH SYNOPSIS
.nf
#include<_pol3.h>

pol pmstopgfs(r, p, P) 
single r, p; 
pol P;
        
.SH DESCRIPTION
.TP 4
.B r
is an integer number, 0 <= r < BASIS.
.TP 4
.B p
is a prime number, p < BASIS.
.TP 4
.B P
is a polynomial in r variables over Z/pZ.
.PP
pmstopgfs returns the representation of P as a polynomial over GF(p^n), i.e. the basis coefficients will be embeded from Z/pz into GF(p^n) (for an arbitrary integer n, 0 < n < BASIS).  

M*/
              
/*H
	Version 1         29.03.88           J.Schmitt
   DATE pmstopgfs     : 890501
H*/


#include <_pol3.h>

pol pmstopgfs(r,p,P)
single r,p;
pol P;
{
	single e;
	pol P1, k;
	bind(P);
	init(P1,k);

/* P gleich 0 */

	if (P == 0) P1 = 0;

/* r gleich 0 */

	else if (r == 0) P1 = list2(0,P);

/* allgemeiner Fall: P,r ungleich 0*/

	else {
		r--;
		P1 = _0;
		do {
			e = lfirst(P);
			P = lred(P);
			k = lfirst(P);
			P = lred(P);
			if (r) k = pmstopgfs(r,p,k);
			else k = list2(0,k);
			P1 = lcomp2(k,e,P1);
			}
		while (P != _0);
		P1 = linv(P1);
		}

/* Ausgabe */

	return(P1);
}
