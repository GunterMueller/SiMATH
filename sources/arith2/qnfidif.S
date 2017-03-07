/*M
.SH NAME
qnfidif - quadratic number field element, integer, difference

.SH SYNOPSIS
.nf
#include<_arith2.h>

nfel qnfidif( D, a, b )  
int D, b; 
nfel a;
        
.SH DESCRIPTION
.TP 4
.B D
is a square free integer number, D != 0 or 1.
D defines the quadratic number field K (say), where K = Q(D^(1/2)). 
.TP 4
.B a
is an element of K (for representation of number field elements s. fputnfel).
.TP 4
.B b
is an integer number.
.PP
qnfidif returns an element of K, say c, where
.IP
c = a - b  ( as number field elements).
 
.SH SEE ALSO
fputnfel

M*/

/*H
	Version 1       22.05.1993      Josef Gebel
	Version 2	18.11.94	Macro nur noch im Header definiert. MP
   DATE qnfidif       : 931130.941201
H*/
/*
	For the definition of qnfidif please refer to the header file _arith2.h.
*/
