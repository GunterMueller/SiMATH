/*M
.SH NAME
mapgfsvmul - matrix of polynomials over Galois-field with single characteristic, vector multiplication (MACRO)

.SH SYNOPSIS
.nf
#include<_matr3.h>

matrix mapgfsvmul(r, p, AL, A, x)
single r,p;
list AL;
matrix A;
vec x;

.SH DESCRIPTION
mapgfsvmul() returns the vector A*x.

.PP
.TP 4
.B p
must be prime.
.TP 4
.B AL
= (G,AL1) is the arithmetic list of GF(p^n), see gfsalgen().
.TP 4
.B A
is a matrix of polynomials in r variables over GF(p^n).
.TP 4
.B x
is a vector of polynomials in r variables over GF(p^n).

M*/



/*H
	Version 1       05.04.1990      Th. Weis
	Version 2	18.11.94	Macro nur noch im Header definiert. MP
   DATE mapgfsvmul    : 910915.941201
H*/
/*
	For the definition of mapgfsvmul please refer to the header file _matr3.h.
*/


