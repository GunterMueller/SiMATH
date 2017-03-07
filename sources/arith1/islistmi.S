/*M
.SH NAME
islistmi - is list of modular integers ?

.SH SYNOPSIS
.nf
#include<_arith1.h>

single islistmi(M,A)
obj M,A;

.SH DESCRIPTION
islistmi() returns 1 in case A is an (empty) list of
modular integers from Z/M*Z for M>0, and 0 otherwise.
M*/
/*H
	Version 1	13.08.91	J.Schmitt
   DATE islistmi      : 910915
H*/

# include <_arith1.h>

single islistmi(m,A)
obj m,A;
{
	obj a;

	if ( !isint(m) || icomp(m,0) <= 0 || !islist(A) ) return(0);

	while ( A != _0 ) {
		a = lfirst(A);
		if ( !ismi(m,a) ) return(0);
		A = lred(A);
	}
	return(1);
}
