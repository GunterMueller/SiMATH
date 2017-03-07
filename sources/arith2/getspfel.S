/*M
.SH NAME
getspfel - get special p-adic field element
(MACRO)

.SH SYNOPSIS
.nf
#include<_arith2.h>

pfel getspfel(p)  
single p;
     
.SH DESCRIPTION
.TP 4
.B p
is a single prime.
.PP
Let A be an element in Qp, and let a be the approximation of the expansion in a series of A.
.PP       
getspfel read the digits of a from stdin and returns a as an element of type pfel (s.itopfel), or ERROR in case of an error occurs.
.PP
Following rules must be considered:
 1. The end of the element must be marked with '#'.
 2. Only non negative and integral coefficients
    c_i < p (say) are allowed. For c_i = 0, the
    input is not necessary, provided that there is
    a c_j != 0, with j > i. 
 3. The coefficients are seperated to each other by
    '_'.
 4. The coefficients must be given in ascending 
    order (with regard to the appendant exponents).
    The change from the coefficients of negative 
    exponents to non negative exponents had to be 
    marked with '.' instead of '_'.

.SH NOTES
If the input as a expansion in a series is favoured , please use getnfel.
 
.SH SEE ALSO
 itopfel
 getpfel
 fgetspfel

M*/
                                                   
/*H
	Version 1       27.06.1990      Christine Hollinger
	Version 2	18.11.94	Macro nur noch im Header definiert. MP
   DATE getspfel      : 901120.9301__.941201
H*/
/*
	For the definition of getspfel please refer to the header file _arith2.h.
*/
