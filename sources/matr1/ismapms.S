/*M
.SH NAME
ismapms - is matrix of polynomials over modular singles ? (MACRO)

.SH SYNOPSIS
.nf
#include<_matr1.h>

single ismapms(r, m, M)
obj r, m, M;

.SH DESCRIPTION
ismapms() returns 1, if M is a matrix of polynomials in r variables over Z/mZ
and 0 otherwise.
M*/
/*H
	Version 1       22.09.1987      B. Weis
	Version 2       27.06.1988      K.Petry ( erg=0, falls M keine oder
					leere Liste, oder nur 0-Eintraege )
	Version 3       22.11.1988      Klaus Petry     Macro
	Version 4	18.11.94	Macro nur noch im Header definiert. MP
   DATE ismapms       : 890501.9203__.941201
H*/
/*
	For the definition of ismapms please refer to the header file _matr1.h.
*/
