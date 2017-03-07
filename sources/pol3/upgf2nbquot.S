/*M
.SH NAME
upgf2nbquot - univariate polynomial over Galois-field of characteristic 2, coefficients in normal basis representation, quotient
(MACRO)
.SH SYNOPSIS
.nf
#include<_pol3.h>

pol upgf2nbquot(G, MT, P1, P2)  
obj G; 
list *MT; 
pol P1, P2;
 
.SH DESCRIPTION
.TP 4
.B G
is an irreducible monic polynomial in one variable
over Z/2Z of degree n in special bit representation
(see udpm2tosb) as generating polynomial of GF(2^n).
.TP 4
.B *MT
is a pointer on an array containing the multiplication
table of a normal element of GF(2^n) (s. gf2nbmt).
.TP 4
.B P1, P2
are polynomials in one variable over GF(2^n) in
special bit representation with coefficients represented
with respect to the normal basis of GF(2^n) with
multiplication table MT. P2 must not be equal to zero.
.PP       
upgf2nbquot returns a polynominomial, say P3, where
.IP
P3 = P1 / P2.
.PP
P3 is given in special bit notation with respect to the same
normal basis as P1 and P2.        

.SH SEE ALSO
.nf
udpm2tosb
gf2bnmt

M*/
           
/*H
	Version 1	04.11.1994	Josef Gebel
	Version 2	18.11.94	Macro nur noch im Header definiert. MP
   DATE upgf2nbquot   : 941201
H*/
/*
	For the definition of upgf2nbquot please refer to the header file _pol3.h.
*/
