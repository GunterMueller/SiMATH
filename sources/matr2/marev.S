/*M
.SH NAME
marev - matrix over the rational numbers, eigenvalues (MACRO)

.SH SYNOPSIS
.nf
#include<_matr2.h>

list marev(M)
matrix M;

.SH DESCRIPTION
marev() returns  the list L=(EV1, AM1,  ..., EVk, AMk)
of eigenvalues EVi of M and their algebraic multiplicities AMi.

.PP
.TP 4
.B M
is a square matrix over the rational numbers.

M*/



/*H
	Version 1	17.08.1989	Th. Weis
	Version 2       05.12.1990      EVMAR -> MAREV,
					EVMARIFCP -> MAREVIFCP.  TW
	Version 3	16.11.1992	NUM -> MADUMMY.  PS
	Version 4	18.11.94	Macro nur noch im Header definiert. MP
   DATE marev         : 890901.910715.921130.941201
H*/
/*
	For the definition of marev please refer to the header file _matr2.h.
*/
