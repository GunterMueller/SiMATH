/*M
.SH NAME
vecnfssum - vector of number field elements, sparse representation, sum (MACRO)

.SH SYNOPSIS
.nf
#include<_matr2.h>

vec vecnfssum(F, U, V)
pol F;
vec V;

.SH DESCRIPTION
vecnfssum() returns the vector U+V.

.PP
.TP 4
.B F
is an irreducible sparse polynomial in one variable over the rational numbers.
.TP 4
.B U,V
are vectors over the number field generated by F.
U and V must have equal length.
M*/



/*H
	Version 1       22.03.1990      Th. Weis
	Version 2	18.11.94	Macro nur noch im Header definiert. MP
   DATE vecnfssum     : 910915.941201
H*/
/*
	For the definition of vecnfssum please refer to the header file _matr2.h.
*/
