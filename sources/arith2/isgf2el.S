/*M
.SH NAME
isgf2el - is Galois-field with characteristic 2 element ?
(MACRO) 

.SH SYNOPSIS
.nf
#include<_arith2.h>

single isgf2el(G,a)  
obj G, a;

.SH DESCRIPTION
.TP 4
.B G
is an univariate, monic and irreducible polynomial over Z/2Z in special bit-representation (s.udpm2tosb).
.PP
Let n be the degree of G, then G can be seen as a generator of GF(2^n)
( Galois-field with characteristic 2 ). 
.PP
isgf2el returns 
.TP 4
1, 
if a can be seen as an element of GF(2^n), i.e. as univariate polynomial over Z/2Z of degree < n in special bit-representation, and 
.TP 4
0, 
else.

.SH SEE ALSO
udpm2tosb

M*/
                       
/*H
	Version 1       13.03.1992	A. Stein
	Version 2	18.11.94	Macro nur noch im Header definiert. MP
   DATE isgf2el       : 920331.941201
H*/
/*
	For the definition of isgf2el please refer to the header file _arith2.h.
*/
