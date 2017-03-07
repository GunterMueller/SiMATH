/*M
.SH NAME
getnfel - get number field element
(MACRO)

.SH SYNOPSIS
.nf
#include<_arith2.h>

nfel getnfel(F, V)     
pol F; 
list V;
  
.SH DESCRIPTION
.TP 4
.B F
is an irreducible, univariate polynomial in dense representation over Z of degree > 1. F generates a number field, say K. 
.TP 4
.B V
is a list of variables, V contains one element.     
.PP
getnfel  reads a univariate polynomial, say P, in the variable given in V, over Q from stdin. The polynomial will be reduced modulo F and konverted into an element of K. By success, getnfel returns that element and ERROR else.

.SH SEE ALSO
 fgetnfel

M*/
        
/*H
	Version 1       22.03.1989      Christine Hollinger
	Version 2	18.11.94	Macro nur noch im Header definiert. MP
   DATE getnfel       : 890601.9011__.941201
H*/
/*
	For the definition of getnfel please refer to the header file _arith2.h.
*/
