/*M
.SH NAME
mapgfscons1 - matrix of polynomials over Galois-field with single characteristic, construction 1 (MACRO)

.SH SYNOPSIS
.nf
#include<_matr3.h>

matrix mapgfscons1(r, p, AL, n)
single r,p;
list AL;
single n;

.SH DESCRIPTION
mapgfscons1() returns the n-dimensional unity matrix of
polynomials in r variables over GF(p^n).

.PP
.TP 4
.B p
must be prime.
.TP 4
.B AL
= (G,AL1) is the arithmetic list of GF(p^n), see gfsalgen().
M*/




/*H
	Version 1       16.05.1990      Th. Weis
	Version 2	18.11.94	Macro nur noch im Header definiert. MP
   DATE mapgfscons1   : 910915.941201
H*/
/*
	For the definition of mapgfscons1 please refer to the header file _matr3.h.
*/


