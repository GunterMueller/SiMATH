/*M
.SH NAME
getrfr - get rational function over rationals
(MACRO)

.SH SYNOPSIS
.nf
#include<_arith3.h>

rfunc getrfr(r, V)  
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
getrfr reads a rational function in the r variables     V1, ...,Vr over the rational numbers from stdin and returns it.
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
	Version 1       17.03.1988      B. Weis
	Version 2       22.03.1988      B. Weis
			Dokumentation korrigiert
	Version 3       19.04.1988      B. Weis
			ueberfluessige Klammern entfernt
	Version 4       07.10.1988      rfunc eingefuehrt
					J.Schmitt
	Version 5	18.11.94	Macro nur noch im Header definiert. MP
   DATE getrfr        : 890501.9301__.941201
H*/
/*
	For the definition of getrfr please refer to the header file _arith3.h.
*/
