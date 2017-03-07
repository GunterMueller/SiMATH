/*M
.SH NAME
maihermltne - matrix over integers, Hermite normal form  (lower triangular form with negative entries) (MACRO)

.SH SYNOPSIS
.nf
#include<_matr2.h>

matrix maihermltne(A)
matrix A;

.SH DESCRIPTION
maihermltne() is identical to maihermltpe() except
for the third constraint on H
.PP
.nf
(3)   hij  > 0 for i,j = 1..n, i>j,
.fi


.SH SEE ALSO
maihermltpe
M*/
/*H
	Version 1       13.12.1988      Klaus Petry
	Version 2	18.11.94	Macro nur noch im Header definiert. MP
   DATE maihermltne   : 890501.9107__.941201
H*/
/*
	For the definition of maihermltne please refer to the header file _matr2.h.
*/
