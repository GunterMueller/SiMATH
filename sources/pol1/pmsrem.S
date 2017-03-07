/*M
.SH NAME
pmsrem - polynomial over modular singles remainder
                                                                        
.SH SYNOPSIS                                                                    
.nf                                                                             
#include<_pol1.h>                                                               
                                                                                
pol pmsrem(r, m, P1, P2) 
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
pmsrem returns the remainder on dividing P1 by P2.
                                                                      
.SH SEE ALSO
 pmsquot
 pmsqrem
                                                                    
M*/     

/*H
	Version 1	31.05.1987      B. Weis
	Version 2	18.11.94	Macro nur noch im Header definiert. MP
   DATE pmsrem        : 890501.941201
H*/
/*
	For the definition of pmsrem please refer to the header file _pol1.h.
*/
