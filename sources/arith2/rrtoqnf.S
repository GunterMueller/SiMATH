/*M
.SH NAME
rrtoqnf -  two rational numbers to quadratic number field element 

.SH SYNOPSIS
.nf
#include<_arith2.h>

nfel rrtoqnf(d,a1,a2)
int d;
rat a1,a2;

.SH DESCRIPTION
rrtoqnf() returns the number field element A=a1+sqrt(d)*a2.
M*/
/*H
        Version  1      19.08.1998      S.Schmitt
   DATE rsqrt         : 980819
H*/


# include <_arith2.h>


nfel rrtoqnf(d,a1,a2)
int d;
rat a1,a2;
{
	nfel A, D;
	
	init(A,D);
	bind(d,a1,a2);

	D = list4(1,1,1,0);
	A = rtonf(a2);
	A = qnfprod(d,A,D);
	D = rtonf(a1);
	A = qnfsum(d,A,D);
	
	return(A);
}

	
