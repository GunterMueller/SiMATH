/*M
.SH NAME
udpmiquot - univariate dense polynomial over modular integers quotient

.SH SYNOPSIS
.nf
#include<_pol1.h>

pol udpmiquot(m, P1, P2)  
int m; 
pol P1, P2;

.SH DESCRIPTION
.TP 4
.B m
is a prime number.       
.TP 4                                                                           
.B P1, P2                                                                       
are univariate dense polynomials over Z/mZ, P2 != 0.
.PP
udpmiquot returns the polynomial P3 over Z/mZ, where                           
.IP                                                                             
P3 = P1 / P2.                                                                   
                                                                                
.SH CAUTION                                                                     
Here, division means division with remainder, so                                
.IP                                                                             
P1 = P2 * P3 +                                                                  
.B REMAINDER                            

.SH SEE ALSO
 udpmirem
 udpmiqrem

M*/

/*H
	Version 1 	14.08.91	J.Schmitt
	Version 2	18.11.94	Macro nur noch im Header definiert. MP
   DATE udpmiquot     : 910915.941201
H*/
/*
	For the definition of udpmiquot please refer to the header file _pol1.h.
*/
