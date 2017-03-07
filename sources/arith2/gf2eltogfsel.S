/*M
.SH NAME
gf2eltogfsel - Galois-field with characteristic 2 element to Galois-field with single characteristic element

.SH SYNOPSIS
.nf
#include<_arith2.h>

gfel gf2eltogfsel(G, b)  
obj G; 
gf2el b;
 
.SH DESCRIPTION
.TP 4
.B G
is an univariate, monic and irreducible polynomial over Z/2Z in special bit-representation (s.udpm2tosb).
.PP
Let n be the degree of G, then G can be seen as a generator of GF(2^n)
( Galois-field with characteristic 2 ).
.TP 4
.B b
is an elements of GF(2^n), represented as univariate polynomial over Z/2Z of degree < n in special bit-representation.
.PP
gf2eltogfsel returns the representation of b as a sparse polynomial over Z/2Z. 

.SH SEE ALSO
udpm2tosb

M*/
                                 
/*H
	Version  1      19.05.1993      S.Schmitt
	Version 2	18.11.94	Macro nur noch im Header definiert. MP
   DATE gf2eltogfsel  : 931130.941201
H*/
/*
	For the definition of gf2eltogfsel please refer to the header file _arith2.h.
*/
