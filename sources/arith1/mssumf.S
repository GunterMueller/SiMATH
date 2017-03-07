/*M
.SH NAME
mssumf - modular single sum as function

.SH SYNOPSIS
.nf
#include<_arith1.h>

single mssumf(m,a,b)
single m,a,b;

.SH DESCRIPTION
mssumf() returns a + b for m > 0 and a,b from Z/mZ.
mssumf() has the same result as the macro mssum.
M*/
/*H
	Version 1       01.12.1988      Klaus Petry
   DATE mssumf        : 890501.9203__
H*/

#include <_arith1.h>

single mssumf (m,a,b)
single m, a, b;

{
	return((a+b)%m);
}
