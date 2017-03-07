/*M
.SH NAME
mapgfsdif - matrix of polynomials over Galois-field with single characteristic, difference (MACRO)

.SH SYNOPSIS
.nf
#include<_matr3.h>

matrix mapgfsdif(r, p, AL, M, N)
single r,p;
list AL;
matrix M,N;

.SH DESCRIPTION
mapgfsdif() returns the matrix M-N.

.PP
.TP 4
.B p
must be prime.
.TP 4
.B AL
= (G,AL1) is the arithmetic list of GF(p^n), see gfsalgen().
.TP 4
.B M,N
are matrices of polynomials in r variables over GF(p^n).
M and N must have equal dimensions.
M*/













/*H
	Version 1       18.04.1990      Th. Weis
	Version 2	18.11.94	Macro nur noch im Header definiert. MP
   DATE mapgfsdif     : 910915.941201
H*/
/*
	For the definition of mapgfsdif please refer to the header file _matr3.h.
*/


