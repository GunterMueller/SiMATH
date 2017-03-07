/*M
.SH NAME
mapivecmul - matrix of polynomials over integers, vector multiplication (MACRO)

.SH SYNOPSIS
.nf
#include<_matr1.h>

vec mapivecmul(r, M, v)
single r;
matrix M;
vec v;

.SH DESCRIPTION
mapivecmul() returns the vector M*v.

.PP
.TP 4
.B M
is a matrix of polynomials in r variables over integers.
.TP 4
.B v
is a vector of polynomials in r variables over integers.
M and v must have compatible dimensions.
M*/
/*H
	Version 1       22.11.1988      Klaus Petry
	Version 2	18.11.94	Macro nur noch im Header definiert. MP
   DATE mapivecmul    : 890501.941201
H*/
/*
	For the definition of mapivecmul please refer to the header file _matr1.h.
*/
