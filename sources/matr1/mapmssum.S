/*M
.SH NAME
mapmssum - matrix of polynomials over modular singles, sum (MACRO)

.SH SYNOPSIS
.nf
#include<_matr1.h>

matrix mapmssum(r, m, M, N)
single r, m;
matrix M, N;

.SH DESCRIPTION
mapmssum() returns the matrix M+N.

.PP
.TP 4
.B M, N
are matrices of polynomials in r variables over Z/mZ.
M and N must have equal dimensions.
M*/
/*H
	Version 1       10.11.1988      Klaus Petry
	Version 2	18.11.94	Macro nur noch im Header definiert. MP
   DATE mapmssum      : 890501.9203__.941201
H*/
/*
	For the definition of mapmssum please refer to the header file _matr1.h.
*/
