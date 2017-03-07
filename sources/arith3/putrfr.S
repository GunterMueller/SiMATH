/*M
.SH NAME
putrfr - put rational function over rationals
(MACRO)

.SH SYNOPSIS
.nf
#include<_arith3.h>

single putrfr(r, R, V) 
single r; 
rfunc R; 
list V;
      
.SH DESCRIPTION
.TP 4
.B r
is an integer number, 0 <= r < BASIS.
.TP 4  
.B R
is a rational function in r variables over the rational numbers.
.B V
is a list, containing the variables names of R (s. pmakevl).
For r = 0, V is the empty list.  
.PP
putrfr writes the function R to stdout, and returns
.IP
.nf
0		by success,
ERROR	else.

.SH SEE ALSO
pmakevl

M*/
            
/*H
	Version 1       18.03.1988      B. Weis
	Version 2       19.04.1988      B. Weis
			Dokumentation verbessert, ueberfluessige
			Klammern entfernt
	Version 3       07.10.1988      rfunc eingefuehrt
					J.Schmitt
	Version 4	18.11.94	Macro nur noch im Header definiert. MP
   DATE putrfr        : 890501.941201
H*/
/*
	For the definition of putrfr please refer to the header file _arith3.h.
*/
