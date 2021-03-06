/*M
.SH NAME
mapmidif - matrix of polynomials over modular integers, difference (MACRO)

.SH SYNOPSIS
.nf
#include<_matr1.h>

matrix mapmidif(r, m, M, N)
single r;
int m;
matrix M, N;

.SH DESCRIPTION
mapmidif() returns the matrix M-N.

.PP
.TP 4
.B M, N
are matrices of polynomials in r variables over Z/mZ.
M and N must have equal dimensions.
M*/


/*H
	Version  1      31.01.1992      Bernd Mayr
	Version 2	18.11.94	Macro nur noch im Header definiert. MP
   DATE mapmidif      : 920331.941201
H*/
/*
	For the definition of mapmidif please refer to the header file _matr1.h.
*/
