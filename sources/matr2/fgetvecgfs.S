/*M
.SH NAME
fgetvecgfs - file get vector of Galois-field with single characteristic elements (MACRO)

.SH SYNOPSIS
.nf
#include<_matr2.h>

vec fgetvecgfs(p, AL,V L, pf)
single p;
list AL,VL;
FILE *pf;

.SH DESCRIPTION
fgetvecgfs() returns the vector of elements of GF(p^n),
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
   DATE fgetvecgfs    : 910915.941201
H*/
/*
	For the definition of fgetvecgfs please refer to the header file _matr2.h.
*/
