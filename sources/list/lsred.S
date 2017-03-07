/*M
.SH NAME
lsred - list set reductum (MACRO)

.SH SYNOPSIS
.nf
#include<_list.h>

list lsred(L1, L2)  
list L1, L2;
 
.SH DESCRIPTION
.TP 4
.B L1, L2
are lists. L1 must not be empty.
.PP
Let L1 =(a1, a2, ..., an) and  L2 = (b1, b2, ..., bn).
lsred changes L1 to (a1, b1, b2, ..., bn) and returns L2.

M*/
       
/*H
	Version 1       14.10.1986      R.Boeffgen
	Version 2       11.12.1989      einheitl. Version fuer MX2, MX2+, SUN
					und Apollo. PS
	Version 3	03.11.1994	MX-Version entfernt. MP
	Version 4	18.11.94	Macro nur noch im Header definiert. MP
   DATE lsred         : 890501.900101.941201
H*/
/*
	For the definition of lsred please refer to the header file _list.h.
*/
