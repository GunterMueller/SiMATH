/*M
.SH NAME
fputmarfmsp1 - file put matrix of rational functions over modular single primes,  transcendence degree 1 (MACRO)

.SH SYNOPSIS
.nf
#include<_matr3.h>

single fputmarfmsp1(p, M, VL, pf)
single p;
matrix M;
list VL;
FILE *pf;

.SH DESCRIPTION
fputmarfmsp1() writes the matrix M to the output file *pf
and returns 0 or ERROR in case an error has occurred.
.PP
.TP 4
.B p
must be prime.
.TP 4
.B M
is a matrix of rational functions in one variable over Z/pZ.
.TP 4
.B VL
is a list containing one variable.
.TP 4
.B pf
is a pointer to the output file.
M*/











/*H
	Version 1       29.05.1989      U. Schneiders, Th. Weis
	Version 2	18.11.94	Macro nur noch im Header definiert. MP
   DATE fputmarfmsp1  : 890801.9109__.941201
H*/
/*
	For the definition of fputmarfmsp1 please refer to the header file _matr3.h.
*/


