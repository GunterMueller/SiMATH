/*M
.SH NAME
mapgfschpol - matrix of polynomials over Galois-field with single characteristic, characteristic polynomial (MACRO)

.SH SYNOPSIS
.nf
#include<_matr3.h>

pol mapgfschpol(r, p, AL, M)
single r,p;
list AL;
matrix M;

.SH DESCRIPTION
mapgfschpol() returns the characteristic polynomial of M, i.e.
chp(X) = det( M - X * I ), where I is the unity matrix.
chp is a polynomial in r+1 variables over GF(p^n).

.PP
.TP 4
.B p
must be prime.
.TP 4
.B AL
= (G,AL1) is the arithmetic list of GF(p^n), see gfsalgen().
.TP 4
.B M
is a square matrix of polynomials in r variables over GF(p^n).
M*/







/*H
	Version 1       30.05.1990      Th. Weis
	Version 2	15.10.1991	Darstellung der -1 korrigiert.  TW
	Version 3	18.11.94	Macro nur noch im Header definiert. MP
   DATE mapgfschpol   : 910915.920331.941201
H*/
/*
	For the definition of mapgfschpol please refer to the header file _matr3.h.
*/


