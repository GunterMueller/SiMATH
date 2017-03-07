/*M
.SH NAME
putgf2el - put Galois-field with characteristic 2 element
(MACRO)

.SH SYNOPSIS
.nf
#include<_arith2.h>

single putgf2el(G,a,V)  
obj G; 
gf2el a; 
list V;

.SH DESCRIPTION
.TP 4
.B G
is an univariate, monic and irreducible polynomial over Z/2Z of degree >= 1, in special bit-representation (s.udpm2tosb).
.PP
Let n be the degree of G, then G can be seen as a generator of GF(2^n)
( Galois-field with characteristic 2 ).
.TP 4
.B a 
is an elements of GF(2^n), represented as univariate polynomial over Z/2Z of degree < n in special bit-representation.
.TP 4   
.B V 
is a list of variables, V contains one element.
.PP
putgf2el transforms a into sparse representation and writes it to stdout.
putgf2el returns 0 by success and ERROR else.

.SH SEE ALSO
fputgf2el

M*/
                 
/*H
	Version 1       11.03.1992	A.Stein
	Version 2	18.11.94	Macro nur noch im Header definiert. MP
   DATE putgf2el      : 920331.941201
H*/
/*
	For the definition of putgf2el please refer to the header file _arith2.h.
*/
