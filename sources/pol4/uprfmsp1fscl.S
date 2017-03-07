/*M
.SH NAME
uprfmsp1fscl - univariate polynomial over rational functions over modular single prime, transcendence degree 1, from special coefficient list

.SH SYNOPSIS
.nf
#include<_pol4.h>

pol uprfmsp1fscl(L) 
list L; 
 
.SH DESCRIPTION
Let P = a_n * y^n + ... + a_0 * y^0 be a polynomial in y over Z/(pZ)(x). 
The list (a_0, ..., a_n) is called a "special coefficient list" and represents the polynomial P.
.TP 4
.B L 
is such a special coefficient list, representing an univariate polynomial over Z/(pZ)(x), say P.
.PP
uprfmsp1fscl returns the polynomial P in sparse representation. 

.SH SEE ALSO
sclfuprfmsp1

M*/
               
/*H
	Version 1       15.10.89        J.Schmitt
   DATE uprfmsp1fscl  : 901120
H*/

#include<_pol4.h>

pol uprfmsp1fscl(L)
list L;
{
	pol P,k;
	single e;
	init(P,k);
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
