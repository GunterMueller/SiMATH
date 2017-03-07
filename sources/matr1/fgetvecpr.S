/*M
.SH NAME
fgetvecpr - file get vector of polynomials over the rational numbers (MACRO)

.SH SYNOPSIS
.nf
#include<_matr1.h>

vec fgetvecpr(r, VL, pf)
single r;
list VL;
FILE *pf;

.SH DESCRIPTION
fgetvecpr() returns the vector of polynomials in r variables over the rational numbers
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
fgetpr
M*/






/*H
	Version 1       27.02.1989      U.Schneiders
	Version 2	18.11.94	Macro nur noch im Header definiert. MP
   DATE fgetvecpr     : 890601.941201
H*/
/*
	For the definition of fgetvecpr please refer to the header file _matr1.h.
*/
