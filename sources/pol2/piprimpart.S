/*M
.SH NAME
piprimpart - polynomial over integers primitive part

.SH SYNOPSIS
.nf
#include<_pol2.h>

pol piprimpart(r, P) 
single r; 
pol P;
 
.SH DESCRIPTION
.TP 4
.B r
is an integer number, 0 < r < BASIS.
.TP 4
.B P
is a polynomial in r variables over the integer numbers.
.PP
piprimpart returns the primitive part of the polynomial P with regard to the main variable.

M*/

/*H
	Version 1       03.11.1987      B. Weis
	Version 2	18.11.94	Macro nur noch im Header definiert. MP
   DATE piprimpart    : 890501.941201
H*/
/*
	For the definition of piprimpart please refer to the header file _pol2.h.
*/
