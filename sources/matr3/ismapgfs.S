/*M
.SH NAME
ismapgfs - is matrix of polynomials over Galois-field with single characteristic ? (MACRO)

.SH SYNOPSIS
.nf
#include<_matr3.h>

single ismapgfs(r,p,AL,M)
obj r,p,AL,M;

.SH DESCRIPTION
ismapgfs() returns 1 if M is in (GF(p^n)[x_1,...,x_r])^(i,j) and 0 otherwise.
.PP
.TP 4
.B p
must be prime.
.TP 4
.B  AL
= (G, AL1) is the arithmetic list of GF(p^n), see gfsalgen().
.TP 4
.B M
is the matrix to be tested.

.SH SEE ALSO
gfsalgen
M*/










/*H
	Version 1       26.04.1990      Th. Weis
	Version 2	18.11.94	Macro nur noch im Header definiert. MP
   DATE ismapgfs      : 910915.941201
H*/
/*
	For the definition of ismapgfs please refer to the header file _matr3.h.
*/


