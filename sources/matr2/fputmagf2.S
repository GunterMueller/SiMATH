/*M
.SH NAME
fputmagf2 - file put matrix over Galois-field of characteristic 2 (MACRO)

.SH SYNOPSIS
.nf
#include<_matr2.h>

single fputmagf2(G, M, VL, pf) 
obj G;
matrix M;
list VL;
FILE *pf;

.SH DESCRIPTION
fputmagf2() writes the matrix M to the output file *pf
and returns 0 or ERROR in case an error has occurred.
.PP
.TP 4
.B G
is an irreducible monic polynomial in one variable over Z/2Z,
generating the Galois-field GF(2^n).
.TP 4
.B M
is a matrix over GF(2^n).
.TP 4
.B VL
is the variable list of G which contains one element.
.TP 4
.B pf
is a pointer to the output file.
M*/


/*H
	Version 1	22.06.1995	E.Herrmann
   DATE fputmagf2     : 951201
H*/
/*
	For the definition of fputmagf2 please refer to the header file _matr2.h
*/
 
