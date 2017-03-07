/*M
.SH NAME
mamssum - matrix of modular singles, sum (MACRO)

.SH SYNOPSIS
.nf
#include<_matr1.h>

matrix mamssum(m, M, N)
single m;
matrix M, N;

.SH DESCRIPTION
mamssum() returns the matrix M+N.

.PP
.TP 4
.B M, N
are matrices over Z/mZ.
M and N must have equal dimensions.
M*/
/*H
	Version 1       27.06.1988      Klaus Petry
	Version 2       10.11.1988      Klaus Petry
	Version 3	18.11.94	Macro nur noch im Header definiert. MP
   DATE mamssum       : 890501.9203__.941201
H*/
/*
	For the definition of mamssum please refer to the header file _matr1.h.
*/
