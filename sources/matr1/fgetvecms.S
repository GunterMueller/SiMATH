/*M
.SH NAME
fgetvecms - file get vector of modular singles (MACRO)

.SH SYNOPSIS
.nf
#include<_matr1.h>

vec fgetvecms(m, pf)
single m;
FILE *pf;

.SH DESCRIPTION
fgetvecms() returns the vector of singles reduced modulo m
read from the input file *pf or ERROR in case an error has occurred.

.PP
.TP 4
.B pf
is a pointer to the input file.

M*/





/*H
	Version 1       27.02.1989      U.Schneiders
	Version 2	18.11.94	Macro nur noch im Header definiert. MP
   DATE fgetvecms     : 890601.9203__.941201
H*/
/*
	For the definition of fgetvecms please refer to the header file _matr1.h.
*/
