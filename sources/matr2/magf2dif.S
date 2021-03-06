/*M
.SH NAME
magf2dif - matrix over Galois-field of characteristic 2, difference (MACRO)

.SH SYNOPSIS
.nf
#include<_matr2.h>

matrix magf2dif(G, M, N)
obj G;
matrix M, N;

.SH DESCRIPTION
magf2dif() returns the matrix M-N.

.PP
.TP 4
.B G
is an irreducible monic polynomial in one variable over Z/2Z.
.TP 4
.B M, N
are matrices over the Galois-field generated by G.
M and N must have equal dimensions.
M*/


/*H
	Version 1	22.06.1995	E.Herrmann
   DATE magf2dif      : 951201
H*/
/*
	For the definition of magf2dif please refer to the header file _matr2.h
*/
