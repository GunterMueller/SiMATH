/*M
.SH NAME
putspfel - put special p-adic field element
(MACRO)

.SH SYNOPSIS
.nf
#include<_arith2.h>

pfel putspfel(p, a)  
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
putspfel writes a to stdout and returns 0 by success and ERROR else.     
a will be written in digits, with rising powers of p. The coefficients are separated by _ . The change from negative to non negative exponents will be marked by using . instead of _.
.SH NOTES
If the output as a expansion in a series is favoured , please use putpfel.

.SH SEE ALSO
 putpfel
 fputspfel
 itopfel

M*/

/*H
	Version 1       01.06.1990      Christine Hollinger
	Version 2	18.11.94	Macro nur noch im Header definiert. MP
   DATE putspfel      : 901120.9109__.941201
H*/
/*
	For the definition of putspfel please refer to the header file _arith2.h.
*/
