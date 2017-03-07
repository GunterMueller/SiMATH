/*M
.SH NAME
mapgf2sum - matrix of polynomials over Galois-field of characteristic 2, sum  (MACRO)

.SH SYNOPSIS
.nf
#include<_matr3.h>

matrix mapgf2sum(r, G, M, N) 
single r;
obj G;
matrix M, N;

.SH DESCRIPTION
mapgf2sum() returns the matrix M+N.
.PP
.TP 4
.B G
is an irreducible monic polynomial in one variable over Z/2Z.
.TP 4
.B M, N
are matrices in (GF(2^n)[x_1,...,x_r])^(i,j).
M*/
/*H
	Version 1	22.06.1995	E.Herrmann
   DATE mapgf2sum     : 951201
H*/
/*
	For the definition of mapgf2sum please refer to the header file _matr3.h
*/


