/*M
.SH NAME
putdiprl - put distributive polynomial over rationals list

.SH SYNOPSIS
.nf
#include<_pol1.h>

single putdiprl(r, PL, VL)  
single r; 
list PL, VL;
 
.SH DESCRIPTION
.TP 4                                                                           
.B r                                                                            
is an integer number, 0 <= r < BASIS.                                           
.TP 4                                                                           
.B PL                                                                           
is a list of distributive polynomials in r variables over the rational numbers. 
.TP 4                                                                           
.B VL                                                                           
= (V1 ... Vr)                                                                   
is a list of variables names, used by the polynomials in PL (s. pmakevl).       
For r = 0, VL is the empty list.                          
.PP
putdiprl writes PL to stdout. The several ends of the polynomials will be marked with '#'.
.PP
putdiprl returns                                                               
                                                                                
 0      by success,                                                             
 ERROR  else.                                                                   
                                                                                
.SH SEE ALSO                                                                    
pmakevl                                                                         
                               
M*/

/*H
	Version 1	30.06.1993	Th. Weis
	Version 2	18.11.94	Macro nur noch im Header definiert. MP
   DATE putdiprl      : 931130.941201
H*/
/*
	For the definition of putdiprl please refer to the header file _pol1.h.
*/
