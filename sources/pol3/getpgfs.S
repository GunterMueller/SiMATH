/*M
.SH NAME
getpgfs - get polynomial over Galois-field with single characteristic
(MACRO)

.SH SYNOPSIS
.nf
#include<_pol3.h>

pol getpgfs(r, p, AL, VL, Vgfs)  
single r, p; 
list AL; 
list VL, Vgfs;
 
.SH DESCRIPTION
.TP 4
.B r
is an integer number, 0 <= r < BASIS.
.TP 4
.B p
is a prime number, p < BASIS.
.TP 4
.B AL
= (G AL1) can be seen as an arithmetic list of GF(p^n), where n = lenght(AL1)+1 (s. gfsalgen).    
.TP 4
.B VL
is the list of variables names of lenght >= r (s. pmakevl).                    
.TP 4
.B Vgfs
is a list which contains one element, representing the name of a primitive element in GF(p^n)/(Z/pZ).     
.PP
getpgfs reads a polynomials over GF(p^n) from stdin
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
getpgfs returns the polynomial by success, ERROR else.
                                                     
M*/

/*H
	Version 1       06.04.1988      B. Weis
	Version 2	18.11.94	Macro nur noch im Header definiert. MP
   DATE getpgfs       : 890501.8908__.9301__.941201
H*/
/*
	For the definition of getpgfs please refer to the header file _pol3.h.
*/
