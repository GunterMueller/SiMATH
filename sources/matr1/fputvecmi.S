/*M
.SH NAME
fputvecmi - file put vector of modular integers (MACRO)

.SH SYNOPSIS
.nf
#include<_matr1.h>

single fputvecmi(m, V, pf)
int m;
vec V;
FILE *pf;

.SH DESCRIPTION
fputvecmi() writes the vector V to the output file *pf
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
	Version 1       31.01.1992      Bernd Mayr
	Version 2	18.11.94	Macro nur noch im Header definiert. MP
   DATE fputvecmi     : 920331.941201
H*/
/*
	For the definition of fputvecmi please refer to the header file _matr1.h.
*/
