/*M
.SH NAME
mapgf2vmul - matrix of polynomials over Galois-field of characteristic 2, vector multiplication  (MACRO)

.SH SYNOPSIS
.nf
#include<_matr3.h>

matrix mapgf2vmul(r, G, M, V)
single r;
obj G;
matrix M;
vec V;

.SH DESCRIPTION
mapgf2vmul() returns the matrix M*v.
.PP
.TP 4
.B G
is an irreducible monic polynomial in one variable over Z/2Z.
.TP 4
.B M
is a matrix in (GF(2^n)[x_1,...,x_r])^(i,j).
.TP 4
.B v
is a vector (GF(2^n)[x_1,...,x_r])^j.
M*/

/*H
	Version 1	22.06.1995	E.Herrmann
   DATE mapgf2vmul    : 951201
H*/
/*
	For the definition of mapgf2vmul please refer to the header file _matr3.h
*/


