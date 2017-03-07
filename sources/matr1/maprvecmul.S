/*M
.SH NAME
maprvecmul - matrix of polynomials over the rational numbers, vector multiplication (MACRO)

.SH SYNOPSIS
.nf
#include<_matr1.h>

vec maprvecmul(r, M, v)
single r;
matrix M;
vec v;

.SH DESCRIPTION
maprvecmul() returns the vector M*v.

.PP
.TP 4
.B M
is a matrix of polynomials in r variables over the rational numbers.
.TP 4
.B v
is a vector of polynomials in r variables over the rational numbers.
M and v must have compatible dimensions.
M*/
/*H
	Version 1       22.11.1988      Klaus Petry
	Version 2	18.11.94	Macro nur noch im Header definiert. MP
   DATE maprvecmul    : 890501.941201
H*/
/*
	For the definition of maprvecmul please refer to the header file _matr1.h.
*/
