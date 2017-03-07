/*M
.SH NAME
getpr - get polynomial over rationals

.SH SYNOPSIS
.nf
#include<_pol1.h>

pol getpr(r,V)  
single r; 
list V;

.SH DESCRIPTION
.TP 4                                                                           
.B r                                                                            
is an integer, 0 <= r < BASIS.                                                  
.TP 4                                                                           
.B V                                                                            
= ( V1 ... Vr ) is a list of variable names           ( s. pmakevl ), Vr is the 
name of the main variable.                                                      
.PP
getpr reads a polynomial in the r variables V1, ..., Vr over the rationals from stdin.
.TP 4                                                                           
Following rules must be considered:                                             
 1. The end of the polynomial must be marked with '#'.                          
 2. Only positive exponents are allowed. They must be                           
    marked by the prefix '^' or '**'. The input of the                          
    powers 1 or 0 is not necessary, but in the second                           
    case, the input of the according variable had to                            
    remain undone too.          
 3. Coefficients of any size are allowed. The                                   
    coefficient and its sign can be seperated by                                
    blanks, the coefficient and the according                                   
    variables can be seperated by any blanks and/or                             
    '*'. These seperations are not necessary. The                               
    input of the coefficient 1 is not necessary.                                
 4. Variable names must be mentioned in V, they are                             
    not allowed to be seperated by special                                      
    characters.                                                                 
    Single variables and its exponents can be                                   
    seperated to other variables by any blanks and/or                           
    '*'. This seperation is only necessary if no                                
    exponent was specified.                                                     
 5. Appears a variable in a single monomial more than                           
    once, the several occurances will be merged.                                
    Appears a monomial more than once, the several                              
    occurances will be merged.                                                  
.PP                                                                             
getpr returns the polynomial p by success, ERROR else.                          
                                                                                
.SH SEE ALSO                                                                    
pmakevl
                                        
M*/

/*H
	Version 1	31.05.1987      B. Weis
	Version 2       10.03.1988      B. Weis
			Sonderfall einbuchstabige Variablennamen verboten
	Version 3	18.11.94	Macro nur noch im Header definiert. MP
   DATE getpr         : 890501.9301__.941201
H*/
/*
	For the definition of getpr please refer to the header file _pol1.h.
*/
