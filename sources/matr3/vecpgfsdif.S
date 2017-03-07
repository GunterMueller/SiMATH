/*M
.SH NAME
vecpgfsdif - vector of polynomials over Galois-field with single characteristic, difference (MACRO)

.SH SYNOPSIS
.nf
#include<_matr3.h>

vec vecpgfsdif(r, p, AL, U, V)
single r,p;
list AL;
matrix U,V;

.SH DESCRIPTION
vecpgfsdif() returns the vector U-V.

.PP
.TP 4
.B p
must be prime.
.TP 4
.B AL
= (G,AL1) is the arithmetic list of GF(p^n), see gfsalgen().
.TP 4
.B U,V
are vectors of polynomials in r variables over GF(p^n).
U and V must have equal length.
M*/









/*H
	Version 1       18.04.1990      Th. Weis
	Version 2	18.11.94	Macro nur noch im Header definiert. MP
   DATE vecpgfsdif    : 910915.941201
H*/
/*
	For the definition of vecpgfsdif please refer to the header file _matr3.h.
*/


