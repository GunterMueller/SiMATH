/*M
.SH NAME
maiev - matrix over integers eigenvalues (MACRO)

.SH SYNOPSIS
.nf
#include<_matr2.h>

list maiev(M)
matrix M;

.SH DESCRIPTION
maiev() returns the list L=(EV1, AM1,  ..., EVk, AMk)
of eigenvalues EVi of M and their algebraic multiplicities AMi.

.PP
.TP 4
.B M
is a square matrix of integers.

M*/




/*H
	Version 1	17.08.1989	Th. Weis
	Version 2       05.12.1990      EVMAI -> MAIEV,
					EVMAIIFCP -> MAIEVIFCP.  TW
	Version 3	16.11.1992	NUM -> MADUMMY.  PS
	Version 4	18.11.94	Macro nur noch im Header definiert. MP
   DATE maiev         : 890901.910715.921130.941201
H*/
/*
	For the definition of maiev please refer to the header file _matr2.h.
*/
