/*M
.SH NAME
fgetmapms - file get matrix of polynomials over modular singles (MACRO)

.SH SYNOPSIS
.nf
#include<_matr1.h>

matrix fgetmapms(r, m, VL, pf)
single r, m;
list VL;
FILE *pf;

.SH DESCRIPTION
fgetmapms() returns the matrix of polynomials in r variables over Z/mZ
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
fgetpms
M*/

/*H
	Version 1       02.11.1988      Klaus Petry
	Version 2	18.11.94	Macro nur noch im Header definiert. MP
   DATE fgetmapms     : 890501.9203__.941201
H*/
/*
	For the definition of fgetmapms please refer to the header file _matr1.h.
*/
