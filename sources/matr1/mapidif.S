/*M
.SH NAME
mapidif - matrix of polynomials over integers, difference (MACRO)

.SH SYNOPSIS
.nf
#include<_matr1.h>

matrix mapidif(r, M, N)
single r;
matrix M, N;

.SH DESCRIPTION
mapidif() returns the matrix M-N.

.PP
.TP 4
.B M, N
are matrices of polynomials in r variables over integers.
M and N must have equal dimensions.
M*/

/*H
	Version  1      07.06.1988      KLaus Petry
	Version 2	18.11.94	Macro nur noch im Header definiert. MP
   DATE mapidif       : 890501.941201
H*/
/*
	For the definition of mapidif please refer to the header file _matr1.h.
*/
