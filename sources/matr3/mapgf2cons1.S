/*M
.SH NAME
mapgf2cons1 - matrix of polynomials over Galois-field of characteristic 2, construction 1  (MACRO)

.SH SYNOPSIS
.nf
#include<_matr3.h>

matrix mapgf2cons1(r, G, n)
single r, n;
obj G;

.SH DESCRIPTION
mapgf2cons1() the matrix E=(D_ij) i,j=1,...,n where D_ij=1 for i=j and 0 otherwise.
.PP
.TP 4
.B r
is the number of variables used in the polynomials.
.TP 4
.B G
is an irreducible monic polynomial in one variable over Z/2Z.
.TP 4
.B n
with 1<= n <BASIS is the dimension of the matrix to be constructed.
M*/

/*H
	Version 1	28.09.1995	E.Herrmann
   DATE mapgf2cons1   : 951201
H*/
/*
	For the definition of mapgf2cons1 please refer to the header file _matr3.h
*/


