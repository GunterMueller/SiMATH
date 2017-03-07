/*M
.SH NAME
mamiev - matrix of modular integers, eigenvalues (MACRO)

.SH SYNOPSIS
.nf
#include<_matr2.h>

list mamiev(p, M)
int p;
matrix M;

.SH DESCRIPTION
mamiev() returns the list L=(EV1, ..., EVk) of eigenvalues of M.
The eigenvalues appear according to their algebraic multiplicity. 

.PP
.TP 4
.B p
must be prime.
.TP 4
.B M
is a square matrix over Z/pZ.

M*/

/*H
	Version 1	31.01.1992      Bernd Mayr
	Version 2	16.11.1992	NUM -> MADUMMY.  PS
	Version 3	18.11.94	Macro nur noch im Header definiert. MP
   DATE mamiev        : 920331.921130.941201
H*/
/*
	For the definition of mamiev please refer to the header file _matr2.h.
*/
