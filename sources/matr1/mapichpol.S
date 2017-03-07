/*M
.SH NAME
mapichpol - matrix of polynomials over integers, characteristic polynomial (MACRO)

.SH SYNOPSIS
.nf
#include<_matr1.h>

pol maichpol(r, M)
single r;
matrix M;

.SH DESCRIPTION
mapichpol() returns the characteristic polynomial of the matrix M.
It is a polynomial in  r+1 variables X1,..,Xr,X.

.PP
.TP 4
.B M
is a square matrix of polynomials over integers.
M*/


/*H
	Version 1       16.06.1988      Klaus Petry
	Version 2       14.11.1988      Klaus Petry     Macro
	Version 3	18.11.94	Macro nur noch im Header definiert. MP
   DATE mapichpol     : 890501.941201
H*/
/*
	For the definition of mapichpol please refer to the header file _matr1.h.
*/
