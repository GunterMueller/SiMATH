/*M
.SH NAME
mapgf2neg - matrix of polynomials over Galois-field of characteristic 2, negation  (MACRO)

.SH SYNOPSIS
.nf
#include<_matr3.h>

matrix mapgf2neg(r, G, M)
single r;
obj G;
matrix M;

.SH DESCRIPTION
mapgf2neg() returns the matrix -M.
.PP
.TP 4
.B r
is the number of variables used in the polynomials.
.TP 4
.B G
is an irreducible monic polynomial in one variable over Z/2Z.
.TP 4
.B M
is a matrix in (GF(2^n)[x_1,...,x_r])^(i,j).
M*/
/*H
	Version 1	22.06.1995	E.Herrmann
   DATE mapgf2neg     : 951201
H*/
/*
	For the definition of mapgf2neg please refer to the header file _matr3.h
*/ 


