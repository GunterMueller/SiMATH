/*M
.SH NAME
dipfmo - distributive polynomial from monomial

.SH SYNOPSIS
.nf
#include<_pol1.h>

pol dipfmo(r, BC, EV)  
single r; 
obj BC; 
list EV;

.SH DESCRIPTION
.TP 4
.B r
is an integer number, 0 <= r < BASIS.
.TP 4 
.B BC
is an element of an arbitrary ring.
.TP 4
.B EV 
is an exponent vector with length r.
.PP
dipfmo returns the polynomial P in r variables, which is the distributive monomial with coefficient BC and exponent vector EV.

M*/

/*H
	Version 1	03.06.1992	Th. Weis
	Version 2	18.11.94	Macro nur noch im Header definiert. MP
   DATE dipfmo        : 930115.941201
H*/
/*
	For the definition of dipfmo please refer to the header file _pol1.h.
*/
