/*M
.SH NAME
isqnfint - is quadratic number field element integer?
(MACRO)

.SH SYNOPSIS
.nf
#include<_arith2.h>

single isqnfint( D, a )  
int D; 
nfel a;
 
.SH DESCRIPTION
.TP 4
.B D
is a square free integer number, D != 0 or 1.
D defines the quadratic number field K (say), where K = Q(D^(1/2)).  
.TP 4
.B a 
is an element of K (for the representation of number field elements s. fputnfel).
.PP
isqnfint returns 
.TP 4
1,
if a is an integer number (a in Z), and
.TP 4
0,
else.

.SH SEE ALSO
fputnfel

M*/
                 
/*H
	Version 1       24.05.1993      Josef Gebel
	Version 2	18.11.94	Macro nur noch im Header definiert. MP
   DATE isqnfint      : 931130.941201
H*/
/*
	For the definition of isqnfint please refer to the header file _arith2.h.
*/
