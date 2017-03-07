/*M
.SH NAME
putppf - put polynomial over p-adic field
(MACRO)

.SH SYNOPSIS
.nf
#include<_pol3.h>

single putppf(r, p, P, V)  
single r, p; 
pol P; 
list V;

.SH DESCRIPTION
.TP 4
.B p
is a prime number, p < BASIS.
.TP 4
.B r
is an integer number, 0 <= r < BASIS.
.TP 4
.B P
is a polynomial in r variables over the p-adic field Qp. Thereby, the coefficients of P are approximations of elements in Qp (s. itopfel). 
.TP 4
.B V
is a list, containing the variables names used by P (s. pmakevl).      
.PP
putppf writes P to stdout, the end of P will be marked with '#'.
putppf returns 0 by success and ERROR else.
                                    
.SH SEE ALSO
.nf
itopfel
pmakevl

M*/
      
/*H
	Version 1       07.11.1990      Christine Hollinger
	Version 2       12.06.1991      C.H.    r,p vertauscht
   DATE putppf        : 910915
H*/

#define         putppf( r, p, P, V )    fputppf( r, p, P, V, stdout )
