/*M
.SH NAME
pmiquot - polynomial over modular integers quotient

.SH SYNOPSIS
.nf
#include<_pol1.h>

pol pmiquot(r, M, P1, P2) 
single r; 
int M; 
pol P1, P2;

.SH DESCRIPTION
.TP 4
.B r
is an integer number, 0 <= r < BASIS.
.TP 4
.B M
is a prime number.
.TP 4
.B P1, P2
are polynomials in r variables over Z/(M*Z), P2 != 0.
.PP
pmiquot returns the polynomial P3 over Z/(M*Z), where                          
.IP                                                                             
P3 = P1 / P2.  

.SH CAUTION
Here, division means division with remainder, so 
.IP
P1 = P2 * P3 +
.B REMAINDER
                            
.SH SEE ALSO
 pmirem
 pmiqrem

M*/

/*H
	Version 1       22.10.1987      B. Weis
	Version 2	18.11.94	Macro nur noch im Header definiert. MP
   DATE pmiquot       : 890501.941201
H*/
/*
	For the definition of pmiquot please refer to the header file _pol1.h.
*/
