/*M
.SH NAME
mapgfsneg - matrix of polynomials over Galois-field with single characteristic, negation (MACRO)

.SH SYNOPSIS
.nf
#include<_matr3.h>

matrix mapgfsneg(r, p, AL, M)
single r,p;
list AL;
matrix M;

.SH DESCRIPTION
mapgfsneg() returns the matrix -M.

.PP
.TP 4
.B p
must be prime.
.TP 4
.B AL
= (G,AL1) is the arithmetic list of GF(p^n), see gfsalgen().
.TP 4
.B M
is a matrix of polynomials in r variables over GF(p^n).
M*/







/*H
	Version 1       21.03.1990      Th. Weis
	Version 2	18.11.94	Macro nur noch im Header definiert. MP
   DATE mapgfsneg     : 910915.941201
H*/
/*
	For the definition of mapgfsneg please refer to the header file _matr3.h.
*/


