/*M
.SH NAME
prfmsp1rfprd - polynomial over rational functions over modular single prime, transcendence degree 1, rational function overmodular single prime, transcendence degree 1, product
(recursive)

.SH SYNOPSIS
.nf
#include<_pol4.h>

pol prfmsp1rfprd(r, p, P, a) 
single r, p; 
pol P; 
rfunc a;

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
.TP 4
.B a
is an element in the fuction field above.
.PP
prfmsp1rfprd returns a polynomial, say P1, where
.IP   
P1 = a * P.

M*/
        
/*H
	Version 1	21.11.89		J.Schmitt
   DATE prfmsp1rfprd  : 900301
H*/

#include <_pol4.h>
 
pol prfmsp1rfprd(r,p,P,a)
single r,p;
pol P;
rfunc a;
{
	single e;
	pol P1, k;
	bind(P,a);
	init(P1,k);

	if (P == 0  ||  a == 0) P1 = 0;
	else if (r == 0) P1 = rfmsp1prod(p,P,a);
	else {
		P1 = _0;
		r--;
		do {
			e = lfirst(P);
			P = lred(P);
			k = lfirst(P);
			P = lred(P);
			if (r) k = prfmsp1rfprd(r,p,k,a);
			else k = rfmsp1prod(p,k,a);
			if (k) P1 = lcomp2(k,e,P1);
		}
		while (P != _0);
		if (P1 == _0) P1 = 0;
		else P1 = linv(P1);
	}
	return(P1);
}
