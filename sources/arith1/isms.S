/*M
.SH NAME
isms - is modular single ?

.SH SYNOPSIS
.nf
#include<_arith1.h>

single isms(m,a)
obj m,a;

.SH DESCRIPTION
isms() returns 1 in case a is a modular single
from Z/m*Z for 0 < m < BASIS, and 0 otherwise.
M*/
/*H
	Version 1       28.11.1986      B. Weis
	Version 2       26.01.1988      B. Weis
			Funktion statt Macro
   DATE isms          : 890501.8910__
H*/

#include <_arith1.h>

single isms(m,a)
obj m,a;
{
	if (0 < m  &&  m < BASIS  &&  0 <= a  &&  a < m) return(1);
	return(0);
}
