/*M
.SH NAME
islistnns - is list of non negative singles ?

.SH SYNOPSIS
.nf
#include<_arith1.h>

single islistnns(A)
obj A;

.SH DESCRIPTION
islistnns() returns 1 in case A is an (empty) list of
non negative singles, and 0 otherwise.
M*/

/*H
	Version 1	13.03.1992	A.Stein       
   DATE islistnns     : 920331
H*/


# include <_arith1.h>

single islistnns(A)
obj A;
{
	obj a;

	if( !islist(A) ) return(0);
	while (A != _0) {
		a = lfirst(A);
		if ( !issingle(a) || a < 0 ) return(0);
		A = lred(A);
	}
	return(1);
}
