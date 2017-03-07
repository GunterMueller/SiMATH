/*M
.SH NAME
mapgf2chpol - matrix of polynomials over Galois-field of characteristic 2, characteristic polynomial  (MACRO)

.SH SYNOPSIS
.nf
#include<_matr3.h>

pol mapgf2chpol(r, G, M)
single r;
obj G;
matrix M;

.SH DESCRIPTION
mapgf2chpol() returns the characteristic polynomial of the matrix M.
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
   DATE mapgf2chpol   : 951201
H*/
/*
	For the definition of mapgf2chpol please refer to the header file _matr3.h
*/


