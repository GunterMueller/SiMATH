/*M
.SH NAME
fputmar - file put matrix of rational numbers (MACRO)

.SH SYNOPSIS
.nf
#include<_matr1.h>

single fputmar(M, pf)
matrix M;
FILE *pf;

.SH DESCRIPTION
fputmar() writes the matrix M to the output file *pf
and returns 0 or ERROR in case an error has occurred.

.PP
.TP 4
.B M
is a matrix of rational numbers.
.TP 4
.B pf
is a pointer to the output file.
M*/
/*H
	Version 1       24.05.1988      Klaus Petry
	Version 2       03.11.1988      Klaus Petry     Macro
	Version 3	18.11.94	Macro nur noch im Header definiert. MP
   DATE fputmar       : 890501.9311__.941201
H*/
/*
	For the definition of fputmar please refer to the header file _matr1.h.
*/
