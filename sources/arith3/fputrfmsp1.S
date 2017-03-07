/*M
.SH NAME
fputrfmsp1 - file put rational function over modular single prime, transcendence degree 1
(MACRO)

.SH SYNOPSIS
.nf
#include<_arith3.h>

single fputrfmsp1(p, R, V, pf) 
single p; 
rfunc R; 
list V; 
FILE *pf;
      
.SH DESCRIPTION
.TP 4
.B p
is a prime number, p < BASIS.
.TP 4
.B R
is an univariate rational function over Z/pZ.
.TP 4
.B V
= ( V1 ) is a list of one variable name used by R (s. pmakevl). 
.TP 4
.B pf
points on an open input file *pf.
.PP 
fputrfmsp1 writes R to *pf and returns
.IP
.nf
0       by success,
ERROR   else.

.SH SEE ALSO
pmakevl
                 
M*/
             
/*H
	Version 1       18.04.1988      B. Weis
	Version 2       07.10.1988      rfunc eingefuehrt
					J.Schmitt
	Version 3	18.11.94	Macro nur noch im Header definiert. MP
   DATE fputrfmsp1    : 890501.941201
H*/
/*
	For the definition of fputrfmsp1 please refer to the header file _arith3.h.
*/
