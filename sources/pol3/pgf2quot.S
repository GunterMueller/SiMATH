/*M
.SH NAME
pgf2quot - polynomial over Galois-field with characteristic 2 quotient
(MACRO)

.SH SYNOPSIS
.nf
#include<_pol3.h>

pol pgf2quot( r, G, P1, P2 )  
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
pgf2quot returns a polynomial over GF(2^n), say P3, where
.IP
P3 = P1 / P2.

.SH SEE ALSO
udpm2tosb

M*/          
                   
/*H
	Version 1	04.05.1993	Joachim Stein
	Version 2	18.11.94	Macro nur noch im Header definiert. MP
   DATE pgf2quot      : 931130.941201
H*/
/*
	For the definition of pgf2quot please refer to the header file _pol3.h.
*/
