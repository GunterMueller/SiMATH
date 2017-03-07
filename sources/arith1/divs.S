/*M
.SH NAME
divs - division with reference to SIMATH (MACRO)

.SH SYNOPSIS
.nf
#include<_arith1.h>

single divs(A, B)
single A, B;

.SH DESCRIPTION
divs() returns A / B for B!=0.

.SH CAUTION
divs() is implemented according of the SIMATH conventions
of "/" on the MX2(+). In case A * B < 0 and B is not
a factor of A, divs() will return (A / B) -1.
This does not conform the general standard of Kernighan-Ritchie
, which is used on SUN and Apollo. 

.SH SEE ALSO
mods
M*/

/*H
	Version 1       08.05.1989      C.Hollinger/U.Schneiders
						(SUN/Apollo-Version)
	Version 2       01.08.1989      V. Schwinn (MX2(+)-Version)
	Version 3       07.12.1989      einheitl. Version fuer MX2(+), SUN
					und Apollo. PS
	Version 4	03.11.1994	MX-Version entfernt. MP
	Version 5	18.11.94	Macro nur noch im Header definiert. MP
   DATE divs          : 890601.890801.900101.9311__.941201
H*/
/*
	For the definition of divs please refer to the header file _arith1.h.
*/
