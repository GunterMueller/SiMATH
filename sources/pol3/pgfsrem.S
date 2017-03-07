/*M
.SH NAME
pgfsrem - polynomial over Galois-field with single characteristic remainder
(MACRO)

.SH SYNOPSIS
.nf
#include<_pol3.h>

pol pgfsrem(r, p, AL, P1, P2)  
single r, p; 
list AL; 
pol P1, P2;
     
.SH DESCRIPTION
.TP 4
.B r
is an integer number, 0 <= r < BASIS.
.TP 4
.B p
is a prime number, p < BASIS.
.TP 4
.B AL
= (G AL1) can be seen as an arithmetic list of GF(p^n), where n = lenght(AL1)+1 (s. gfsalgen).
.TP 4
.B P1, P2
are polynomials in r variables over GF(p^n).
.PP      
pgfsrem returns the remainder of the division of P1 by P2.

.SH SEE ALSO
gfsalgen

M*/
                                           
/*H
	Version 1         23.03.88           J.Schmitt
	Version 2	18.11.94	Macro nur noch im Header definiert. MP
   DATE pgfsrem       : 890501.9203__.941201
H*/
/*
	For the definition of pgfsrem please refer to the header file _pol3.h.
*/
