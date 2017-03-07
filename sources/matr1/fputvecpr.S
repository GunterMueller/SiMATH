/*M
.SH NAME
fputvecpr - file put vector of polynomials over the rational numbers (MACRO)

.SH SYNOPSIS
.nf
#include<_matr1.h>

single fputvecpr(r, V, VL, pf)
single r;
vec V;
list VL;
FILE *pf;

.SH DESCRIPTION
fputvecpr() writes the vector V to the output file *pf
and returns 0 or ERROR in case an error has occurred.


.PP
.TP 4
.B r
is the number of variables.
.TP 4
.B V
is a vector of polynomials in r variables over Z/mZ.
.TP 4
.B VL
is the variable list of the polynomials.
.TP 4
.B pf
is a pointer to the output file.
M*/



/*H
	Version 1       01.03.1988      U.Schneiders
	Version 2	18.11.94	Macro nur noch im Header definiert. MP
   DATE fputvecpr     : 890601.941201
H*/
/*
	For the definition of fputvecpr please refer to the header file _matr1.h.
*/
