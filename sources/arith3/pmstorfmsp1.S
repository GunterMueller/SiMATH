/*M
.SH NAME
pmstorfmsp1 - polynomial over modular singles to rational function over modular single prime, transcendence degree 1 
(MACRO)

.SH SYNOPSIS
.nf
#include<_arith3.h>

rfunc pmstorfmsp1(p, P) 
single p; 
pol P;
   
.SH DESCRIPTION
.TP 4
.B p 
is a prime number, p < BASIS.
.TP 4
.B P
is an univariate polynomial over Z/pZ.
.PP
pmstorfmsp1 returns P as a rational function over Z/pZ.

M*/
                            
/*H
	Version 1       18.04.1988      B. Weis
	Version 2       07.10.1988      rfunc eingefuehrt
					J.Schmitt
	Version 3	18.11.94	Macro nur noch im Header definiert. MP
   DATE pmstorfmsp1   : 890501.941201
H*/
/*
	For the definition of pmstorfmsp1 please refer to the header file _arith3.h.
*/
