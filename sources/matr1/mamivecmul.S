/*M
.SH NAME
mamivecmul - matrix of modular integers, vector multiplication (MACRO)

.SH SYNOPSIS
.nf
#include<_matr1.h>

vec mamivecmul(m, M, v)
int m;
matrix M;
vec v;

.SH DESCRIPTION
mamivecmul() returns the vector M*v.

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
	Version 1       31.01.1992       Bernd Mayr
	Version 2	18.11.94	Macro nur noch im Header definiert. MP
   DATE mamivecmul    : 920331.941201
H*/
/*
	For the definition of mamivecmul please refer to the header file _matr1.h.
*/
