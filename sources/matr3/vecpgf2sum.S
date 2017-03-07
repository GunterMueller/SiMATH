/*M
.SH NAME
vecpgf2sum - vector of polynomials over Galois-field of characteristic 2, sum  (MACRO)

.SH SYNOPSIS
.nf
#include<_matr3.h>

vec vecpgf2sum(r, G, U, V)
single r;
obj G;
vec M, N;

.SH DESCRIPTION
vecpgf2sum() returns the vector U+V.
.PP
.TP 4
.B r
is the number of variables used in the polynomials.
.TP 4
.B G
is an irreducible monic polynomial in one variable over Z/2Z.
.TP 4
.B  U,V
are vectors in (GF(2^n)[x_1,...,x_r])^m
M*/
/*H
	Version 1	22.06.1995	E.Herrmann
   DATE vecpgf2sum    : 951201
H*/
/*
	For the definition of vecpgf2sum please refer to the header file _matr3.h
*/


