/*M
.SH NAME
lred -  list reductum (MACRO)

.SH SYNOPSIS
.nf
#include<_ec3.h>

list lred(L)
list L;

.SH DESCRIPTION
lred() returns the list (a2, a3, ... , an)
obtained by removing the first element a1 
from the non-empty list L = (a1, a2, ... , an).
M*/

/*H
	Version 1       14.10.1986      R.Boeffgen
	Version 2       11.12.1989      einheitl. Version fuer MX2, MX2+, SUN
					und Apollo. PS
	Version 3	03.11.1994	MX-Version entfernt. MP
	Version 4	18.11.1994	Macro nur noch im Header definiert. MP
	Version 4	22.11.1994	Neuer Dokumentationsstandard. MP
   DATE lred          : 890501.900101.941201
H*/
/*
	For the definition of lred please refer to the header file _list.h.
*/
