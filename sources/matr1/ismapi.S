/*M
.SH NAME
ismapi - is matrix of polynomials over integers ? (MACRO)

.SH SYNOPSIS
.nf
#include<_matr1.h>

single ismapi(r, M)
obj r, M;

.SH DESCRIPTION
ismapi() returns 1, if M is a matrix of polynomials in r variables over integers
and 0 otherwise.
M*/
/*H
	Version 1       22.09.1987      B. Weis
	Version 2       27.06.1988      K. Petry ( erg=0, falls M keine oder
					leere Liste, oder nur 0-Eintraege )
	Version 3       22.11.1987      Klaus Petry  Macro
	Version 4	18.11.94	Macro nur noch im Header definiert. MP
   DATE ismapi        : 890501.941201
H*/
/*
	For the definition of ismapi please refer to the header file _matr1.h.
*/
