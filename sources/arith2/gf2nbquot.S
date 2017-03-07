/*M
.SH NAME
gf2nbquot - Galois-field of characteristic 2, normal basis, quotient

.SH SYNOPSIS
.nf
#include<_arith2.h>

gf2el gf2nbquot(G, MT, a, b)  
obj G; 
list *MT; 
gf2el a, b;
 
.SH DESCRIPTION
.TP 4
.B G
is an irreducible monic univariate polynomial over GF(2) of degree n > 1 with coefficients in special bit notation (see udpm2tosb). G is interpreted as a gener
ating polynomial of the field GF(2^n).
.TP 4
.B MT
is a pointer on an array that contains the multiplication table of a normal element of GF(2^n), see 'gf2nbmt'.
.TP 4
.B a, b
are elements in GF(2^n) represented in special bit notation with respect to the normal basis of GF(2^n) corresponding to MT, b != 0.
.PP
gf2nbquot returns an element of GF(2^n), say c, where
.IP
c = a / b.

.SH SEE ALSO
 udpm2tosb
 gf2nbmt
              
M*/
           
/*H
	Version 1	14.09.1994	Josef Gebel
	Version 2	18.11.94	Macro nur noch im Header definiert. MP
   DATE gf2nbquot     : 941201
H*/
/*
	For the definition of gf2nbquot please refer to the header file _arith2.h.
*/
