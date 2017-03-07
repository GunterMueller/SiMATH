/*M
.SH NAME
mapiprod - matrix of polynomials over integers, product (MACRO)

.SH SYNOPSIS
.nf
#include<_matr1.h>

matrix mapiprod(r, M, N)
single r;
matrix M, N;

.SH DESCRIPTION
mapiprod() returns the matrix M*N.

.PP
.TP 4
.B M,N
are matrices of polynomials in r variables over integers.
M and N must have compatible dimensions.
M*/
/*H
	Version 1       08.06.1988      Klaus Petry
	Version 2       14.11.1988      Klaus Petry
	Version 3	18.11.94	Macro nur noch im Header definiert. MP
   DATE mapiprod      : 890501.941201
H*/
/*
	For the definition of mapiprod please refer to the header file _matr1.h.
*/
