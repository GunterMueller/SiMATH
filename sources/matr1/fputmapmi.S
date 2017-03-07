/*M
.SH NAME
fputmapmi - file put matrix of polynomials over modular integers (MACRO)

.SH SYNOPSIS
.nf
#include<_matr1.h>

single fputmapmi(r, m, M, VL, pf)
single r;
int m;
matrix M;
list VL;
FILE *pf;

.SH DESCRIPTION
fputmapmi() writes the matrix M to the output file *pf
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
	Version 1       31.01.1992      Bernd Mayr
	Version 2	18.11.94	Macro nur noch im Header definiert. MP
   DATE fputmapmi     : 920331.941201
H*/
/*
	For the definition of fputmapmi please refer to the header file _matr1.h.
*/
