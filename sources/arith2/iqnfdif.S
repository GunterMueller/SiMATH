/*M
.SH NAME
iqnfdif - integer, quadratic number field element, difference
(MACRO)

.SH SYNOPSIS
.nf
#include<_arith2.h>

nfel iqnfdif(D, a, b)  
int D, a; 
nfel b;
   
.SH DESCRIPTION
.TP 4
.B D
is a square free integer number, D != 0 or 1.
D defines the quadratic number field K (say), where K = Q(D^(1/2)).
.TP 4
.B a 
is an integer number.
.TP 4
.B b
is an element of K (for representation of number field elements s. fputnfel).
.PP 
iqnfdif returns an element of K, say c, where
.IP 
c = a - b.
  
.SH SEE ALSO
fputnfel

M*/
                                           
/*H
	Version 1       22.05.1993      Josef Gebel
	Version 2	18.11.94	Macro nur noch im Header definiert. MP
   DATE iqnfdif       : 931130.941201
H*/
/*
	For the definition of iqnfdif please refer to the header file _arith2.h.
*/
