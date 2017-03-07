/*M
.SH NAME
mamiprod - matrix of modular integers, product (MACRO)

.SH SYNOPSIS
.nf
#include<_matr1.h>

matrix mamiprod(m, M, N)
int m;
matrix M, N;

.SH DESCRIPTION
mamiprod() returns the matrix M*N.

.PP
.TP 4
.B M,N
are matrices over Z/mZ.
M and N must have compatible dimensions.
M*/

/*H
	Version 1       31.01.1992      Bernd Mayr
	Version 2	18.11.94	Macro nur noch im Header definiert. MP
   DATE mamiprod      : 920331.941201
H*/
/*
	For the definition of mamiprod please refer to the header file _matr1.h.
*/
