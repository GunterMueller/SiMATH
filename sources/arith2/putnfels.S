/*M
.SH NAME
putnfels - put number field element, sparse representation
(MACRO)

.SH SYNOPSIS
.nf
#include<_arith2.h>

single putnfels(F,a,V)  
pol F; 
nfel a; 
list V;
     
.SH DESCRIPTION
.TP 4
.B F
is an irreducible, univariate polynomial over Q of degree > 1. F generates a number field, say K.
.TP 4
.B a
is an element of K, represented by a univariate sparse polynomial of degree < degree(F) over Q.
.TP 4
.B V
is a list of variables, V contains one element.
.PP
putnfels writes a to stdout and returns 0 by success and ERROR else.
     
.SH SEE ALSO
 fputnfels

M*/
          
/*H
	Version 1       16.06.1987      Pascale Serf
	Version 2       22.07.1988      nfel durch nfels ersetzt.  PS
	Version 3	18.11.94	Macro nur noch im Header definiert. MP
   DATE putnfels      : 890501.941201
H*/
/*
	For the definition of putnfels please refer to the header file _arith2.h.
*/
