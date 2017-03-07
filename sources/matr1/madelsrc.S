/*M
.SH NAME
madelsrc - matrix delete several rows and columns (MACRO)

.SH SYNOPSIS
.nf
#include<_matr1.h>

single madelsrc(pM, I, J)
matrix *pM;
list I, J;

.SH DESCRIPTION
madelsrc() deletes the rows listed in I and the columns listed in J
from the matrix *pM and returns 0.

.PP
.TP 4
.B M
is an mxn matrix.
.TP 4
.B I
is a list of row indices 1 <= i1 < i2 < ... < ik <= m.
.TP 4
.B J
is a list of column indices 1 <= j1 < j2 < ... < jl <= n.
M*/
/*H
	Version 1	25.02.1992	Th. Weis
	Version 2	18.03.1992	neu.  Georg Lay
	Version 3	18.11.94	Macro nur noch im Header definiert. MP
   DATE madelsrc      : 920331.941201
H*/
/*
	For the definition of madelsrc please refer to the header file _matr1.h.
*/
