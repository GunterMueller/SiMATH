/*M
.SH NAME
fgetvecpms - file get vector of polynomials over modular singles (MACRO)

.SH SYNOPSIS
.nf
#include<_matr1.h>

vec fgetvecpms(r, m, VL, pf)
single r, m;
list VL;
FILE *pf;

.SH DESCRIPTION
fgetvecpms() returns the vector of polynomials in r variables over Z/mZ
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
	Version 1       27.02.1989      U.Schneiders
	Version 2	18.11.94	Macro nur noch im Header definiert. MP
   DATE fgetvecpms    : 890601.9011__.9203__.941201
H*/
/*
	For the definition of fgetvecpms please refer to the header file _matr1.h.
*/
