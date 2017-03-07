/*M
.SH NAME
prfmsp1neg - polynomial over rational functions over modular single prime, transcendence degree 1, negation 
(recursive)

.SH SYNOPSIS
.nf
#include<_pol4.h>

pol prfmsp1neg(r, p, P) 
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
prfmsp1neg returns a polynomial, say P1, where
.IP
P1 = -P.
 
M*/
                 
/*H
	Version 1	21.11.89		J.Schmitt
   DATE prfmsp1neg    : 900301
H*/

#include <_pol4.h>

pol prfmsp1neg(r,p,P)
single r;
single p;
pol P;
{
	single e;
	pol P1, k;
	bind(P);
	init(P1,k);

	if (P == 0) P1 = 0;
	else if (r == 0) P1 = rfmsp1neg(p,P);
	else {
		r--;
		P1 = _0;
		do {
			e = lfirst(P);
			P = lred(P);
			k = lfirst(P);
			P = lred(P);
			if (r) k = prfmsp1neg(r,p,k);
			else k = rfmsp1neg(p,k);
			P1 = lcomp2(k,e,P1);
		}
		while (P != _0);
		P1 = linv(P1);
	}
	return(P1);
}
