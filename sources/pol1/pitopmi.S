/*M
.SH NAME
pitopmi - polynomial over integers to polynomial over modular integers
(recursive)

.SH SYNOPSIS
.nf
#include<_pol1.h>

pol pitopmi(r, P, M) 
single r; 
pol P; 
int M;

.SH DESCRIPTION
.TP 4
.B r
is an integer number, 0 <= r < BASIS.
.TP 4
.B P
is a polynomial in r variables over the integer numbers.
.TP 4
.B M
is a positive integer number.
.PP
pitopmi returns the polynomial P (as a polynomial over Z/MZ).

M*/

/*H
	Version 1       27.02.88        J.Schmitt
   DATE pitopmi       : 890501
H*/


#include <_pol1.h>

pol pitopmi(r,P,M)
single r;
pol P;
int M;
{
	single e;
	pol P1, k;
	bind(M,P);
	init(P1,k);

	if (P == 0) P1 = 0;
	else if (r == 0) P1 = mihom(M,P);
	else {
		r--;
		P1 = _0;
		do {
			e = lfirst(P);
			P = lred(P);
			k = lfirst(P);
			P = lred(P);
			if (r) k = pitopmi(r,k,M);
			else k = mihom(M,k);
			if (k) P1 = lcomp2(k,e,P1);
			}
		while (P != _0);
		if (P1 == _0) P1 = 0;
		else P1 = linv(P1);
		}
	return(P1);
}
