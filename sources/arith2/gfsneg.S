/*M
.SH NAME
gfsneg - Galois-field with single characteristic negation

.SH SYNOPSIS
.nf
#include<_arith2.h>

gfel gfsneg(p, AL, a)  
single p;   
list AL;  
gfel a;

.SH DESCRIPTION
.TP 4
.B p
is a prime number.
.TP 4
.B AL
= (G AL1) can be seen as an arithmetic list of GF(p^n), where n = lenght(AL1)+1 (s. gfsalgen).
.TP 4
.B a
is an element in GF(p^n), represented as univariate polynomial over Z/pZ of degree < n.
.PP 
gfsneg returns the additive inverse element of a in GF(p^n).
 
.SH SEE ALSO
gfsalgen

M*/
                                
/*H
	Version 1       17.08.1987              Pascale Serf
	Version 2       07.12.1987              Liste AL statt Pol. G    PS
	Version 3	18.11.94	Macro nur noch im Header definiert. MP
   DATE gfsneg        : 890501.941201
H*/
/*
	For the definition of gfsneg please refer to the header file _arith2.h.
*/
