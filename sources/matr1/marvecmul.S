/*M
.SH NAME
marvecmul - matrix of rational numbers, vector multiplication (MACRO)

.SH SYNOPSIS
.nf
#include<_matr1.h>

vec marvecmul(M, v)
matrix M;
vec v;

.SH DESCRIPTION
marvecmul() returns the vector M*v.

.PP
.TP 4
.B M
is a matrix of rational numbers.
.TP 4
.B v
is a vector of rational numbers.
M and v must have compatible dimensions.
M*/
/*H
	Version 1       22.11.1988      Klaus Petry
	Version 2	18.11.94	Macro nur noch im Header definiert. MP
   DATE marvecmul     : 890501.941201
H*/
/*
	For the definition of marvecmul please refer to the header file _matr1.h.
*/
