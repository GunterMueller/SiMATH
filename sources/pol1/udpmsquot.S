/*M
.SH NAME
udpmsquot - univariate dense polynomial over modular singles quotient

.SH SYNOPSIS
.nf
#include<_pol1.h>

pol udpmsquot(m, P1, P2) 
single m; 
pol P1, P2;

.SH DESCRIPTION
.TP 4
.B m
is a prime number, 0 < m < BASIS.
.TP 4                                                                           
.B P1, P2                                                                       
are univariate dense polynomials over Z/mZ, P2 != 0.
.PP
udpmsquot returns the polynomial P3 over Z/mZ, where                            
.IP                                                                             
P3 = P1 / P2.                                                                   
                                                                                
.SH CAUTION                                                                     
Here, division means division with remainder, so                                
.IP                                                                             
P1 = P2 * P3 +                                                                  
.B REMAINDER                      

.SH SEE ALSO
 udpmsqrem
 udpmsqrem

M*/

/*H
	Version 1       05.01.1990      A.Stein
	Version 2	18.11.94	Macro nur noch im Header definiert. MP
   DATE udpmsquot     : 900315.9011__.941201
H*/
/*
	For the definition of udpmsquot please refer to the header file _pol1.h.
*/
