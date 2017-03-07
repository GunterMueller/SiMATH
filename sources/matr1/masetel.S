/*M
.SH NAME
masetel - matrix set element (MACRO)

.SH SYNOPSIS
.nf
#include<_matr1.h>

masetel(M, m, n, el)
matrix M;
single m, n;
obj el;

.SH DESCRIPTION
masetel() assigns the element el
to the entry at position (m,n) of the matrix M
and then returns M.
M*/
/*H
	Version 1       02.02.1989      Klaus Petry
	Version 2	18.11.94	Macro nur noch im Header definiert. MP
   DATE masetel       : 890501.941201
H*/
/*
	For the definition of masetel please refer to the header file _matr1.h.
*/
