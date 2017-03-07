/*M
.SH NAME
fputmapgf2 - file put matrix of polynomials over Galois-field of characteristic 2  (MACRO)

.SH SYNOPSIS
.nf
#include<_matr3.h>

single fputmagf2(r, M, G, VL, Vgf2, pf)
single r;
matrix M;
list VL, Vgf2;
FILE *pf;

.SH DESCRIPTION
fputmapgf2() writes the matrix M to the output file *pf
and returns 0 or ERROR in case an error has occurred.
.PP
.TP 4
.B G
is an irreducible monic polynomial in one variable over Z/2Z.
.TP 4
.B M
is a matrix in (GF(2^n)[x_1,...,x_r])^(i,j).
.TP 4
.B VL
is a variable list for GF(2^n)[x_1, ..., x_r].
.TP 4
.B Vgf2
is the variable list of G which contains one element.
.TP 4
.B pf
is a pointer to the output file.
M*/

/*H
	Version 1	22.06.1995	E.Herrmann
   DATE fputmapgf2    : 951201
H*/
/*
	For the definition of fputmapgf2 please refer to the header file _matr3.h
*/


