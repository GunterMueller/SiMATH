/*M
.SH NAME
miprodf - modular integer product as function

.SH SYNOPSIS
.nf
#include<_arith1.h>

int miprodf(M,A,B)
int M,A,B;

.SH DESCRIPTION
miprodf() returns A * B for M > 0 and A,B from Z/MZ.
miprof() gives the same result as the macro miprod.
M*/
/*H
	Version 1	25.03.1992	Pascale Serf
   DATE miprodf       : 920331
H*/



# include <_arith1.h>

int miprodf(M,A,B)
int M, A, B;
{
	return( irem(iprod(A,B),M) );
}
