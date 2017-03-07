/*M
.SH NAME
misumf - modular integer sum as function

.SH SYNOPSIS
.nf
#include<_arith1.h>

int misumf(M,A,B)
int M,A,B;

.SH DESCRIPTION
misumf() returns A + B for M > 0 and A,B from  Z/MZ.
misumf() has the same result as the macro misum.
M*/
/*H
	Version 1       31.01.1992      Bernd Mayr
   DATE misumf        : 920331
H*/

#include <_arith1.h>

int misumf (M,A,B)
int M, A, B;

{
	return((icomp((NUM = isum(A,B)),M) < 0) ? NUM : isum(NUM,ineg(M)));
}
