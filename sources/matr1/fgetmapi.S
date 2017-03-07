/*M
.SH NAME
fgetmapi - file get matrix of polynomials over integers (MACRO)

.SH SYNOPSIS
.nf
#include<_matr1.h>

matrix fgetmapi(r, VL, pf)
single r;
list VL;
FILE *pf;

.SH DESCRIPTION
fgetmapi() returns the matrix of polynomials in r variables over integers
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
fgetpi
M*/








/*H
	Version 1       03.07.1988      Klaus Petry
	Version 2       02.11.1988      Klaus Petry     Macro
	Version 3	18.11.94	Macro nur noch im Header definiert. MP
   DATE fgetmapi      : 890501.941201
H*/
/*
	For the definition of fgetmapi please refer to the header file _matr1.h.
*/
