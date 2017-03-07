/*M
.SH NAME
pgf2rem - polynomial over Galois-field with characteristic 2 remainder
(MACRO)

.SH SYNOPSIS
.nf
#include<_pol3.h>

pol pgf2rem(r, G, P1, P2)  
single r; 
obj G; 
pol P1, P2;

.SH DESCRIPTION
.TP 4
.B r
is an integer number, 0 <= r < BASIS.
.TP 4
.B G
is an univariate, monic and irreducible polynomial over Z/2Z in special bit-representation (s.udpm2tosb).
.PP
Let n be the degree of G, then G can be seen as a generator of GF(2^n)
( Galois-field with characteristic 2 ).
.TP 4
.B P1, P2
are polynomials in r variables over GF(2^n) with coefficients in spezial bit-representation, P2 != 0.
.PP                                                                   
pgf2rem returns the remainder of the division of P1 by P2.

.SH SEE ALSO
.nf
udpm2tosb
pgf2qrem

M*/
                                
/*H
	Version 1	21.05.1993	Joachim Stein
	Version 2	18.11.94	Macro nur noch im Header definiert. MP
   DATE pgf2rem       : 931130.941201
H*/
/*
	For the definition of pgf2rem please refer to the header file _pol3.h.
*/
