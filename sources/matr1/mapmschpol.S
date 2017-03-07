/*M
.SH NAME
mapmschpol - matrix of polynomials over modular singles, characteristic polynomial (MACRO)

.SH SYNOPSIS
.nf
#include<_matr1.h>

pol mapmschpol(r, m, M)
single r, m;
matrix M;

.SH DESCRIPTION
mapmschpol() returns the characteristic polynomial of the matrix M.
It is a polynomial in  r+1 variables X1,..,Xr,X.

.PP
.TP 4
.B M
is a square matrix of polynomials in r variables over Z/mZ.
M*/

/*H
	Version 1       01.08.1988      Klaus Petry
	Version 2       14.11.1988      Klaus Petry
	Version 3	18.11.94	Macro nur noch im Header definiert. MP
   DATE mapmschpol    : 890501.9011__.9203__.941201
H*/
/*
	For the definition of mapmschpol please refer to the header file _matr1.h.
*/
