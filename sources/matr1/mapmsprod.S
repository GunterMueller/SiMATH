/*M
.SH NAME
mapmsprod - matrix of polynomials over modular singles, product (MACRO)

.SH SYNOPSIS
.nf
#include<_matr1.h>

matrix mapmsprod(r, m, M, N)
single r, m;
matrix M, N;

.SH DESCRIPTION
mapmsprod() returns the matrix M*N.

.PP
.TP 4
.B M,N
are matrices of polynomials in r variables over Z/mZ.
M and N must have compatible dimensions.
M*/
/*H
	Version 1       28.07.1988      Klaus Petry
	Version 2       14.11.1988      Klaus Petry
	Version 3	18.11.94	Macro nur noch im Header definiert. MP
   DATE mapmsprod     : 890501.9203__.941201
H*/
/*
	For the definition of mapmsprod please refer to the header file _matr1.h.
*/
