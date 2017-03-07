/*M
.SH NAME
fgetvecr - file get vector of rational numbers (MACRO)

.SH SYNOPSIS
.nf
#include<_matr1.h>

vec fgetvecr(pf);
FILE *pf;

.SH DESCRIPTION
fgetvecr() returns the vector of rational numbers
read from the input file *pf or ERROR in case an error has occurred.

.PP
.TP 4
.B pf
is a pointer to the input file.

.SH SEE ALSO
fgetr
M*/

/*H
	Version 1       27.02.1989      U.Schneiders
	Version 2	18.11.94	Macro nur noch im Header definiert. MP
   DATE fgetvecr      : 890601.941201
H*/
/*
	For the definition of fgetvecr please refer to the header file _matr1.h.
*/
