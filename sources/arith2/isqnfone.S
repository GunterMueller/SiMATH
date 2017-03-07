/*M
.SH NAME
isqnfone - is quadratic number field element one?
(MACRO)

.SH SYNOPSIS
.nf
#include<_arith2.h>

single isqnfone( D, a )  
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
isqnfone returns
.TP 4
1,
if a is one, and
.TP 4
0,
else.

.SH SEE ALSO
fputnfel

M*/

/*H
	Version 1       22.05.1993      Josef Gebel
	Version 2	18.11.94	Macro nur noch im Header definiert. MP
   DATE isqnfone      : 931130.941201
H*/
/*
	For the definition of isqnfone please refer to the header file _arith2.h.
*/
