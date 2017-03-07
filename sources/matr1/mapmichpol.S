/*M
.SH NAME
mapmichpol - matrix of polynomials over modular integers, characteristic polynomial (MACRO)

.SH SYNOPSIS
.nf
#include<_matr1.h>

pol mapmichpol(r, m, M)
single r;
int m;
matrix M;

.SH DESCRIPTION
mapmichpol() returns the characteristic polynomial of the matrix M.
It is a polynomial in  r+1 variables X1,..,Xr,X.

.PP
.TP 4
.B M
is a square matrix of polynomials in r variables over Z/mZ.
M*/

/*H
	Version 1       31.01.1992      Bernd Mayr
	Version 2	18.11.94	Macro nur noch im Header definiert. MP
   DATE mapmichpol    : 920331.941201
H*/
/*
	For the definition of mapmichpol please refer to the header file _matr1.h.
*/
