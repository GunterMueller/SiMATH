/*M
.SH NAME
putpgf2 - put polynomial over Galois-field with characteristic 2
(MACRO)

.SH SYNOPSIS
.nf
#include<_pol3.h>

single putpgf2(r, G, P, V, Vgf2)  
single r; 
obj G; 
pol P;
list V, Vgf2;
   
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
.TP 4
.B V
is a list, containing the variables names used by P (s. pmakevl).
.TP 4
.B Vgf2
is a list which contains one element, representing the name of a primitive element in GF(2)/(Z/2Z).
.PP
putpgf2 writes P to stdout, the end of P will be marked with '#'.
putpgf2 returns 0 by success and ERROR else.
   
.SH SEE ALSO
udpm2tosb

M*/
   
/*H
	Version 1 	29.04.93	J.Schmitt
	Version 2	15.10.93	stand versehentlich in 'arith3.  PS
	Version 3	18.11.94	Macro nur noch im Header definiert. MP
   DATE putpgf2       : 930531.931130.941201
H*/
/*
	For the definition of putpgf2 please refer to the header file _pol3.h.
*/
