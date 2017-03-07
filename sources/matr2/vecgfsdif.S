/*M
.SH NAME
vecgfsdif - vector of Galois-field with single characteristic elements, difference (MACRO)

.SH SYNOPSIS
.nf
#include<_matr2.h>

vec vecgfsdif(p, AL, U ,V)
single p;
list AL;
matrix U,V;

.SH DESCRIPTION
vecgfsdif() returns the vector U-V.

.PP
.TP 4
.B p
must be prime.
.TP 4
.B AL
= (G,AL1) is the arithmetic list of GF(p^n), see gfsalgen().
.TP 4
.B U,V
are vectors over GF(p^n).
U and V must have equal length.
M*/


/*H
	Version 1       22.03.1990      Th. Weis
	Version 2	18.11.94	Macro nur noch im Header definiert. MP
   DATE vecgfsdif     : 910915.941201
H*/
/*
	For the definition of vecgfsdif please refer to the header file _matr2.h.
*/
