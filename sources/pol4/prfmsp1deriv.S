/*M
.SH NAME
prfmsp1deriv - polynomial over rational functions over modular single prime, transcendence degree 1, derivation, main variable

.SH SYNOPSIS
.nf
#include<_pol4.h>

pol prfmsp1deriv(r, p, P) 
single r, p; 
pol P;

.SH DESCRIPTION
.TP 4
.B r
is an integer number, 0 < r < BASIS. 
.TP 4
.B p
is a prime number, 1 < p < BASIS.
.TP 4
.B P
is a polynomial in r variables over the rational func-tion field over Z/(pZ).
.PP
prfmsp1deriv returns the derivation of P with regard to the main variable.  

M*/
                      
/*H
	Version 1         24.11.89           J.Schmitt
   DATE prfmsp1deriv    : 900301
H*/

#include <_pol4.h>

pol prfmsp1deriv(r,p,P)
single r,p;
pol P;
{
	single e, e1;
	pol P1, k, e2;
	bind(P);
	init(P1,k,e2);

	if (P == 0) P1 = 0;
	else {
		r--;
		P1 = _0;
		do {
			e = lfirst(P);
			P = lred(P);
			k = lfirst(P);
			P = lred(P);          
			e1 = mshom(p,e);
			if ( e1 ) {
				e2 = list2(0,e1);
                                e2 = list2(e2,list2(0,1));
				if (r) k = prfmsp1rfprd(r,p,k,e2);
				else k = rfmsp1prod(p,k,e2);
				P1 = lcomp2(k,e-1,P1);
			}
		}
		while (P != _0);
		if (P1 == _0) P1 = 0;
		else P1 = linv(P1);
	}

	return(P1);
}
