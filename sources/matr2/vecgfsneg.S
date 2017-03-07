/*M
.SH NAME
vecgfsneg - vector of Galois-field with single characteristic elements, negation (MACRO)

.SH SYNOPSIS
.nf
#include<_matr2.h>

vector vecgfsneg(p, AL, V)
single p;
list AL;
vec V;

.SH DESCRIPTION
vecgfsneg() returns the vector -V.

.PP
.TP 4
.B p
must be prime.
.TP 4
.B AL
= (G,AL1) is the arithmetic list of GF(p^n), see gfsalgen().
.TP 4
.B V
is a vector over GF(p^n).
M*/


/*H
	Version 1       21.03.1990      Th. Weis
	Version 2	18.11.94	Macro nur noch im Header definiert. MP
   DATE vecgfsneg     : 910915.941201
H*/
/*
	For the definition of vecgfsneg please refer to the header file _matr2.h.
*/
