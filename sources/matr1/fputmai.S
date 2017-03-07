/*M
.SH NAME
fputmai - file put matrix of integers (MACRO)

.SH SYNOPSIS
.nf
#include<_matr1.h>

single fputmai(M, pf)
matrix M;
FILE *pf;

.SH DESCRIPTION
fputmai() writes the matrix M to the output file *pf
and returns 0 or ERROR in case an error has occurred.

.PP
.TP 4
.B M
is a matrix of integers.
.TP 4
.B pf
is a pointer to the output file.
M*/
/*H
	Version 1       04.05.1988      Klaus Petry
	Version 2       03.11.1988      Klaus Petry     Macro
	Version 3	18.11.94	Macro nur noch im Header definiert. MP
   DATE fputmai       : 890501.9311__.941201
H*/
/*
	For the definition of fputmai please refer to the header file _matr1.h.
*/
