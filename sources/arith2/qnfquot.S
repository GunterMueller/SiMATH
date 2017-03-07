/*M
.SH NAME
qnfquot - quadratic number field element quotient

.SH SYNOPSIS
.nf
#include<_arith2.h>

nfel qnfquot( D, a, b )  
int D; 
nfel a, b;
 
.SH DESCRIPTION
.TP 4
.B D
is a square free integer number, D != 0 or 1.
D defines the quadratic number field K (say), where K = Q(D^(1/2)).
.TP 4
.B a, b
are elements of K (for representation of number field elements s. fputnfel). 
.PP
qnfquot returns ERROR if b = 0, else an element of K, say c, where
.IP
c = a / b.

.SH SEE ALSO
fputnfel

M*/
                                                      
/*H
	Version 1       24.05.1993      Josef Gebel
	Version 2	18.11.94	Macro nur noch im Header definiert. MP
   DATE qnfquot       : 931130.941201
H*/
/*
	For the definition of qnfquot please refer to the header file _arith2.h.
*/
