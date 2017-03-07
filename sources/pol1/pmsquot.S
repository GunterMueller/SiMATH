/*M
.SH NAME
pmsquot - polynomial over modular singles quotient                                                                        
.SH SYNOPSIS                                                                    
.nf                                                                             
#include<_pol1.h>                                                               
                                                                                
pol pmsquot(r, m, P1, P2) 
single r, m; 
pol P1, P2;                                                                                
.SH DESCRIPTION
.TP 4                                                                           
.B r                                                                            
is an integer number, 0 <= r < BASIS.                                           
.TP 4                                                                           
.B m                                                                            
is a prime number, 0 < m < BASIS.                                            
.TP 4                                                                           
.B P1, P2                                                                       
are polynomials in r variables over Z/mZ, P2 != 0.
.PP
pmsquot returns the polynomial P3 over Z/mZ, where
.IP                                                                             
P3 = P1 / P2.                                                                   
                                                                                
.SH CAUTION                                                                     
Here, division means division with remainder, so                                
.IP                                                                             
P1 = P2 * P3 +                                                                  
.B REMAINDER                                                                    

.SH SEE ALSO
 pmsrem
 pmsqrem

M*/                                                                             
  
/*H
	Version 1	31.05.1987      B. Weis
	Version 2	18.11.94	Macro nur noch im Header definiert. MP
   DATE pmsquot       : 890501.941201
H*/
/*
	For the definition of pmsquot please refer to the header file _pol1.h.
*/
