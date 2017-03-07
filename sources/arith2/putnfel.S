/*M
.SH NAME
putnfel - put number field element
(MACRO) 

.SH SYNOPSIS
.nf
#include<_arith2.h>

single putnfel( F, a, V )       
pol F; 
nfel a; 
list V;
     
.SH DESCRIPTION
.TP 4
.B F
is an irreducible, univariate polynomial in dense representation over Z of degree > 1. F generates a number field, say K.
.TP 4
.B a
is an element of K (for representation of number field elements s. nfneg). 
.TP 4
.B V
is a list of variables, V contains one element.       
.PP
putnfel writes a with fractions in their lowest terms as coefficients to stdout and returns 0 by success and ERROR else.

.SH NOTES
A faster, but more complicated output for a != 0 is given by putonfel.
 
.SH SEE ALSO
 fputnfel
 putonfel
 nfneg

M*/

/*H
	Version 1       15.03.1989      Christine Hollinger
	Version 2       24.10.1990      C.H.    ( Placeo F )
	Version 3	18.11.94	Macro nur noch im Header definiert. MP
   DATE putnfel       : 890601.901120.941201
H*/
/*
	For the definition of putnfel please refer to the header file _arith2.h.
*/
