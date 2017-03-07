/*M
.SH NAME
mitos - modular integer to symmetric remainder system

.SH SYNOPSIS
.nf
#include<_arith1.h>

int mitos(M,A)
int M,A;

.SH DESCRIPTION
mitos() returns the value A from the positive remainder system
{0 ... M-1} converted to the congruent value from the
symmetric remainder system modulo M for M > 0.
M*/
/*H
	Version 1        7.04.88        R.Boeffgen
   DATE mitos         : 890501
H*/


# include <_arith1.h>

int mitos( M, A )
int M, A;
{
	int B;
	bind( A );
	init( B );
 
	B = idif( A,M );
	return(  icomp(A,ineg(B)) >0 ? B : A  );
}
