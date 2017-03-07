/*M
.SH NAME
pgf2neg - polynomial over Galois-field with characteristic 2 negation
(MACRO)

.SH SYNOPSIS
.nf
#include<_pol3.h>

pol pgf2neg(r, G, P)  
single r; 
obj G; 
pol P;
        
.SH DESCRIPTION
.TP 4
.B r
is an integer number, 0 < r < BASIS.
.TP 4
.B G
is an univariate, monic and irreducible polynomial over Z/2Z in special bit-representation (s.udpm2tosb).
.PP
Let n be the degree of G, then G can be seen as a generator of GF(2^n)
( Galois-field with characteristic 2 ).
.TP 4
.B P
is a polynomial in r variables over GF(2^n) with coefficients in spezial bit-representation.      
.PP
pgf2neg returns a polynomial over GF(2^n), say P1, where
.IP
P1 = - P.

.SH SEE ALSO
udpm2tosb

M*/

/*H
	Version 1	28.04.93	J.Schmitt
	Version 2	15.10.93	stand versehentlich in 'arith3.  PS
	Version 3	18.11.94	Macro nur noch im Header definiert. MP
   DATE pgf2neg       : 930531.931130.941201
H*/
/*
	For the definition of pgf2neg please refer to the header file _pol3.h.
*/
