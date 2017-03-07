/*M
.SH NAME
isvecgfs - is vector of Galois-field with single characteristic elements ? (MACRO)

.SH SYNOPSIS
.nf
#include<_matr2.h>

single isvecgfs(p, AL, A)
obj p,AL,A;

.SH DESCRIPTION
isvecgfs() returns 1 if V is a vector over GF(p^n) and 0 otherwise.
.TP 4
.B p
must be prime.
.TP 4
.B AL
= (G, AL1) is the arithmetic list of GF(p^n), see gfsalgen().
.TP 4
.B V
is the vector to be tested.
M*/


/*H
	Version 1       15.12.1988      Pascale Serf
	Version 2	18.11.94	Macro nur noch im Header definiert. MP
   DATE isvecgfs      : 890501.941201
H*/
/*
	For the definition of isvecgfs please refer to the header file _matr2.h.
*/
