/*M
.SH NAME
fputvpgf2 - file put vector of polynomials over Galois-field with characteristic 2  (MACRO)

.SH SYNOPSIS
.nf
#include<_matr3.h>

single fputvpgf2(r, V, G, VL, Vgf2, pf)
single r;
vec V;
list VL, Vgf2;
FILE *pf;

.SH DESCRIPTION
fputvpgf2() writes the vector V to the output file *pf
and returns 0 or ERROR in case an error has occurred.
.PP
.TP 4
.B G
is an irreducible monic polynomial in one variable over Z/2Z.
.TP 4
.B M
is a vector in (GF(2^n)[x_1,...,x_r])^m.
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
   DATE fputvpgf2     : 951201
H*/
/*
	For the definition of fputvpgf2 please refer to the header file _matr3.h
*/
 


