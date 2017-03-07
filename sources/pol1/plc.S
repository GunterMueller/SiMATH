/*M
.SH NAME
plc - polynomial leading coefficient, main variable

.SH SYNOPSIS
.nf
#include<_pol1.h>

pol plc(r, P) 
single r; 
pol P;

.SH DESCRIPTION
.TP 4                                                                           
.B r                                                                            
is an integer number, 0 < r < BASIS.
.TP 4
.B P
is a polynomial in r variables.
.PP
plc returns the leading coefficient of P with regard to the main variable, or 0 if P = 0.
         
M*/

/*H
	Version 1	31.05.1987      B. Weis
	Version 2	18.11.94	Macro nur noch im Header definiert. MP
   DATE plc           : 890501.941201
H*/
/*
	For the definition of plc please refer to the header file _pol1.h.
*/
