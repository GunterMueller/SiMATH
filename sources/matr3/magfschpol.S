/*M
.SH NAME
magfschpol - matrix over Galois-field with single characteristic elements, characteristic polynomial (MACRO)

.SH SYNOPSIS
.nf
#include<_matr3.h>

pol magfschpol(p, AL, M)
single p;
list AL;
matrix M;

.SH DESCRIPTION
magfschpol() returns the characteristic polynomial of M, i.e.
chp(X) = det( M - X * I ), where I is the unity matrix.
chp is a polynomial in one variable over GF(p^n).

.PP
.TP 4
.B p
must be prime.
.TP 4
.B AL
= (G,AL1) is the arithmetic list of GF(p^n), see gfsalgen().
.TP 4
.B M
is a square matrix over GF(p^n).
M*/






/*H
	Version 1       16.05.1990      Th. Weis
	Version 2	14.10.1991	Darstellung der -1 korrigiert.  TW
	Version 3	18.11.94	Macro nur noch im Header definiert. MP
   DATE magfschpol    : 910915.920331.941201
H*/
/*
	For the definition of magfschpol please refer to the header file _matr3.h.
*/


