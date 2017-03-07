/*M
.SH NAME
gf2neg - Galois-field with characteristic 2 negation

.SH SYNOPSIS
.nf
#include<_arith2.h>

gf2el gf2neg(G,a)  
obj G; 
gf2el a;

.SH DESCRIPTION
.TP 4
.B G
is an univariate, monic and irreducible polynomial over Z/2Z in special bit-representation (s.udpm2tosb).
.PP
Let n be the degree of G, then G can be seen as a generator of GF(2^n)
( Galois-field with characteristic 2 ).
.TP 4
.B a
is an elements of GF(2^n), represented as univariate polynomial over Z/2Z of degree < n in special bit-representation.
.PP 
gf2neg returns the additive inverse element of a (in GF(2^n)).

.SH SEE ALSO
udpm2tosb

M*/
                            
/*H
	Version 1       11.03.1992	A.Stein
	Version 2	18.11.94	Macro nur noch im Header definiert. MP
   DATE gf2neg        : 920331.941201
H*/
/*
	For the definition of gf2neg please refer to the header file _arith2.h.
*/
