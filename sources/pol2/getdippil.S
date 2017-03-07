/*M
.SH NAME
getdippil - get distributive polynomial over polynomials over integers list

.SH SYNOPSIS
.nf
#include<_pol2.h>

list getdippil(r1, r2, VL1, VL2)  
single r1, r2; 
list VL1, VL2; 
 
.SH DESCRIPTION
.TP 4
.B r1, r2
are integer numbers, 0 <= r1,r2 < BASIS.     
.PP
Let R2 be a ring of polynomials in r2 variables over the integer numbers, and
R1 be a ring of polynomials in r1 variables over R2.
.TP 4
.B VL1, VL2
are lists of lenght r1 resp. r2, containing the variables names used by the polynomials in R1 resp. R2.
.PP
getdippil reads a list of distributive polynomials in R2 from stdin. 
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
 4. Variable names must be mentioned in V, they are
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
 6. The monomials will be sorted according to the
    term order defined by the value of EVORD.


    Following values can occur:
    EVORD = 1 : lexicographical order,
          = 2 : graduated lexicographical order,
          = 3 : total degree ordering,
          = 4 : lexicographical order with inverse
                exponent vector.
    Default is EVORD = 1.
 7. The list of polynomials must beginn with '{'
    and end with '}'. The several polynomials must be
    seperated by commas.
.PP
getdippil returns the list of distributive polynomials by success, ERROR else.
 
M*/
      
/*H
	Version 1       10.05.1993      Th. Weis
	Version 2	18.11.94	Macro nur noch im Header definiert. MP
   DATE getdippil     : 930531.941201
H*/
/*
	For the definition of getdippil please refer to the header file _pol2.h.
*/
