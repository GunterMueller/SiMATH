/*M
.SH NAME
vecmisum - vector of modular integers, sum (MACRO)

.SH SYNOPSIS
.nf
#include<_matr1.h>

vec vecmisum(m, U, V)
int m;
vec U, V;

.SH DESCRIPTION
vecmisum() returns the vector U+V.

.PP
.TP 4
.B U, V
are vectors over Z/mZ.
U and V must have equal length.
M*/
/*H
	Version 1       31.01.1992     Bernd Mayr 
	Version 2	18.11.94	Macro nur noch im Header definiert. MP
   DATE vecmisum      : 920331.941201
H*/
/*
	For the definition of vecmisum please refer to the header file _matr1.h.
*/
