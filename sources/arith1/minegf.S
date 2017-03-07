/*M
.SH NAME
minegf - modular integer negation as function

.SH SYNOPSIS
.nf
#include<_arith1.h>

int minegf(M,A)
int M,A;

.SH DESCRIPTION
minegf() returns -A for M > 0 and A from Z/MZ.
minegf() gives the same result as the macro mineg.
M*/
/*H
	Version 1       31.01.1992      Bernd Mayr
   DATE minegf        : 920331
H*/

#include <_arith1.h>

int minegf ( M, A )
int  M, A;

{
	return ( A == 0 ? 0 : idif (M,A) );
}
