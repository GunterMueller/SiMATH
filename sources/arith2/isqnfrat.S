/*M
.SH NAME
isqnfrat - is quadratic number field element rational
(MACRO) 
 
.SH SYNOPSIS
.nf
#include<_arith2.h>

single isqnfrat(D, a)  
int D; 
nfel a;

.SH DESCRIPTION
.TP 4
.B D
is a square free integer number, D != 0 or 1.
.PP
Let K = Q(D^(1/2)) be a quadratic number field.
.TP 4
. B a
is an element of K (for representation of number field elements s. fputnfel).
.PP
isqnfrat returns
.TP 4
1,
if a represents a rational number, and
.TP 4
0,
else.

.SH SEE ALSO
fputnfel

M*/
                     
/*H
	Version 1       20.05.1993	Josef Gebel
	Version 2	18.11.94	Macro nur noch im Header definiert. MP
   DATE isqnfrat      : 931130.941201
H*/
/*
	For the definition of isqnfrat please refer to the header file _arith2.h.
*/
