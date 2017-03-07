/*M
.SH NAME
mamsdif - matrix of modular singles, difference (MACRO)

.SH SYNOPSIS
.nf
#include<_matr1.h>

matrix mamsdif(m, M, N)
single m;
matrix M, N;

.SH DESCRIPTION
mamsdif() returns the matrix M-N.

.PP
.TP 4
.B M, N
are matrices over Z/mZ.
M and N must have equal dimensions.
M*/


/*H
	Version  1      27.06.1988      KLaus Petry
	Version 2	18.11.94	Macro nur noch im Header definiert. MP
   DATE mamsdif       : 890501.9203__.941201
H*/
/*
	For the definition of mamsdif please refer to the header file _matr1.h.
*/
