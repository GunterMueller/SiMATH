/*M
.SH NAME
maprchpol - matrix of polynomials over the rational numbers, characteristic polynomial (MACRO)

.SH SYNOPSIS
.nf
#include<_matr1.h>

pol maprchpol(r, M)
single r;
matrix M;

.SH DESCRIPTION
maprchpol() returns the characteristic polynomial of the matrix M.
It is a polynomial in  r+1 variables X1,..,Xr,X.

.PP
.TP 4
.B M
is a square matrix of polynomials over the rational numbers.
M*/


/*H
	Version 1       01.08.1988      Klaus Petry
	Version 2       14.11.1988      Klaus Petry
	Version 3	18.11.94	Macro nur noch im Header definiert. MP
   DATE maprchpol     : 890501.9011__.941201
H*/
/*
	For the definition of maprchpol please refer to the header file _matr1.h.
*/
