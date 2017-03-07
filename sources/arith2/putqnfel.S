/*M
.SH NAME
putqnfel - put quadratic number field element
(MACRO)     

.SH SYNOPSIS
.nf
#include<_arith2.h>

single putqnfel( D, a )  
int D; 
nfel a;
  
.SH DESCRIPTION
.TP 4
.B D
is a square free integer number, D != 0 or 1.
D defines the quadratic number field K (say), where K = Q(D^(1/2)).
.TP 4
.B a
is an element of K ( for representation of number field elements s. fputnfel ).
.PP
putqnfel writes a to stdout and returns 0 by success and ERROR else.

.SH SEE ALSO
 fputqnfel

M*/
                              
/*H
	Version 1       25.05.1993      Josef Gebel
	Version 2	18.11.94	Macro nur noch im Header definiert. MP
   DATE putqnfel      : 931130.941201
H*/
/*
	For the definition of putqnfel please refer to the header file _arith2.h.
*/
