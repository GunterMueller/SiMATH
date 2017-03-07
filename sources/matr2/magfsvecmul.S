/*M
.SH NAME
magfsvecmul - matrix of Galois-field with single characteristic elements, vector multiplication (MACRO)

.SH SYNOPSIS
.nf
#include<_matr2.h>

matrix magfsvecmul(p, AL, M, v)
single p;
list AL;
matrix M;
vec v;

.SH DESCRIPTION
magfsvecmul() returns the matrix M*v.
M and v must have compatible dimensions.

.PP
.TP 4
.B p
must be prime.
.TP 4
.B AL
= (G,AL1) is the arithmetic list of GF(p^n), see gfsalgen().
.TP 4
.B M
is a matrix over GF(p^n).
.TP 4
.B v
is a vector over GF(p^n).
M*/


/*H
	Version 1       05.04.1990      Th. Weis
	Version 2	18.11.94	Macro nur noch im Header definiert. MP
   DATE magfsvecmul   : 910915.941201
H*/
/*
	For the definition of magfsvecmul please refer to the header file _matr2.h.
*/
