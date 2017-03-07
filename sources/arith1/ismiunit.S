/*M
.SH NAME
ismiunit - is modular integer unit

.SH SYNOPSIS
.nf
#include<_arith1.h>

single ismiunit(M,A)
int M,A;

.SH DESCRIPTION
ismiunit() returns 1 in case A is a unit in Z/M*Z
for M>0 and A in Z/M*Z, and 0 otherwise.
M*/
/*H
	Version 1	13.08.91	J.Schmitt
   DATE ismiunit      : 910915
H*/

# include <_arith1.h>

single ismiunit(M,A)
int M,A;
{
        bind(M,A);

	if ( igcd(M,A) == 1 ) return(1);
	return(0);
}
