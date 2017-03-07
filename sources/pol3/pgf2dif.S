/*M
.SH NAME
pgf2dif - polynomial over Galois-field with characteristic 2 difference
(MACRO)

.SH SYNOPSIS
.nf
#include<_pol3.h>

pol pgf2dif(r, G, P1, P2)  
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
are polynomials in r variables over GF(2^n) with coefficients in spezial bit-representation.
.PP
pgf2dif returns a polynomial, say P3, over GF(2^n), where
.IP
P3 = P1 - P2.
    
.SH SEE ALSO
udpm2tosb

M*/
         
/*H
	Version 1	28.04.93	J.Schmitt
	Version 2	15.10.93	stand versehentlich in 'arith3.  PS
	Version 3	18.11.94	Macro nur noch im Header definiert. MP
   DATE pgf2dif       : 930531.931130.941201
H*/
/*
	For the definition of pgf2dif please refer to the header file _pol3.h.
*/
