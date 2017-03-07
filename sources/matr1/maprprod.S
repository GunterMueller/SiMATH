/*M
.SH NAME
maprprod - matrix of polynomials over the rational numbers, product (MACRO)

.SH SYNOPSIS
.nf
#include<_matr1.h>

matrix maprprod(r, M, N)
single r;
matrix M, N;

.SH DESCRIPTION
maprprod() returns the matrix M*N.

.PP
.TP 4
.B M,N
are matrices of polynomials in r variables over the rational numbers
M and N must have compatible dimensions.
M*/
/*H
	Version 1       28.07.1988      Klaus Petry
	Version 2       14.11.1988      Klaus Petry
	Version 3	18.11.94	Macro nur noch im Header definiert. MP
   DATE maprprod      : 890501.941201
H*/
/*
	For the definition of maprprod please refer to the header file _matr1.h.
*/
