/*M
.SH NAME
getqnfel - get quadratic number field element
(MACRO)

.SH SYNOPSIS
.nf
#include<_arith2.h>

nfel getqnfel(D)  
int D;

.SH DESCRIPTION
.TP 4
.B D
is a square free integer number, D != 0 or 1.
D defines the quadratic number field K (say), where K = Q(D^(1/2)).  
.PP
getqnfel reads an element of K from stdin and returns it as an element of type nfel, or ERROR in case of an error occurs (for representation of number field elements s. fputnfel).
.PP
Following inputs are allowed:
  a1, a1/aN, (a1 a2), (a1/aN a2), (a1 a2/aN), 
  (a1/aN a2/aN), (aN 0 a1), (aN 1 a2 a1) 
  with integer numbers a1, a2 aN.

.SH SEE ALSO
 fputnfel
 fgetnfel

M*/
                      
/*H
	Version 1       25.05.1993      Josef Gebel
	Version 2	18.11.94	Macro nur noch im Header definiert. MP
   DATE getqnfel      : 931130.941201
H*/
/*
	For the definition of getqnfel please refer to the header file _arith2.h.
*/
