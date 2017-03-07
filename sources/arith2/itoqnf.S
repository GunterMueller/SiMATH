/*M
.SH NAME
itoqnf - integer to quadratic number field element
(MACRO)

.SH SYNOPSIS
.nf
#include<_arith2.h>

nfel itoqnf(D, a)  
int D, a;
  
.SH DESCRIPTION
.TP 4
.B D
is a square free integer number, D != 0 or 1.
D defines the quadratic number field K (say), where K = Q(D^(1/2)).
.TP 4
.B a
is an integer number.
.PP
itoqnf returns the representation of a as an element of K
(for representation of number field elements s. fputnfel).

.SH SEE ALSO
fputnfel

M*/
                                
/*H
	Version 1       24.05.1993      Josef Gebel
	Version 2	18.11.94	Macro nur noch im Header definiert. MP
   DATE itoqnf        : 931130.941201
H*/
/*
	For the definition of itoqnf please refer to the header file _arith2.h.
*/
