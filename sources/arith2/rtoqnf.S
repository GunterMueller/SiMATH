/*M
.SH NAME
rtoqnf - rational number to quadratic number field element
(MACRO) 

.SH SYNOPSIS
.nf
#include<_arith2.h>

nfel rtoqnf(D, A)  
int D; 
rat A;  
.SH DESCRIPTION
.TP 4
.B D
is a square free integer number, D != 0 or 1.
D defines the quadratic number field K (say), where K = Q(D^(1/2)). 
.TP 4
.B A
is a rational number.
.PP
rtoqnf returns the representation of A as an element of K.

M*/

/*H
	Version 1       24.05.1993      Josef Gebel
	Version 2	18.11.94	Macro nur noch im Header definiert. MP
   DATE rtoqnf        : 931130.941201
H*/
/*
	For the definition of rtoqnf please refer to the header file _arith2.h.
*/
