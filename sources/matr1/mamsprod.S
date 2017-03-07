/*M
.SH NAME
mamsprod - matrix of modular singles, product (MACRO)

.SH SYNOPSIS
.nf
#include<_matr1.h>

matrix mamsprod(m, M, N)
single m;
matrix M, N;

.SH DESCRIPTION
mamsprod() returns the matrix M*N.

.PP
.TP 4
.B M,N
are matrices over Z/mZ.
M and N must have compatible dimensions.
M*/
/*H
	Version 1       27.05.1988      Klaus Petry
	Version 2       14.11.1988      Klaus Petry
	Version 3	18.11.94	Macro nur noch im Header definiert. MP
   DATE mamsprod      : 890501.9203__.941201
H*/
/*
	For the definition of mamsprod please refer to the header file _matr1.h.
*/
