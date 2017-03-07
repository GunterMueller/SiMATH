/*M
.SH NAME
magfscons1 - matrix of Galois-field with single characteristic elements, construction 1 (MACRO)

.SH SYNOPSIS
.nf
#include<_matr2.h>

matrix magfscons1(p, AL, n)
single p;
list AL;
single n;

.SH DESCRIPTION
magfscons1() returns the n-dimensional unity matrix
over the Galois-field GF(p^n).

.PP
.TP 4
.B p
must be prime.
.TP 4
.B AL
= (G,AL1) is the arithmetic list of GF(p^n), see gfsalgen().
M*/



/*H
	Version 1       10.05.1990      Th. Weis
	Version 2	27.10.1993	auch im Header 3 Parameter
					(vorher nur 'n').  PS
	Version 3	18.11.94	Macro nur noch im Header definiert. MP
   DATE magfscons1    : 910915.931130.941201
H*/
/*
	For the definition of magfscons1 please refer to the header file _matr2.h.
*/
