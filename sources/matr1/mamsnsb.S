/*M
.SH NAME
mamsnsb - matrix of modular singles, null space basis (MACRO)

.SH SYNOPSIS
.nf
#include<_matr1.h>

list mamsnsb(p, A)
single p;
matrix A;

.SH DESCRIPTION
mamsnsb() returns a list L = (L1,...,Lr) of n-dimensional
vectors over Z/pZ representing a basis of the null space of M.

.PP
.TP 4
.B p
must be prime.
.TP 4
.B M
is a nxn matrix over Z/pZ

.SH CAUTION
M is changed.
M*/
/*H
	Version 1       30.05.1988      J.Schmitt
	Version 2	23.03.1992	vollkommen neue Version.
					nicht mehr nur quadr. Matr. zugelassen.
					ausserdem Macro statt Funktion.  GL
	Version 3	16.11.1992	NUM -> MANUMMY,
					DUM -> MADUMMY.  PS
	Version 4	18.11.94	Macro nur noch im Header definiert. MP
   DATE mamsnsb       : 890501.920331.921130.941201
H*/
/*
	For the definition of mamsnsb please refer to the header file _matr1.h.
*/
