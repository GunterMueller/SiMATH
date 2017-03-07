/*M
.SH NAME
pitopnf - polynomial over the integers to polynomial over a number field
(recursive)

.SH SYNOPSIS
.nf
#include<_pol3.h>

pol pitopnf(r, P) 
single r; 
pol P;

.SH DESCRIPTION
.TP 4
.B r
is an integer number, 0 <= r < BASIS.      
.TP 4
.B P
is a polynomial in r variables over Z.
.PP
pitopnf returns the representation of P as a polynomial over a number field.

M*/
           
/*H
	Version 1       15.05.89        J.Schmitt
   DATE pitopnf       : 891101
H*/


#include <_pol3.h>

pol pitopnf(r,P)
single r;
pol P;
{
	single e;
	pol P1, k;
	bind(P);
	init(P1,k);

	if (P == 0) return(0);
	if (r == 0) {
		P1 = itonf(P);
		return(P1);
	}
	r--;
	P1 = _0;
	do {
		e = lfirst(P);
		P = lred(P);
		k = lfirst(P);
		P = lred(P);
		if (r) k = pitopnf(r,k);
		else k = itonf(k);
		P1 = lcomp2(k,e,P1);
	}
	while (P != _0);
	P1 = linv(P1);
	return(P1);
}
