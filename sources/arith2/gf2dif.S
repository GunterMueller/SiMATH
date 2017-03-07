/*M
.SH NAME
gf2dif - Galois-field with characteristic 2 difference

.SH SYNOPSIS
.nf
#include<_arith2.h>

gf2el gf2dif(G, a, b)  
obj G; 
gf2el a, b;

.SH DESCRIPTION
.TP 4
.B G
is an univariate, monic and irreducible polynomial over Z/2Z in special bit-representation (s.udpm2tosb).  
.PP
Let n be the degree of G, then G can be seen as a generator of GF(2^n)
( Galois-field with characteristic 2 ).
.TP 4 
.B a, b
are elements of GF(2^n), represented as univariate polynomials over Z/2Z of degree < n in special bit-representation. 
.PP
gfsdif returns an element of GF(2^n), say c, where
.IP
c = a - b.

.SH SEE ALSO
udpm2tosb

M*/
                     
/*H
	Version 1       11.03.1992	A.Stein
	Version 2	18.11.94	Macro nur noch im Header definiert. MP
   DATE gf2dif        : 920331.941201
H*/
/*
	For the definition of gf2dif please refer to the header file _arith2.h.
*/
