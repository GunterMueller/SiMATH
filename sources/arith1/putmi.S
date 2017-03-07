/*M
.SH NAME
putmi - put modular integer (MACRO)

.SH SYNOPSIS
.nf
#include<_arith1.h>

single putmi(M,A)
int M,A;

.SH DESCRIPTION
putmi() writes the modular integer A from Z/MZ for M > 0
to stdout and returns 0.
In case of a failure, the return code is ERROR.returns 
M*/
 
/*H
	Version 1       8.4.1987                Pascale Serf
	Version 2	18.11.94	Macro nur noch im Header definiert. MP
   DATE putmi         : 890501.941201
H*/
/*
	For the definition of putmi please refer to the header file _arith1.h.
*/
