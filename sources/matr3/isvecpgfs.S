/*M
.SH NAME
isvecpgfs - is vector of polynomials over Galois-field with single characteristic ? (MACRO)

.SH SYNOPSIS
.nf
#include<_matr3.h>

single isvecpgfs(r,p,AL,V)
obj r,p,AL,V;

.SH DESCRIPTION
isvecpgfs() returns 1 if V is in (GF(p^n)[x_1,...,x_r])^i and 0 otherwise.
.PP
.TP 4
.B p
must be prime.
.TP 4
.B  AL
= (G, AL1) is the arithmetic list of GF(p^n), see gfsalgen().
.TP 4
.B V
is the vector to be tested.

.SH SEE ALSO
gfsalgen
M*/






/*H
	Version 1       19.04.1990      Th. Weis
	Version 2	18.11.94	Macro nur noch im Header definiert. MP
   DATE isvecpgfs     : 910915.941201
H*/
/*
	For the definition of isvecpgfs please refer to the header file _matr3.h.
*/


