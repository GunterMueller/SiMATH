/*M
.SH NAME
fputmams - file put matrix of modular singles (MACRO)

.SH SYNOPSIS
.nf
#include<_matr1.h>

single fputmams(m, M, pf)
single m;
matrix M;
FILE *pf;

.SH DESCRIPTION
fputmams() writes the matrix M to the output file *pf
and returns 0 or ERROR in case an error has occurred.

.PP
.TP 4
.B M
is a matrix over Z/mZ.
.TP 4
.B pf
is a pointer to the output file.
M*/
/*H
	Version 1       02.08.1988      Klaus Petry
	Version 2       26.10.1988      Klaus Petry
	Version 3	18.11.94	Macro nur noch im Header definiert. MP
   DATE fputmams      : 890501.9203__.941201
H*/
/*
	For the definition of fputmams please refer to the header file _matr1.h.
*/
