/*M
.SH NAME
vecpmidif - vector of polynomials over modular integers, difference (MACRO)

.SH SYNOPSIS
.nf
#include<_matr1.h>

vec vecpmidif(r, m, U, V)
single r;
int m;
vec U, V;

.SH DESCRIPTION
vecpmidif() returns the vector U-V.

.PP
.TP 4
.B U, V
are vectors of polynomials in r variables over Z/mZ.
U and V must have equal length.
M*/


/*H
	Version 1       31.01.1992      Bernd Mayr
	Version 2	18.11.94	Macro nur noch im Header definiert. MP
   DATE vecpmidif     : 920331.941201
H*/
/*
	For the definition of vecpmidif please refer to the header file _matr1.h.
*/
