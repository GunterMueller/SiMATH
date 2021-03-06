/*M
.SH NAME 
putpms - put polynomial over modular singles
                                                                       
.SH SYNOPSIS                                                                    
.nf                                                                             
#include<_pol1.h>                                                               
                                                                                
single putpms(r, m, P, V) 
single r, m; 
pol P; 
list V;                                                                                
.SH DESCRIPTION
.TP 4
.B r                                                                            
is an integer number, 0 <= r < BASIS.                                           
.TP 4                                                                           
.B m                                                                            
is an integer number.                                                           
.TP 4                                                                           
.B P                                                                            
is a polynomial in r variables over Z/mZ.                                       
.TP 4                                                                           
.B V                                                                            
is a list, containing the variables names of P (s. pmakevl).                    
For r = 0, V is the empty list.             
.PP
putpms writes the polynomial P to stdout.                                              
The end of the polynomial will be marked with '#'.                 
.PP
putpms returns                                                                 
                                                                                
 0      by success,                                                             
 ERROR  else.                                                                   
                                                                                
.SH SEE ALSO                                                                    
pmakevl                                                                         
                                                                             
M*/                                                                             

/*H
	Version 1	31.05.1987      B. Weis
	Version 2       10.03.1988      B. Weis
			Sonderfall einbuchstabige Variablennamen verboten
	Version 3	18.11.94	Macro nur noch im Header definiert. MP
   DATE putpms        : 890501.941201
H*/
/*
	For the definition of putpms please refer to the header file _pol1.h.
*/
