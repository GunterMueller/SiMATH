/*M
.SH NAME
ismagfs - is matrix of Galois-field with single characteristic elements ? (MACRO)

.SH SYNOPSIS
.nf
#include<_matr2.h>

single ismagfs(p, AL, M)
obj p,AL,M;

.SH DESCRIPTION
ismagfs() returns 1 if M is a matrix over GF(p^n) and 0 otherwise.
.TP 4
.B p
must be prime.
.TP 4
.B AL
= (G, AL1) is the arithmetic list of GF(p^n), see gfsalgen().
.TP 4
.B M
is the matrix to be tested.
M*/


/*H
	Version 1       09.05.1990      Th. Weis
	Version 2	18.11.94	Macro nur noch im Header definiert. MP
   DATE ismagfs       : 910915.941201
H*/
/*
	For the definition of ismagfs please refer to the header file _matr2.h.
*/
