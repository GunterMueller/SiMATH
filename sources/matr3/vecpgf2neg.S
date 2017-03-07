/*M
.SH NAME
vecpgf2neg - vector of polynomials over Galois-field of characteristic 2, negation  (MACRO)

.SH SYNOPSIS
.nf
#include<_matr3.h>

vec vecpgf2neg(r, G, V)
single r;
obj G;
vec V;

.SH DESCRIPTION
vecpgf2neg() returns the vector -V.
.PP
.TP 4
.B r
is the number of variables used in the polynomials.
.TP 4
.B G
is an irreducible monic polynomial in one variable over Z/2Z.
.TP 4
.B  V
is a vector in (GF(2^n)[x_1,...,x_r])^m
M*/
/*H
	Version 1	22.06.1995	E.Herrmann
   DATE vecpgf2neg    : 951201
H*/
/*
	For the definition of vecpgf2neg please refer to the header file _matr3.h
*/ 


