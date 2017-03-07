/*M
.SH NAME
diplbc - distributive polynomial leading base coefficient

.SH SYNOPSIS
.nf
#include<_pol1.h>

obj diplbc(r, P)  
single r; 
pol P;

.SH DESCRIPTION
.TP 4
.B r
is an integer number, 0 <= r < BASIS.
.TP 4
.B P
is a distributive polynomial in r variables over an arbitrary ring.
.PP
diplbc returns the base coefficient of the leading monomial of P.

M*/

/*H
	Version 1	01.06.1992	Th. Weis
	Version 2	18.11.94	Macro nur noch im Header definiert. MP
   DATE diplbc        : 930115.941201
H*/
/*
	For the definition of diplbc please refer to the header file _pol1.h.
*/
