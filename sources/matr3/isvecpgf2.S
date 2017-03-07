/*M
.SH NAME
isvecpgf2 - is vector of polynomials over Galois-field of characteristic 2?  (MACRO)

.SH SYNOPSIS
.nf
#include<_matr3.h>

single isvecpgf2(r, G, V)
single r;
obj G;
vec V;

.SH DESCRIPTION
isvecpgf2() returns 1 if V is in (GF(2^n)[x_1,...,x_r])^m and 0 otherwise.

.PP
.TP 4
.B G
is an irreducible monic polynomial in one variable over Z/2Z.
.TP 4
.B V
is a vector in (GF(2^n)[x_1,...,x_r])^m.
M*/


/*H
	Version 1	22.06.1995	E.Herrmann
   DATE isvecpgf2     : 951201
H*/
/*
	For the definition of isvecpgf2 please refer to the header file _matr3.h
*/


