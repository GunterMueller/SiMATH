/*M
.SH NAME
getppf - get polynomial over p-adic field
(MACRO)

.SH SYNOPSIS
.nf
#include<_pol3.h>

pol getppf(r, p, VL)  
single p, r; 
list VL; 

.SH DESCRIPTION
.TP 4
.B p
is a prime number, p < BASIS.
.TP 4
.B r
is an integer number, 0 <= r < BASIS.  
.TP 4
.B VL
is the list of variables names of lenght >= r (s. pmakevl).         
.PP
getppf reads a polynomials over Qp from stdin.
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
getppf returns the polynomial by success, ERROR else.
                                                                 
M*/
        
/*H
	Version 1       24.09.1990      Christine Hollinger
	Version 2       05.06.1991      C.H.  r, p vertauscht
   DATE getppf        : 910915.9301__
H*/

# define         getppf( r, p, V )      fgetppf( r, p, V, stdin )
