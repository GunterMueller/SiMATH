/*M
.SH NAME
mamsev - matrix of modular singles, eigenvalues (MACRO)

.SH SYNOPSIS
.nf
#include<_matr2.h>

list mamsev(p, M)
single p;
matrix M;

.SH DESCRIPTION
mamsev() returns the list L=(EV1, ..., EVk) of eigenvalues of M.
The eigenvalues appear according to their algebraic multiplicity. 

.PP
.TP 4
.B p
must be prime.
.TP 4
.B M
is a square matrix over Z/pZ.

M*/


/*H
	Version 1	17.08.1989	Th. Weis
	Version 2       05.12.1990      EVMAMSP -> MAMSEV,
					EVMAMSPIFCP -> MAMSEVIFCP.  TW
	Version 3	16.11.1992	NUM -> MADUMMY.  PS
	Version 4	18.11.94	Macro nur noch im Header definiert. MP
   DATE mamsev        : 890901.910715.9203__.921130.941201
H*/
/*
	For the definition of mamsev please refer to the header file _matr2.h.
*/
