/*M
.SH NAME
islists - is list of singles ?

.SH SYNOPSIS
.nf
#include<_arith1.h>

single islists(A)
obj A;

.SH DESCRIPTION
islists() returns 1 in case A is an (empty) list of
singles, and 0 otherwise.
M*/
/*H
	Version 1       29.01.1987      Pascale Serf
	Version 2       24.03.1987      islist kein Macro mehr. MAR.
	Version 3       02.04.1987      komplette Neufassung. PS
	Version 4       17.08.1987      gehoert ab jetzt zur srclib.kern. MAR.
	Version 5       20.01.1988      B. Weis
			komplette Neufassung
   DATE islists       : 890501
H*/


# include <_arith1.h>

single islists(A)
obj A;
{
	if (!islist(A)) return(0);
	while (A != _0) {
		if (!issingle(lfirst(A))) return(0);
		A = lred(A);
		}
	return(1);
}
