/*M
.SH NAME
mamsvecmul - matrix of modular singles, vector multiplication (MACRO)

.SH SYNOPSIS
.nf
#include<_matr1.h>

vec mamsvecmul(m, M, v)
single m;
matrix M;
vec v;

.SH DESCRIPTION
mamsvecmul() returns the vector M*v.

.PP
.TP 4
.B M
is a matrix over Z/mZ.
.TP 4
.B v
is a vector over Z/mZ.
M and v must have compatible dimensions.
M*/
/*H
	Version 1       22.11.1988      Klaus Petry
	Version 2	18.11.94	Macro nur noch im Header definiert. MP
   DATE mamsvecmul    : 890501.9203__.941201
H*/
/*
	For the definition of mamsvecmul please refer to the header file _matr1.h.
*/
