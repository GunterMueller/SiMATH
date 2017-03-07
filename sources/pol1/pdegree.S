/*M
.SH NAME
pdegree - polynomial degree, main variable

.SH SYNOPSIS
.nf
#include<_pol1.h>

single pdegree(r, P)  
single r; 
pol P;

.SH DESCRIPTION
.TP 4
.B r
is an integer number, 0 < r < BASIS.
.TP 4
.B P
is a polynomial in r variables, either in sparse or dense representation.
.PP
pdegree returns the degree of the polynomial P with regard to the main variable.
For P = 0, pdegree returns 0.

.SH SEE ALSO
pdegreesv

M*/

/*H
	Version 1	31.05.1987      B. Weis
	Version 2       20.08.1991      auch dense-Polynome zugelassen
					(nur Dokumentation geaendert).  PS
	Version 3	18.11.94	Macro nur noch im Header definiert. MP
   DATE pdegree       : 890501.910915.941201
H*/
/*
	For the definition of pdegree please refer to the header file _pol1.h.
*/
