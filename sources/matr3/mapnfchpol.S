/*M
.SH NAME
mapnfchpol - matrix of polynomials over number field, characteristic polynomial (MACRO)

.SH SYNOPSIS
.nf
#include<_matr3.h>

pol mapnfchpol(r, F, M)
single r;
pol F;
matrix M;

.SH DESCRIPTION
mapnfchpol() returns the characteristic polynomial of M, i.e.
chp(X) = det( M - X * I ), where I is the unity matrix.
chp is a polynomial in r+1 variables over the number field generated by F.
.PP
.TP 4
.B F
is an irreducible monic dense polynomial in one variable over Z.
.TP 4
.B M
is a square matrix of polynomials in r variables over the number field generated by F.
M*/








/*H
	Version 1       30.05.1990      Th. Weis
	Version 2	18.11.94	Macro nur noch im Header definiert. MP
   DATE mapnfchpol    : 910915.941201
H*/
/*
	For the definition of mapnfchpol please refer to the header file _matr3.h.
*/


