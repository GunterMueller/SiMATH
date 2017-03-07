/*M
.SH NAME
lsfirst - list set first (MACRO)

.SH SYNOPSIS
.nf
#include<_list.h>

obj lsfirst(L, a)  
list L; 
obj a; 

.SH DESCRIPTION
.TP 4
.B L
is a non empty list.
.PP
lsfirst replaces the first element in L with a, and returns a. L will be changed.

M*/
            
/*H
	Version 1       14.10.1986      R.Boeffgen
	Version 2       11.12.1989      einheitl. Version fuer MX2, MX2+, SUN
					und Apollo. PS
	Version 3	03.11.1994	MX-Version entfernt. MP
	Version 4	18.11.94	Macro nur noch im Header definiert. MP
   DATE lsfirst       : 890501.900101.941201
H*/
/*
	For the definition of lsfirst please refer to the header file _list.h.
*/
