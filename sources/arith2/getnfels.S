/*M
.SH NAME
getnfels - get number field element, sparse representation
(MACRO)

.SH SYNOPSIS
.nf
#include<_arith2.h>

nfel getnfels(F, V)  
pol F; 
list V;

.SH DESCRIPTION
.TP 4
.B F
is an irreducible, univariate polynomial Q of degree > 1. F generates a number field, say K.
.TP 4
.B V
is a list of variables, V contains one element.
.PP
getnfels reads a univariate polynomial, say P, in the variable given in V, over Q from stdin. The polynomial will be reduced modulo F. By success, getnfel returns that element (in sparse representation) as an element of K and ERROR else. 

.SH SEE ALSO
fgetnfels
 
M*/
                      
/*H
	Version 1       16.06.1988      Pascale Serf
	Version 2       22.07.1988      nfel durch nfels ersetzt.  PS
	Version 3	18.11.94	Macro nur noch im Header definiert. MP
   DATE getnfels      : 890501.9011__.941201
H*/
/*
	For the definition of getnfels please refer to the header file _arith2.h.
*/
