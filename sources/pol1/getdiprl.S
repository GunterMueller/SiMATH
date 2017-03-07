/*M
.SH NAME
getdiprl - get distributive polynomial over rationals list

.SH SYNOPSIS
.nf
#include<_pol1.h>

list getdiprl(r, V)  
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
getdiprl reads a list of distributive polynomials in the r variables V1, ..., Vr over the rational numbers from stdin.
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
 6. The monomials will be sorted according to the                               
    term order defined by the value of EVORD.                                   
                                                                                
    Following values can occur:                                                 
    EVORD = 1 : lexicographical order,                                          
          = 2 : graduated lexicographical order,                                
          = 3 : total degree ordering,                                          
          = 4 : lexicographical order with inverse                              
                exponent vector.                                                
    Default is EVORD = 1.                                                       
 7. The list of polynomials must beginn with '{'                                
    and end with '}'. The several polynomials must be                           
    seperated by commas.                                                        
.PP                                           
getdiprl returns the list of distibutive polynomials by success, ERROR else.  
                                                                                
.SH SEE ALSO                                                                    
 pmakevl                                                                        
                 
M*/

/*H
	Version 1       30.06.1993      Th. Weis
	Version 2	18.11.94	Macro nur noch im Header definiert. MP
   DATE getdiprl      : 931130.941201
H*/
/*
	For the definition of getdiprl please refer to the header file _pol1.h.
*/
