/*M
.SH NAME
fputmarfr - file put matrix of rational functions over the rational numbers (MACRO)

.SH SYNOPSIS
.nf
#include<_matr3.h>

single fputmarfr(r, M, VL, pf)
single r;
matrix M;
list VL;
FILE *pf;

.SH DESCRIPTION
fputmarfr() writes the matrix M to the output file *pf
and returns 0 or ERROR in case an error has occurred.
.PP
.TP 4
.B M
is a matrix of rational functions in r variables over the rational numbers.
.TP 4
.B VL
is a list of r variables.
.TP 4
.B pf
is a pointer to the output file.

.SH SEE ALSO
fputrfr
M*/










/*H
	Version 1       29.05.1989      U. Schneiders, Th. Weis
	Version 2	18.11.94	Macro nur noch im Header definiert. MP
   DATE fputmarfr     : 890801.9109__.941201
H*/
/*
	For the definition of fputmarfr please refer to the header file _matr3.h.
*/


