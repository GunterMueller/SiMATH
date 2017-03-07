/*M
.SH NAME
ismapgf2 - is matrix of polynomials over Galois-field with  characteristic 2 ?  (MACRO)

.SH SYNOPSIS
.nf
#include<_matr3.h>

single ismapgf2(r, G, M)
single r;
obj G;
matrix M;

.SH DESCRIPTION
ismapgf2() returns 1 if M is in (GF(2^n)[x_1,...,x_r])^(i,j) and 0 otherwise.
.PP
.TP 4
.B G
is an irreducible monic polynomial in one variable over Z/2Z.
.TP 4
.B M
is a matrix in (GF(2^n)[x_1,...,x_r])^(i,j).
M*/
/*H
	Version 1	22.06.1995	E.Herrmann
   DATE ismapgf2      : 951201
H*/
/*
	For the definition of ismapgf2 please refer to the header file _matr3.h
*/
 


