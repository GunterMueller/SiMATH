/*M
.SH NAME
marfmsp1vmul - matrix of rational functions over modular single primes, transcendence degree 1, vector multiplication (MACRO)

.SH SYNOPSIS
.nf
#include<_matr3.h>

vec marfmsp1vmul(p, A, x)
single p;
matrix A;
vec x;

.SH DESCRIPTION
marfmsp1vmul() returns the vector A*x.

.PP
.TP 4
.B p
must be prime.
.TP 4
.B A
is a matrix of rational functions in one variable over Z/pZ.
.TP 4
.B x
is a vector of rational functions in one variable over Z/pZ.

M*/



/*H
	Version 1       05.06.1989      U. Schneiders, Th. Weis
	Version 2	18.11.94	Macro nur noch im Header definiert. MP
   DATE marfmsp1vmul  : 890801.9109__.941201
H*/
/*
	For the definition of marfmsp1vmul please refer to the header file _matr3.h.
*/


