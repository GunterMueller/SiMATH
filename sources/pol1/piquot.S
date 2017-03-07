/*M
.SH NAME
piquot - polynomial over integers quotient

.SH SYNOPSIS
.nf
#include<_pol1.h>

pol piquot(r, P1, P2) 
single r; 
pol P1,P2;

.SH DESCRIPTION
.TP 4
.B r
is an integer number, 0 <= r < BASIS.
.TP 4
.B P1, P2
are polynomials in r variables over the integer numbers. P2 != 0.
.PP
piquot returns the polynomial P3 over the integer numbers, where
.IP
P3 = P1 / P2.

.SH CAUTION                                                                     
Here, division means division with remainder, so                               
.IP                                                                             
P1 = P2 * P3 +                                                                  
.B REMAINDER                                                                     
.SH SEE ALSO                                                                    
 pirem                                                                          
 piqrem                                                                         
                
M*/

/*H
	Version 1	31.05.1987      B. Weis
	Version 2	18.11.94	Macro nur noch im Header definiert. MP
   DATE piquot        : 890501.941201
H*/
/*
	For the definition of piquot please refer to the header file _pol1.h.
*/
