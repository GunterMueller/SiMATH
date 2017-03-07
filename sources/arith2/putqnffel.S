/*M
.SH NAME
putqnffel - put quadratic number field element factor exponent list
(MACRO)

.SH SYNOPSIS
.nf
#include<_arith2.h>

single putqnffel( D, L )  
int D; 
list L;
    
.SH DESCRIPTION
.TP 4
.B D
is a square free integer number, D != 0 or 1.
D defines the quadratic number field K (say), where K = Q(D^(1/2)).  
.TP 4
.B L
is a list, containing the factorization of a number field element into prime ideals (s. qnfielpifact).
.PP
putqnffel writes the content of L to stdout and returns 0 by success and ERROR else.
 
.SH SEE ALSO
qnfielpifact

M*/
                                
/*H
	Version 1       10.10.1993 	Josef Gebel
	Version 2	18.11.94	Macro nur noch im Header definiert. MP
   DATE putqnffel     : 931130.941201
H*/
/*
	For the definition of putqnffel please refer to the header file _arith2.h.
*/
