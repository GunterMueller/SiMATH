/*M
.SH NAME
mapmsdif - matrix of polynomials over modular singles, difference (MACRO)

.SH SYNOPSIS
.nf
#include<_matr1.h>

matrix mapmsdif(r, m, M, N)
single r, m;
matrix M, N;

.SH DESCRIPTION
mapmsdif() returns the matrix M-N.

.PP
.TP 4
.B M, N
are matrices of polynomials in r variables over Z/mZ.
M and N must have equal dimensions.
M*/


/*H
	Version  1      10.02.1989      KLaus Petry
	Version 2	18.11.94	Macro nur noch im Header definiert. MP
   DATE mapmsdif      : 890501.890601.9203__.941201
H*/
/*
	For the definition of mapmsdif please refer to the header file _matr1.h.
*/
