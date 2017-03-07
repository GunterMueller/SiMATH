/*M
.SH NAME
fputpmi - file put polynomial over modular integers

.SH SYNOPSIS
.nf
#include<_pol1.h>

single fputpmi(r, M, P, V, pf)  
single r; 
int M; 
pol P; 
list V; 
FILE *pf;
       
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
.TP 4                                                                           
.B pf                                                                           
is a pointer to an output file.                                                 
.PP                                                                             
fputpmi writes the polynomial P to the file *pf. The end of the polynomial will 
be marked with '#'.                                                             
.PP                                                                             
fputpmi returns                                                                 
 0      by success,                                                             
 ERROR  else.                                                                   
                                                                                
.SH SEE ALSO                                                                    
pmakevl                                                                         
                                                                            
M*/

/*H
	Version 1	01.08.91	J.Schmitt
	Version 2	24.09.91	J.S. voellig neue Version.
   DATE fputpmi       : 910915.910930.9301__
H*/

#include <_pol1.h>

single fputpmi(r,M,P,V,pf)
single r;
int M;
pol P;
list V;
FILE *pf;
{
	single t;

	t = fputpi(r,P,V,pf);	
	if ( t == ERROR ) errmsgio("fputpmi","P201");
	return(t);
}
