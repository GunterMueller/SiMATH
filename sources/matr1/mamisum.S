/*M
.SH NAME
mamisum - matrix of modular integers, sum (MACRO)

.SH SYNOPSIS
.nf
#include<_matr1.h>

matrix mamisum(m, M, N)
int m;
matrix M, N;

.SH DESCRIPTION
mamisum() returns the matrix M+N.

.PP
.TP 4
.B M, N
are matrices over Z/mZ.
M and N must have equal dimensions.
M*/
/*H
	Version 1       31.01.1992      Bernd Mayr
	Version 2	18.11.94	Macro nur noch im Header definiert. MP
   DATE mamisum       : 920331.941201
H*/
/*
	For the definition of mamisum please refer to the header file _matr1.h.
*/
