/*M
.SH NAME
fgetmanf - file get matrix of number field elements (MACRO)

.SH SYNOPSIS
.nf
#include<_matr2.h>

matrix fgetmanf(F, VL, pf)
pol F;
list VL;
FILE *pf;

.SH DESCRIPTION
fgetmanf() returns the matrix of elements of the number field generated by F,
read from the input file *pf or ERROR in case an error has occurred.

.PP
.TP 4
.B F
is an irreducible monic dense polynomial in one variable over Z.
.TP 4
.B VL
is a variable list of length 1.
.TP 4
.B pf
is a pointer to the input file.

.SH SEE ALSO
fgetnfel
M*/


/*H
	Version 1       17.03.1990      Th. Weis
	Version 2	18.11.94	Macro nur noch im Header definiert. MP
   DATE fgetmanf      : 910915.941201
H*/
/*
	For the definition of fgetmanf please refer to the header file _matr2.h.
*/
