/*M
.SH NAME
misum - modular integer sum 

.SH SYNOPSIS
.nf
#include<_arith1.h>

int misum(M,A,B)
int M,A,B;

.SH DESCRIPTION
misum() returns A + B for M > 0 and A,B from Z/MZ.
M*/
/*H
	Version 1       09.02.1987              Pascale Serf      
	Version 2	19.10.1990		neu geschrieben
						     Marc Conrad
	Version 3	18.11.94	Macro nur noch im Header definiert. MP
   DATE misum         : 890501.901120.941201
H*/
#include <_arith1.h>
int misum(M,A,B) 
	int M, A, B; 
	{ 
	bind(M,A,B); 
	A = isum(A,B); 
	if(icomp(A, M) < 0 ){  return A; } 
	return( idif(A, M) ); 
	} 
                      

