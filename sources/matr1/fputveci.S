/*M
.SH NAME
fputveci - file put vector of integers (MACRO)

.SH SYNOPSIS
.nf
#include<_matr1.h>

single fputveci(V, pf)
vec V;
FILE *pf;

.SH DESCRIPTION
fputveci() writes the vector V to the output file *pf
and returns 0 or ERROR in case an error has occurred.

.PP
.TP 4
.B V
is a vector of integers.
.TP 4
.B pf
is a pointer to the output file.
M*/



/*H
	Version 1       01.03.1989      U.Schneiders
	Version 2	18.11.94	Macro nur noch im Header definiert. MP
   DATE fputveci      : 890601.941201
H*/
/*
	For the definition of fputveci please refer to the header file _matr1.h.
*/
