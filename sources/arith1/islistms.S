/*M
.SH NAME
islistms - is list of modular singles ?

.SH SYNOPSIS
.nf
#include<_arith1.h>

single islistms(m,A)
obj m,A;

.SH DESCRIPTION
islistms() returns  1 in case A is an (empty) list of
modular singles from Z/m*Z for m>0, and 0 otherwise.
M*/
/*H
	Version 1       27.02.1987      Pascale Serf
	Version 2       24.03.1987      Test, ob A eine Liste ist. MAR.
	Version 3       02.04.1987      komplette Neufassung. PS
	Version 4       17.08.1987      gehoert ab jetzt zur srclib.kern. MAR.
	Version 5       20.01.1988      komplette Neufassung. BW
	Version 6       16.03.1988      m jetzt vom Typ obj. PS
   DATE islistms      : 890501
H*/


# include <_arith1.h>

single islistms(m,A)
obj m,A;
{
	obj a;

	if ( !issingle(m) || m<=0 || !islist(A) ) return(0);

	while (A != _0) {
		a = lfirst(A);
		if (!issingle(a)) return(0);
		if (a < 0  ||  a >= m) return(0);
		A = lred(A);
		}
	return(1);
}
