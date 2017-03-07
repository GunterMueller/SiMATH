/*M
.SH NAME
fgetvecmi - file get vector of modular integers (MACRO)

.SH SYNOPSIS
.nf
#include<_matr1.h>

vec fgetvecmi(m, pf)
int m;
FILE *pf;

.SH DESCRIPTION
fgetvecmi() returns the vector of integers reduced modulo m
read from the input file *pf or ERROR in case an error has occurred.

.PP
.TP 4
.B pf
is a pointer to the input file.
M*/








/*H
	Version 1       31.01.1992      Bernd Mayr
	Version 2	18.11.94	Macro nur noch im Header definiert. MP
   DATE fgetvecmi     : 920331.941201
H*/
/*
	For the definition of fgetvecmi please refer to the header file _matr1.h.
*/
