/*M
.SH NAME
fputmapr - file put matrix of polynomials over the rational numbers (MACRO)

.SH SYNOPSIS
.nf
#include<_matr1.h>

single fputmapr(r, M, VL, pf)
single r;
matrix M;
list VL;
FILE *pf;

.SH DESCRIPTION
fputmapr() writes the matrix M to the output file *pf
and returns 0 or ERROR in case an error has occurred.


.PP
.TP 4
.B r
is the number of variables.
.TP 4
.B M
is a matrix of polynomials in r variables over Z/mZ.
.TP 4
.B VL
is the variable list of the polynomials.
.TP 4
.B pf
is a pointer to the output file.
M*/







/*H
	Version 1       04.06.1988      Klaus Petry
	Version 2       03.11.1988      Klaus Petry     Macro
	Version 3	18.11.94	Macro nur noch im Header definiert. MP
   DATE fputmapr      : 890501.941201
H*/
/*
	For the definition of fputmapr please refer to the header file _matr1.h.
*/
