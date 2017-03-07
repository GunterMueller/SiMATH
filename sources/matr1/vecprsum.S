/*M
.SH NAME
vecprsum - vector of polynomials over the rational numbers, sum (MACRO)

.SH SYNOPSIS
.nf
#include<_matr1.h>

vec vecprsum(r, U, V)
single r;
vec U, V;

.SH DESCRIPTION
vecprsum() returns the vector U+V.

.PP
.TP 4
.B U, V
are vectors of polynomials in r variables over the rational numbers.
U and V must have equal length.
M*/

/*H
	Version 1       15.03.1989      U.Schneiders
	Version 2	18.11.94	Macro nur noch im Header definiert. MP
   DATE vecprsum      : 890601.941201
H*/
/*
	For the definition of vecprsum please refer to the header file _matr1.h.
*/
