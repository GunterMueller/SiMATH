/*M
.SH NAME
fgetvpgfs - file get vector of polynomials over Galois-field with single  characteristic (MACRO)

.SH SYNOPSIS
.nf
#include<_matr3.h>

vec fgetvpgfs(r, p, AL, VL, Vgfs, pf)
single r,p;
list AL,VL,Vgfs;
FILE *pf;

.SH DESCRIPTION
fgetvpgfs() returns the vector of polynomials in r variables over Z/pZ
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
is a variable list of length r.
.TP 4
.B Vgfs
is a variable list containing the name of a primitive
element of the field extension GF(p^n)/(Z/pZ).
.TP 4
.B pf
is a pointer to the input file.

.SH SEE ALSO
gfsalgen, fgetpgfs
M*/








/*H
	Version 1       17.03.1990      Th. Weis
	Version 2	18.11.94	Macro nur noch im Header definiert. MP
   DATE fgetvpgfs     : 910915.941201
H*/
/*
	For the definition of fgetvpgfs please refer to the header file _matr3.h.
*/


