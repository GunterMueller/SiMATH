/*M
.SH NAME
vecpgfsneg - vector of polynomials over Galois-field with single characteristic, negation (MACRO)

.SH SYNOPSIS
.nf
#include<_matr3.h>

vec vecpgfsneg(r, p, AL, V)
single r,p;
list AL;
vec V;

.SH DESCRIPTION
vecpgfsneg() returns the vector -V.

.PP
.TP 4
.B p
must be prime.
.TP 4
.B AL
= (G,AL1) is the arithmetic list of GF(p^n), see gfsalgen().
.TP 4
.B V
is a vector of polynomials in r variables over GF(p^n).
M*/



/*H
	Version 1       21.03.1990      Th. Weis
	Version 2	18.11.94	Macro nur noch im Header definiert. MP
   DATE vecpgfsneg    : 910915.941201
H*/
/*
	For the definition of vecpgfsneg please refer to the header file _matr3.h.
*/


