/*M
.SH NAME
putpmi - put polynomial over modular integers                                                                        
.SH SYNOPSIS                                                                    
.nf                                                                             
#include<_pol1.h>                                                               
                                                                                
single putpmi(r, M, P, V)  
single r; 
int M; 
pol P; 
list V;                                                                               
.SH DESCRIPTION
.TP 4                                                                           
.B r                                                                            
is an integer number, 0 <= r < BASIS.                                           
.TP 4                                                                           
.B M                                                                            
is an integer number, M > 0.                                                    
.TP 4                                                                           
.B P                                                                            
is a polynomial in r variables over Z/(M*Z).                                    
.TP 4                                                                           
.B V                                                                            
is a list, containing the variables names of P (s. pmakevl).                    
For r = 0, V is the empty list.                                             
.PP
putpmi writes the polynomial P to stdout.                                              
The end of the polynomial will be marked with '#'.      
.PP
putpmi returns
                                                                 
 0      by success,                                                             
 ERROR  else.                                                                   
                                                                                
.SH SEE ALSO                                                                    
pmakevl                                                                         
                                                                                    
M*/                                                                             
          
/*H
	Version 1 	13.08.91	J.Schmitt
	Version 2	18.11.94	Macro nur noch im Header definiert. MP
   DATE putpmi        : 910915.941201
H*/
/*
	For the definition of putpmi please refer to the header file _pol1.h.
*/
