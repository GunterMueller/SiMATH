/*M
.SH NAME
pgfsquot - polynomial over Galois-field with single characteristic quotient
(MACRO)

.SH SYNOPSIS
.nf
#include<_pol3.h>

pol pgfsquot(r, p, AL, P1, P2)  
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
are polynomials in r variables over GF(p^n), P2 != 0.
.PP
pgfsquot returns a polynomial over GF(p^n), say P3, where
.IP
P3 = P1 / P2.

.SH SEE ALSO
gfsalgen

M*/
                        
/*H
	Version 1         23.03.88           J.Schmitt
	Version 2	18.11.94	Macro nur noch im Header definiert. MP
   DATE pgfsquot      : 890501.9203__.941201
H*/
/*
	For the definition of pgfsquot please refer to the header file _pol3.h.
*/
