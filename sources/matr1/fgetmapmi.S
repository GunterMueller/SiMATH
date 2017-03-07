/*M
.SH NAME
fgetmapmi - file get matrix of polynomials over modular integers (MACRO)

.SH SYNOPSIS
.nf
#include<_matr1.h>

matrix fgetmapmi(r, m, VL, pf)
single r;
int m;
list VL;
FILE *pf;

.SH DESCRIPTION
fgetmapmi() returns the matrix of polynomials in r variables over Z/mZ
read from the input file *pf or ERROR in case an error has occurred.

.PP
.TP 4
.B r
is the number of variables.
.TP 4
.B VL
is the variable list of the polynomials.
.TP 4
.B pf
is a pointer to the input file.

.SH SEE ALSO
fgetpmi
M*/







/*H
	Version 1       31.01.1992      Bernd Mayr
	Version 2	18.11.94	Macro nur noch im Header definiert. MP
   DATE fgetmapmi     : 920331.941201
H*/
/*
	For the definition of fgetmapmi please refer to the header file _matr1.h.
*/
