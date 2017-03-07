/*M
.SH NAME
mapmiprod - matrix of polynomials over modular integers, product (MACRO)

.SH SYNOPSIS
.nf
#include<_matr1.h>

matrix mapmiprod(r, m, M, N)
single r;
int m;
matrix M, N;

.SH DESCRIPTION
mapmiprod() returns the matrix M*N.

.PP
.TP 4
.B M,N
are matrices of polynomials in r variables over Z/mZ.
M and N must have compatible dimensions.
M*/


L = M * N.
/*H
	Version 1       31.01.1992      Bernd Mayr
	Version 2	18.11.94	Macro nur noch im Header definiert. MP
   DATE mapmiprod     : 920331.941201
H*/
/*
	For the definition of mapmiprod please refer to the header file _matr1.h.
*/
