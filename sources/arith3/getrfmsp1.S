/*M
.SH NAME
getrfmsp1 - get rational function over modular single primes, transcendence degree 1
(MACRO)

.SH SYNOPSIS
.nf
#include<_arith3.h>

rfunc getrfmsp1(p, V)  
single p; 
list V;
    
.SH DESCRIPTION
.TP 4
.B p
is a prime number, p < BASIS.
.TP 4
.B V
= ( V1 ) is a list of one variable name (s. pmakevl).
.PP
getrfmsp1 reads an univariate rational function over Z/pZ from stdin and returns it.
.TP 4
.nf
Following rules must be considered:        
1. The function must be of the form
   P1/P2 or P1, whereby P1 and P2 are polynomials.
   For P2 = 1, the input of the denominator is not 
   necessary.
2. The fraction bar must be in the same line as the 
   polynomial-end character "#" of P1.
3. For the input of the polynomials, the rules given 
   in getpms must be considert.
  

.SH SEE ALSO
.nf
pmakevl
getpms

M*/
           
/*H
	Version 1       19.04.1988      B. Weis
	Version 2       07.10.1988      rfunc eingefuehrt
					J.Schmitt
	Version 3	18.11.94	Macro nur noch im Header definiert. MP
   DATE getrfmsp1     : 890501.9301__.941201
H*/
/*
	For the definition of getrfmsp1 please refer to the header file _arith3.h.
*/
