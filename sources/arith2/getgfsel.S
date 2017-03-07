/*M
.SH NAME
getgfsel - get Galois-field with single characteristic element
(MACRO)

.SH SYNOPSIS
.nf
#include<_arith2.h>

gfel getgfsel(p, AL, V)  
single p; 
list AL, V;

.SH DESCRIPTION
.TP 4
.B p
is a prime number, 1 < p < BASIS.
.TP 4
.B AL
= (G AL1) can be seen as an arithmetic list of GF(p^n), where n = lenght(AL1)+1 (s. gfsalgen), and G is an irreducible, monic and univariate polynomial over Z/pZ of degree >= 1.
.TP 4
.B V
is a list of variables, V contains one element.
.PP
getgfsel reads a univariate polynomial, say P, in the variable given in V, over Z from stdin.
The polynomial will be reduced modulo G and its coefficients modulo p. By success, getgfsel returns the polynomial as an element of GF(p^n) and ERROR else.
 
.SH SEE ALSO
 gfsalgen
 getgf2el
 fgetgfsel

M*/
                                    
/*H
	Version 1       03.09.1987              Pascale Serf
	Version 2       07.12.1987              Liste AL statt Pol. G    PS
	Version 3	18.11.94	Macro nur noch im Header definiert. MP
   DATE getgfsel      : 890501.941201
H*/
/*
	For the definition of getgfsel please refer to the header file _arith2.h.
*/
