/*M
.SH NAME
mapgf2prod - matrix of polynomials over Galois-field of characteristic 2, product (MACRO)

.SH SYNOPSIS
.nf
#include<_matr3.h>

matrix mapgf2prod(r, G, M, N)
single r;
obj G;
matrix M, N;

.SH DESCRIPTION
mapgf2prod() returns the matrix M*N. 
.PP
.TP 4
.B G
is an irreducible monic polynomial in one variable over Z/2Z.
.TP 4
.B M
is a matrix in (GF(2^n)[x_1,...,x_r])^(i,j).
.TP 4
.B N
is a matrix in (GF(2^n)[x_1,...,x_r])^(j,k).
M*/


/*H
	Version 1	22.06.1995	E.Herrmann
   DATE mapgf2prod    : 951201
H*/
/*
	For the definition of mapgf2prod please refer to the header file _matr3.h
*/


