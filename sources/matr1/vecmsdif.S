/*M
.SH NAME
vecmsdif - vector of modular singles, difference (MACRO)

.SH SYNOPSIS
.nf
#include<_matr1.h>

vec vecmsdif(m, U, V)
single m;
vec U, V;

.SH DESCRIPTION
vecmsdif() returns the vector U-V.

.PP
.TP 4
.B U, V
are vectors over Z/mZ.
U and V must have equal length.
M*/

/*H
	Version 1       15.03.1989      U.Schneiders
	Version 2	18.11.94	Macro nur noch im Header definiert. MP
   DATE vecmsdif      : 890601.9203__.941201
H*/
/*
	For the definition of vecmsdif please refer to the header file _matr1.h.
*/
