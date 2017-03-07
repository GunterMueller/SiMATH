/*M
.SH NAME
getpgf2 - get polynomial over Galois-field with characteristic 2
(MACRO)

.SH SYNOPSIS
.nf
#include<_pol3.h>

pol getpgf2(r, G, VL, Vgf2)  
single r; 
obj G; 
list VL, Vgf2;
  
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
.B VL
is the list of variables names of lenght >= r (s. pmakevl).         
.TP 4
.B Vgf2
is a list which contains one element, representing the name of a primitive element in GF(2)/(Z/2Z).
.PP                                                                            
getpgf2 reads a polynomials over GF(2^n) from stdin.
.TP 4
Following rules must be considered:
 1. The end of the polynomial must be marked with '#'.
 2. Only positive exponents are allowed. They must be
    marked by the prefix '^' or '**'. The input of the
    powers 1 or 0 is not necessary, but in the second
    case, the input of the according variable had to
    remain undone too.
 3. Coefficients of any size are allowed. The
    coefficient and its sign can be seperated by
    blanks, the coefficient and the according              
    variables can be seperated by any blanks and/or
    '*'. These seperations are not necessary. The
    input of the coefficient 1 is not necessary.
 4. Variable names must be mentioned in VL, they are
    not allowed to be seperated by special
    characters.
    Single variables and its exponents can be
    seperated to other variables by any blanks and/or
    '*'. This seperation is only necessary if no
    exponent was specified.
 5. Appears a variable in a single monomial more than
    once, the several occurances will be merged.
    Appears a monomial more than once, the several
    occurances will be merged.
.PP
getpgf2 returns the polynomial by success, ERROR else.

M*/                                                          
        
/*H
	Version 1	29.04.1993	J.Schmitt
	Version 2	15.10.1993	stand versehentlich in 'arith3.  PS
	Version 3	18.11.94	Macro nur noch im Header definiert. MP
   DATE getpgf2	      : 930531.931130.941201
H*/
/*
	For the definition of getpgf2 please refer to the header file _pol3.h.
*/
