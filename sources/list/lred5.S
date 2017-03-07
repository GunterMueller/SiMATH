/*M
.SH NAME
lred5 - list reductum, 5 objects (MACRO)

.SH SYNOPSIS
.nf
#include<_list.h>

list lred5(L)
list L;

.SH DESCRIPTION
.TP 4
.B L
is a list, containing at least 5 objects. L = (a_1, a_2, a_3, a_4, a_5, ...)
.PP
lred5 returns the list (a_6, ...) or the empty list, if L = (a_1, a_2, a_3, a_4, a_5).

M*/

/*H
	Version 1       14.10.1986      R.Boeffgen
	Version 2       11.12.1989      einheitl. Version fuer MX2, MX2+, SUN
					und Apollo. PS
	Version 3	03.11.1994	MX-Version entfernt. MP
	Version 4	18.11.94	Macro nur noch im Header definiert. MP
   DATE lred5         : 890501.900101.941201
H*/
/*
	For the definition of lred5 please refer to the header file _list.h.
*/
