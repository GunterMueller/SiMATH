/*M
.SH NAME
putpgfs - put polynomial over Galois-field
(MACRO)

.SH SYNOPSIS
.nf
#include<_pol3.h>

single putpgfs(r, p, AL, P, V, Vgfs) 
single r, p; 
list AL, V, Vgfs; 
pol P;
                                  
.SH DESCRIPTION
.TP 4
.B r
is an integer number, 0 <= r < BASIS.
.TP 4
.B p
is a prime number, p < BASIS.
.TP 4
.B AL
= (G AL1) can be seen as an arithmetic list of GF(p^n), where n = lenght(AL1)+1 (s. gfsalgen).
.TP 4
.B P
is a polynomial over GF(p^n) in r variables.   
.TP 4
.B VL
is the list of variables names, used by the polynomial P (s. pmakevl).
.TP 4
.B Vgfs
is a list which contains one element, representing the name of a primitive element in GF(p^n)/(Z/pZ).
.PP
putpgfs writes P to stdout, the end of P will be marked with '#'.
putpgfs returns 0 by success and ERROR else.

.SH SEE ALSO       
.nf
gfsalgen
pmakevl
                                                                            
M*/
            
/*H
	Version 1       07.04.1988      B. Weis
	Version 2	18.11.94	Macro nur noch im Header definiert. MP
   DATE putpgfs       : 890501.941201
H*/
/*
	For the definition of putpgfs please refer to the header file _pol3.h.
*/
