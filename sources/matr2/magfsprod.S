/*M
.SH NAME
magfsprod - matrix of Galois-field with single characteristic elements product (MACRO)

.SH SYNOPSIS
.nf
#include<_matr2.h>

matrix magfsprod(p, AL, M, N)
single p;
list AL;
matrix M,N;

.SH DESCRIPTION
magfsprod() returns the matrix M*N.

.PP
.TP 4
.B p
must be prime.
.TP 4
.B AL
= (G,AL1) is the arithmetic list of GF(p^n), see gfsalgen().
.TP 4
.B M,N
are matrices over GF(p^n).
M and N must have compatible dimensions.
M*/


/*H
	Version 1       29.03.1990      Th. Weis
	Version 2	18.11.94	Macro nur noch im Header definiert. MP
   DATE magfsprod     : 910915.941201
H*/
/*
	For the definition of magfsprod please refer to the header file _matr2.h.
*/
