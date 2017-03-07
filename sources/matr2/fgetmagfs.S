/*M
.SH NAME
fgetmagfs - file get matrix of Galois-field with single characteristic elements (MACRO)

.SH SYNOPSIS
.nf
#include<_matr2.h>

matrix fgetmagfs(p, AL, VL, pf)
single p;
list AL,VL;
FILE *pf;

.SH DESCRIPTION
fgetmagfs() returns the matrix of elements of GF(p^n),
read from the input file *pf or ERROR in case an error has occurred.

.PP
.TP 4
.B p
must be prime.
.TP 4
.B AL
= (G,AL1) is the arithmetic list of GF(p^n), see gfsalgen().
.TP 4
.B VL
is a variable list of length 1.
.TP 4
.B pf
is a pointer to the input file.


.SH SEE ALSO
gfsalgen, fgetgfsel
M*/


/*H
	Version 1       17.03.1990      Th. Weis
	Version 2	18.11.94	Macro nur noch im Header definiert. MP
   DATE fgetmagfs     : 910915.941201
H*/
/*
	For the definition of fgetmagfs please refer to the header file _matr2.h.
*/
