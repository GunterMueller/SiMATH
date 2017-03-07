/*M
.SH NAME
magfsneg - matrix of Galois-field with single characteristic elements, negation (MACRO)

.SH SYNOPSIS
.nf
#include<_matr2.h>

matrix magfsneg(p, AL, M)
single p;
list AL;
matrix M;

.SH DESCRIPTION
magfsneg() returns the matrix -M.

.PP
.TP 4
.B p
must be prime.
.TP 4
.B AL
= (G,AL1) is the arithmetic list of GF(p^n), see gfsalgen().
.TP 4
.B M
is a matrix over GF(p^n).
M*/


/*H
	Version 1       21.03.1990      Th. Weis
	Version 2	18.11.94	Macro nur noch im Header definiert. MP
   DATE magfsneg      : 910915.941201
H*/
/*
	For the definition of magfsneg please refer to the header file _matr2.h.
*/
