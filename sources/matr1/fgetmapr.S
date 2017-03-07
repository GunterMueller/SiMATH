/*M
.SH NAME
fgetmapr - file get matrix of polynomials over the rational numbers (MACRO)

.SH SYNOPSIS
.nf
#include<_matr1.h>

matrix fgetmapr(r, VL, pf)
single r;
list VL;
FILE *pf;

.SH DESCRIPTION
fgetmapr() returns the matrix of polynomials in r variables over the rational numbers
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
	Version 1       28.07.1988      Klaus Petry
	Version 2       02.11.1988      Klaus Petry     Macro
	Version 3	18.11.94	Macro nur noch im Header definiert. MP
   DATE fgetmapr      : 890501.941201
H*/
/*
	For the definition of fgetmapr please refer to the header file _matr1.h.
*/
