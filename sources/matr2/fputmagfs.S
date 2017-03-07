/*M
.SH NAME
fputmagfs - file put matrix of Galois-field with single characteristic elements (MACRO)

.SH SYNOPSIS
.nf
#include<_matr2.h>

single fputmagfs(p, AL, M, VL, pf)
single p;
list AL,VL;
matrix M;
FILE *pf;

.SH DESCRIPTION
fputmagfs() writes the matrix M to the output file *pf
and returns 0 or ERROR in case an error has occurred.
.PP
.TP 4
.B p
must be prime.
.TP 4
.B AL
= (G,AL1) is the arithmetic list of GF(p^n), see gfsalgen().
.TP 4
.B M
is a matrix over GF(p^n).
.TP 4
.B VL
is a variable list of length 1.
.TP 4
.B pf
is a pointer to the output file.

.SH SEE ALSO
gfsalgen, fputgfsel
M*/


/*H
	Version 1       17.03.1990      Th. Weis
	Version 2	18.11.94	Macro nur noch im Header definiert. MP
   DATE fputmagfs     : 910915.941201
H*/
/*
	For the definition of fputmagfs please refer to the header file _matr2.h.
*/
