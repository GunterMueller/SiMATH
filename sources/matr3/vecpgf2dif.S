/*M
.SH NAME
vecpgf2dif - vector of polynomials over Galois-field with characteristic 2, difference  (MACRO)

.SH SYNOPSIS
.nf
#include<_matr3.h>

vec vecpgf2dif(r, G, U, V)
single r;
obj G;
vec U, V;

.SH DESCRIPTION
vecpgf2dif() returns the vector U-V.
.PP
.TP 4
.B r
is the number of variables used in the polynomials..TP 4
.B G
is an irreducible monic polynomial in one variable over Z/2Z.
.TP 4
.B  U,V
are vectors in (GF(2^n)[x_1,...,x_r])^m
M*/

/*H
	Version 1	22.06.1995	E.Herrmann
H*/
/*
	For the definition of vecpgf2dif please refer to the header file _matr3.h
*/
 


