/*M
.SH NAME
putgfsel - put Galois-field with single characteristic element
(MACRO)

.SH SYNOPSIS
.nf
#include<_arith2.h>

single putgfsel(p, AL, a, V)  
single p; 
list AL, V; 
gfel a;
 
.SH DESCRIPTION
.TP 4
.B p
is a prime number, 1 < p < BASIS.
.TP 4
.B AL
= (G AL1) can be seen as an arithmetic list of GF(p^n), where n = lenght(AL1)+1 (s. gfsalgen).
.TP 4
.B a
is an element of GF(p^n).  
.TP 4
.B V
is a list of variables, V contains one element.   
.PP
putgfsel writes a to stdout and returns 0 by success and ERROR else.

.SH SEE ALSO
 fputgfsel
 gfsalgen

M*/
                       
/*H
	Version 1       03.09.1987              Pascale Serf
	Version 2       07.12.1987              Liste AL statt Pol. G    PS
	Version 3	18.11.94	Macro nur noch im Header definiert. MP
   DATE putgfsel      : 890501.941201
H*/
/*
	For the definition of putgfsel please refer to the header file _arith2.h.
*/
