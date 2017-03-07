/*M
.SH NAME
fputvecrfr - file put vector of rational functions over the rational numbers (MACRO)

.SH SYNOPSIS
.nf
#include<_matr3.h>

single fputvecrfr(r, V, VL, pf)
single r;
vec V;
list VL;
FILE *pf;

.SH DESCRIPTION
fputvecrfr() writes the vector V to the output file *pf
and returns 0 or ERROR in case an error has occurred.
.PP
.TP 4
.B V
is a vector of rational functions in r variables over the rational numbers.
.TP 4
.B VL
is a list of r variables.
.TP 4
.B pf
is a pointer to the output file.

.SH SEE ALSO
fputrfr
M*/






/*H
	Version 1       13.06.1989      U.Schneiders, Th. Weis
	Version 2	18.11.94	Macro nur noch im Header definiert. MP
   DATE fputvecrfr    : 890801.9109__.941201
H*/
/*
	For the definition of fputvecrfr please refer to the header file _matr3.h.
*/


