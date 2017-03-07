/*M
.SH NAME
mapisum - matrix of polynomials over integers, sum (MACRO)

.SH SYNOPSIS
.nf
#include<_matr1.h>

matrix mapisum(r, M, N)
single r;
matrix M, N;

.SH DESCRIPTION
mapisum() returns the matrix M+N.

.PP
.TP 4
.B M, N
are matrices of polynomials in r variables over integers.
M and N must have equal dimensions.
M*/
/*H
	Version 1       07.06.1988      Klaus Petry
	Version 1       10.11.1988      Klaus Petry
	Version 2	18.11.94	Macro nur noch im Header definiert. MP
   DATE mapisum       : 890501.941201
H*/
/*
	For the definition of mapisum please refer to the header file _matr1.h.
*/
