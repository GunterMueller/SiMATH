/*M
.SH NAME
magfssum - matrix of Galois-field with single characteristic elements, sum (MACRO)

.SH SYNOPSIS
.nf
#include<_matr2.h>

matrix magfssum(p, AL, M, N)
single p;
list AL;
matrix M,N;

.SH DESCRIPTION
magfssum() returns the matrix M+N.

.PP
.TP 4
.B p
must be prime.
.TP 4
.B AL
= (G,AL1) is the arithmetic list of GF(p^n), see gfsalgen().
.TP 4
.B M,N
M and N are matrices over GF(p^n).
M and N must have equal dimensions.
M*/


/*H
	Version 1       22.03.1990      Th. Weis
	Version 2	18.11.94	Macro nur noch im Header definiert. MP
   DATE magfssum      : 910915.941201
H*/
/*
	For the definition of magfssum please refer to the header file _matr2.h.
*/
