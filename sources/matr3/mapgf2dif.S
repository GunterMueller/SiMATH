/*M
.SH NAME
mapgf2dif - matrix of polynomials over Galois-field of characteristic 2, difference  (MACRO)

.SH SYNOPSIS
.nf
#include<_matr3.h>

matrix mapgf2dif(r, G, M, N)
single r;
obj G;
matrix M, N;

.SH DESCRIPTION
mapgf2dif() returns the matrix M-N.
.PP
.PP
.TP 4
.B r
is the number of variables used in the polynomials.
.TP 4
.B G
is an irreducible monic polynomial in one variable over Z/2Z.
.TP 4
.B M, N
are matrices in (GF(2^n)[x_1,...,x_r])^(i,j).
M*/
/*H
	Version 1	22.06.1995	E.Herrmann
   DATE mapgf2dif     : 951201
H*/
/*
	For the definition of mapgf2dif please refer to the header file _matr3.h
*/
 


