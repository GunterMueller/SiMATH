/*M
.SH NAME
vecpmssum - vector of polynomials over modular singles, sum (MACRO)

.SH SYNOPSIS
.nf
#include<_matr1.h>

vec vecpmssum(r, m, U, V)
single r, m;
vec U, V;

.SH DESCRIPTION
vecpmssum() returns the vector U+V.

.PP
.TP 4
.B U, V
are vectors of polynomials in r variables over Z/mZ.
U and V must have equal length.
M*/

/*H
	Version 1       15.03.1989      U.Schneiders
	Version 2	18.11.94	Macro nur noch im Header definiert. MP
   DATE vecpmssum     : 890601.9203__.941201
H*/
/*
	For the definition of vecpmssum please refer to the header file _matr1.h.
*/
