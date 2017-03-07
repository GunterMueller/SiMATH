/*M
.SH NAME
getpfel - get p-adic field element
(MACRO)

.SH SYNOPSIS
.nf
#include<_arith2.h>

pfel getpfel( p )  
single p;

.SH DESCRIPTION
.TP 4
.B p
is a single prime.
.PP
Let A be an element in Qp.
.PP
getpfel reads the approximation of the expansion in a series of A from stdin and returns it as an element of type pfel (s.itopfel), or ERROR in case of an error occurs.
.PP
Following rules must be considered:
 1. The end of the element must be marked with '#'.
 2. Only non negative and integral coefficients 
    c_i < p (say) are allowed. For c_i = 0, the 
    input is not necessary, provided that there is
    a c_j != 0, with j > i.
 3. The exponents are marked by the prefix '^' and 
    given in ascending order.
 4. '+' and '^' can be seperated by blank to the 
    coefficient and exponents, respectively.  

.SH NOTES 
If the input in digits is favoured, please use getspfel.

.SH SEE ALSO
 itopfel
 fgetpfel
 getspfel

M*/
                                    
/*H
	Version 1       18.06.1990      Christine Hollinger
	Version 2	18.11.94	Macro nur noch im Header definiert. MP
   DATE getpfel       : 901120.9107__.9301__.941201
H*/
/*
	For the definition of getpfel please refer to the header file _arith2.h.
*/
