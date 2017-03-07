/*M
.SH NAME
getdipnfl - get distributive polynomial over number field list
(MACRO)

.SH SYNOPSIS
.nf
#include<_pol3.h>

list getdipnfl(r, F, VL, Vnf)  
single r; 
pol F; 
list VL, Vnf;
 
.SH DESCRIPTION
.TP 4
.B r
is an integer number, 0 <= r < BASIS.
.TP 4
.B F
is an irreducible, univariate polynomial in dense representation over Z. F generates a number field, say K.    
.TP 4
.B VL
is the list of variables names of lenght >= r (s. pmakevl).    
.TP 4
.B Vnf
is a list which contains one element, representing the name of a zero of F.
.PP
getdipnfl reads a list of distributive polynomials over F from stdin.
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
getdipnfl returns the list of distributive polynomials by success, ERROR else.

M*/                    
    
/*H
	Version 1       30.06.1993      Th. Weis
	Version 2	18.11.94	Macro nur noch im Header definiert. MP
   DATE getdipnfl     : 931130.941201
H*/
/*
	For the definition of getdipnfl please refer to the header file _pol3.h.
*/
