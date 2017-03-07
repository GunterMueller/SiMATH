/*M
.SH NAME
putqnfid - put quadratic number field ideal
(MACRO)

.SH SYNOPSIS
.nf
#include<_arith2.h>

single putqnfid( D, A )  
int D; 
list A;

.SH DESCRIPTION
.TP 4
.B D
is a square free integer number, D != 0 or 1.
D defines the quadratic number field K (say), where K = Q(D^(1/2)).  
.TP 4
.B A
is an ideal in the ring of integers, say O_K, of K (for the representation of ideals s. qnfidprod).
.PP
putqnfid writes A to stdout and returns 0 by success or ERROR else.
.SH NOTES
An ideal A = (a b c d) will be outputed in the following way:
.PP
(0) for A being the zero ideal,
.PP
[b/s, (c+D^(1/2))/s],     for a == 1,
.PP
{(a)[b/s, (c+D^(1/2))/s]} else.     
.SH SEE ALSO
qnfidprod

M*/
                                        
/*H
	Version 1       10.10.1993	Josef Gebel
	Version 2	18.11.94	Macro nur noch im Header definiert. MP
   DATE putqnfid      : 931130.941201
H*/
/*
	For the definition of putqnfid please refer to the header file _arith2.h.
*/
