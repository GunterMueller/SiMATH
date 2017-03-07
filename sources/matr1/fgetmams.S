/*M
.SH NAME
fgetmams - file get matrix of modular singles (MACRO)

.SH SYNOPSIS
.nf
#include<_matr1.h>

matrix fgetmams(m, pf)
single m;
FILE *pf;

.SH DESCRIPTION
fgetmams() returns the matrix of singles reduced modulo m
read from the input file *pf or ERROR in case an error has occurred.

.PP
.TP 4
.B pf
is a pointer to the input file.

M*/








/*H
	Version 1       27.06.1988      Klaus Petry
	Version 2       02.11.1988      Klaus Petry     Macro
	Version 3	18.11.94	Macro nur noch im Header definiert. MP
   DATE fgetmams      : 890501.9203__.941201
H*/
/*
	For the definition of fgetmams please refer to the header file _matr1.h.
*/
