/*M
.SH NAME
isvecgf2 - is vector over Galois-field of characteristic 2 ? (MACRO)

.SH SYNOPSIS
.nf
#include<_matr2.h>

single isvecgf2(G, V)
obj G;
vec V;

.SH DESCRIPTION
isvecgf2() returns 1 if V is a vector over GF(2^n)
and 0 otherwise.

.PP
.TP 4
.B G
is an irreducible monic polynomial in one variable over Z/2Z,
generating the Galois-field GF(2^n).
.TP 4
.B V
is the vector to be tested.
M*/


/*H
	Version 1	22.06.1995	E.Herrmann
   DATE isvecgf2      : 951201
H*/
/*
	For the definition of isvecgf2 please refer to the header file _matr2.h
*/
