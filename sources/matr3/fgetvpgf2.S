/*M
.SH NAME
fgetvpgf2 - file get vector of polynomials over Galois-field of characteristic 2  (MACRO)

.SH SYNOPSIS
.nf
#include<_matr3.h>

vec fgetvpgf2(r, G, VL, Vgf2, pf)
single r;
obj G;
list VL;
list Vgf2
FILE *pf;

.SH DESCRIPTION
fgetvpgf2() returns the vector of polynomials in r variables over GF(2^n)
read from the input file *pf or ERROR in case an error has occurred.
.PP
.TP 4
.B G
is an irreducible monic polynomial in one variable over Z/2Z.
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
   DATE fgetvpgf2     : 951201
H*/
/*
	For the definition of fgetvpgf2 please refer to the header file _matr3.h
*/


