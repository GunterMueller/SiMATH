/*M
.SH NAME
magf2vecmul - matrix over Galois-field of characteristic 2, vector multiplication (MACRO)

.SH SYNOPSIS
.nf
#include<_matr2.h>

matrix magf2vecmul(G, M, v)
obj G;
matrix M;
vec v;

.SH DESCRIPTION
magf2vecmul() returns the matrix M*v.
M and v must have compatible dimensions.

.PP
.TP 4
.B G
is an irreducible monic polynomial in one variable over Z/2Z,
generating the Galois-field GF(2^n).
.TP 4
.B M
is a matrix over GF(2^n).
.TP 4
.B v
is a vector over GF(2^n).
M*/



/*H
	Version 1	22.06.1995	E.Herrmann
   DATE magf2vecmul   : 951201
H*/
/*
	For the definition of magf2vecmul please refer to the header file _matr2.h
*/

