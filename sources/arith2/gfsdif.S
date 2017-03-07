/*M
.SH NAME
gfsdif - Galois-field with single characteristic difference

.SH SYNOPSIS
.nf
#include<_arith2.h>

gfel gfsdif(p, AL, a, b)  
single p;  
list AL;  
gfel a, b;

.SH DESCRIPTION
.TP 4
.B p
is a prime number.
.TP 4
.B AL
= (G AL1) can be seen as an arithmetic list of GF(p^n), where n = lenght(AL1)+1 (s. gfsalgen).
.TP 4
.B a, b
are elements in GF(p^n), represented as univariate polynomials over Z/pZ of degree < n.
.PP
gfsdif returns an element of GF(p^n), say c, where
.IP
c = a - b.

.SH SEE ALSO
gfsalgen

M*/
                                 
/*H
	Version 1       17.08.1987              Pascale Serf
	Version 2       07.12.1987              Liste AL statt Pol. G    PS
	Version 3	18.11.94	Macro nur noch im Header definiert. MP
   DATE gfsdif        : 890501.941201
H*/
/*
	For the definition of gfsdif please refer to the header file _arith2.h.
*/
