/*M
.SH NAME
miquot - modular integer quotient 

.SH SYNOPSIS
.nf
#include<_arith1.h>

int miquot(M,A,B)
int M,A,B;

.SH DESCRIPTION
miquot() returns A / B for M > 0, A from Z/MZ and B from (Z/MZ)*.
M*/
/*H
	Version 1       9.2.1987                Pascale Serf
	Version 2	18.11.94	Macro nur noch im Header definiert. MP
   DATE miquot        : 890501.941201
H*/

#include <_arith1.h>
int miquot(M, A, B) 
	int M, A, B; 
	{ 
	bind(M, A, B); 
	return( miprod(M,A,miinv(M,B)) ); 
	} 
