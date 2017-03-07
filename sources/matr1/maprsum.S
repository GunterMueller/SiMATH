/*M
.SH NAME
maprsum - matrix of polynomials over the rational numbers, sum (MACRO)

.SH SYNOPSIS
.nf
#include<_matr1.h>

matrix maprsum(r, M, N)
single r;
matrix M, N;

.SH DESCRIPTION
maprsum() returns the matrix M+N.

.PP
.TP 4
.B M, N
are matrices of polynomials in r variables over the rational numbers.
M and N must have equal dimensions.
M*/
/*H
	Version 1       28.07.1988      Klaus Petry
	Version 2       10.11.1988      Klaus Petry
	Version 3	18.11.94	Macro nur noch im Header definiert. MP
   DATE maprsum       : 890501.941201
H*/
/*
	For the definition of maprsum please refer to the header file _matr1.h.
*/
