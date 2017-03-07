/*M
.SH NAME
mamidif - matrix of modular integers, difference (MACRO)

.SH SYNOPSIS
.nf
#include<_matr1.h>

matrix mamidif(m, M, N)
int m;
matrix M, N;

.SH DESCRIPTION
mamidif() returns the matrix M-N.

.PP
.TP 4
.B M, N
are matrices over Z/mZ.
M and N must have equal dimensions.
M*/


/*H
	Version  1      31.01.1992     Bernd Mayr 
	Version 2	18.11.94	Macro nur noch im Header definiert. MP
   DATE mamidif       : 920331.941201
H*/
/*
	For the definition of mamidif please refer to the header file _matr1.h.
*/
