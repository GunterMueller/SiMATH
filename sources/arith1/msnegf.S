/*M
.SH NAME
msnegf - modular single negation as function

.SH SYNOPSIS
.nf
#include<_arith1.h>

single msnegf(m,a)
single m,a;

.SH DESCRIPTION
msnegf() returns -a for m > 0 and a from Z/mZ.
msnegf() gives the same result as the macro msneg.
M*/
/*H
	Version 1       01.12.1988      Klaus Petry
   DATE msnegf        : 890501.9203__
H*/

#include <_arith1.h>

single msnegf ( m, a )
single m, a;

{
	return ( (a) ? m-a : 0 );
}
