/*M
.SH NAME
ieven - integer even

.SH SYNOPSIS
.nf
#include<_arith1.h>

single ieven(A)
int A;

.SH DESCRIPTION
ieven() returns 1 if A is even and 0 if A is odd.
M*/
/*H
	Version 1       28.7.1986               R.Boeffgen
   DATE ieven         : 890501
H*/


# include <_arith1.h>

single ieven( A )
int A;
{
	if ( isatom(A) )  return( seven(A) );
	return( seven( lfirst(A) ) );
}
