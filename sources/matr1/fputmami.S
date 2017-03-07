/*M
.SH NAME
fputmami - file put matrix of modular integers (MACRO)

.SH SYNOPSIS
.nf
#include<_matr1.h>

single fputmami(m, M, pf)
int m;
matrix M;
FILE *pf;

.SH DESCRIPTION
fputmami() writes the matrix M to the output file *pf
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
	Version 1       31.01.1992      Bernd Mayr
	Version 2	18.11.94	Macro nur noch im Header definiert. MP
   DATE fputmami      : 920331.941201
H*/
/*
	For the definition of fputmami please refer to the header file _matr1.h.
*/
