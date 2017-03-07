/*M
.SH NAME
magfsdif - matrix of Galois-field with single characteristic elements, difference (MACRO)

.SH SYNOPSIS
.nf
#include<_matr2.h>

matrix magfsdif(p, AL, M, N)
single p;
list AL;
matrix M,N;

.SH DESCRIPTION
magfsdif() returns the matrix M-N.

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
	Version 1       18.04.1990      Th. Weis
	Version 2	18.11.94	Macro nur noch im Header definiert. MP
   DATE magfsdif      : 910915.941201
H*/
/*
	For the definition of magfsdif please refer to the header file _matr2.h.
*/
