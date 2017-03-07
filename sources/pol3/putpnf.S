/*M
.SH NAME
putpnf - put polynomial over number field
(MACRO)

.SH SYNOPSIS
.nf
#include<_pol3.h>

single putpnf(r, F, P, V, Vnf)  
single r; 
pol F, P; 
list V, Vnf;

.SH DESCRIPTION
.TP 4
.B r
is an integer number, 0 <= r < BASIS.
.TP 4
.B F
is an irreducible, univariate polynomial in dense representation over Z. F generates a number field, say K.
.TP 4
.B P
is a polynomial in r variables over K.  
.TP 4
.B V
is a list, containing the variables names used by P (s. pmakevl).
.TP 4
.B Vnf
is a list which contains one element, representing the name of a zero of F.
.PP
putpnf writes P to stdout, the end of P will be marked with '#'.
putpnf returns 0 by success and ERROR else.                         

.SH SEE ALSO
pmakevl

M*/
             
/*H
	Version 1       11.04.1991      A. Stein
	Version 2	18.11.94	Macro nur noch im Header definiert. MP
   DATE putpnf        : 910715.941201
H*/
/*
	For the definition of putpnf please refer to the header file _pol3.h.
*/
