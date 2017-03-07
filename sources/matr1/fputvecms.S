/*M
.SH NAME
fputvecms - file put vector of modular singles (MACRO)

.SH SYNOPSIS
.nf
#include<_matr1.h>

single fputvecms(m, V, pf)
single m;
vec V;
FILE *pf;

.SH DESCRIPTION
fputvecms() writes the vector V to the output file *pf
and returns 0 or ERROR in case an error has occurred.

.PP
.TP 4
.B V
is a vector over Z/mZ.
.TP 4
.B pf
is a pointer to the output file.
M*/



/*H
	Version 1       01.03.1988      U.Schneiders
	Version 2	18.11.94	Macro nur noch im Header definiert. MP
   DATE fputvecms     : 890601.9203__.941201
H*/
/*
	For the definition of fputvecms please refer to the header file _matr1.h.
*/
