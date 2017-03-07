/*M
.SH NAME
upifscl - univariate polynomial over the integers from special coefficient list

.SH SYNOPSIS
.nf
#include<_pol2.h>

pol upifscl(L) 
list L;

.SH DESCRIPTION
Let a_n * x^n + ... + a_0 * x^0 be a polynomial over the integer numbers.
Then the list (a_0, ..., a_n) is called 'special coefficient list' and describes a polynomial.
.TP 4
.B L
is a 'special coefficient' list as described above.
.PP
upifscl converts the list L into a sparse univariate polynomial over the integer numbers and returns the polynomial.

M*/

/*H
	Version 1       15.05.89        J.Schmitt
   DATE upifscl       : 891101
H*/

#include<_pol2.h>

pol upifscl(L)
list L;
{
	pol P;
	int k;
	single e;
	init(k,P);
	bind(L);

	P = _0;
	e = 0;
	while (L != _0) {
		k = lfirst(L);
		L = lred(L);
		if (k != 0) P = lcomp2(e,k,P);
		e = e+1;
	}
	if (P == _0) return(0);
	else return(P);
}
