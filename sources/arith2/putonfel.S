/*M
.SH NAME
putonfel - put original number field element
(MACRO)  

.SH SYNOPSIS
.nf
#include<_arith2.h>

single putonfel( F, a, V )     
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
putonfel writes a to stdout and returns 0 by success and ERROR else.

.SH NOTES
A more predictable but slower output of a is given by putnfel.

.SH SEE ALSO
 fputonfel
 putnfel
 nfneg

M*/
                 
/*H
	Version 1       15.03.1989      Christine Hollinger
	Version 2       24.10.1990      C.H.    ( Placebo F )
	Version 3	18.11.94	Macro nur noch im Header definiert. MP
   DATE putonfel      : 890601.901120.941201
H*/
/*
	For the definition of putonfel please refer to the header file _arith2.h.
*/
