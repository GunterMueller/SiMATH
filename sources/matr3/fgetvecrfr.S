/*M
.SH NAME
fgetvecrfr - file get vector of rational functions over the rational numbers (MACRO)

.SH SYNOPSIS
.nf
#include<_matr3.h>

vec fgetvecrfr(r, VL, pf)
single r;
list VL;
FILE *pf;

.SH DESCRIPTION
fgetvecrfr() returns the vector of rational functions in r variables over the rational numbers
read from the input file *pf or ERROR in case an error has occurred.
.PP
.TP 4
.B VL
is a list of r variables.
.TP 4
.B pf
is a pointer to the input file.
M*/






/*H
	Version 1       13.06.1989      U.Schneiders, Th. Weis
	Version 2	18.11.94	Macro nur noch im Header definiert. MP
   DATE fgetvecrfr    : 890801.9109__.941201
H*/
/*
	For the definition of fgetvecrfr please refer to the header file _matr3.h.
*/


