/*M
.SH NAME
putpfel - put p-adic field element
(MACRO)

.SH SYNOPSIS
.nf
#include<_arith2.h>

pfel putpfel(p, a)  
single p; 
pfel a;
 
.SH DESCRIPTION
.TP 4
.B p
is a single prime.
.TP 4
.B a
is the approximation of an element (say A) of the p-adic number field Qp (s.itopfel).  
.PP
putpfel writes a to stdout and returns 0 by success and ERROR else.

.SH NOTES
a will be writen as a expansion in a series, if the output in digits is favoured , please use putspfel.

.SH SEE ALSO
 itopfel
 fputpfel
 putspfel

M*/

/*H
	Version 1       30.05.1990      Christine Hollinger
	Version 2	18.11.94	Macro nur noch im Header definiert. MP
   DATE putpfel       : 901120.9109__.941201
H*/
/*
	For the definition of putpfel please refer to the header file _arith2.h.
*/
