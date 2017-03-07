/*M
.SH NAME
getgf2el - get Galois-field with characteristic 2 element
(MACRO)

.SH SYNOPSIS
.nf
#include<_arith2.h>

gf2el getgf2el(G, V)  
obj G; 
list V;
 
.SH DESCRIPTION
.TP 4
.B G
is an univariate, monic and irreducible polynomial over Z/2Z of degree >= 1, in special bit-representation (s.udpm2tosb).
.PP
Let n be the degree of G, then G can be seen as a generator of GF(2^n)
( Galois-field with characteristic 2 ).  
.TP 4
.B V
is a list of variables, V contains one element.
.PP 
getgf2el reads a univariate polynomial, say P, in the variable given in V, over Z from stdin.
The coefficients of P will be reduced modulo 2. After that, P will be converted into special bit notation (s. udpm2tosb) and reduced modulo G. By success, getgf2el returns the polynomial as an element of GF(2^n) and ERROR else.

.SH SEE ALSO
 udpm2tosb
 fgetgf2el

M*/

/*H
	Version 1	11.03.1992	A.Stein   
	Version 2	18.11.94	Macro nur noch im Header definiert. MP
   DATE getgf2el      : 920331.941201
H*/
/*
	For the definition of getgf2el please refer to the header file _arith2.h.
*/
