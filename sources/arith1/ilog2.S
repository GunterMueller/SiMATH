/*M
.SH NAME
ilog2 - integer logarithm, base 2

.SH SYNOPSIS
.nf
#include<_arith1.h>

single ilog2(A)
int A;

.SH DESCRIPTION
ilog2() returns the integer part of log2(|A|) incremented by 1
or 0 if A equals 0.
M*/

/*H
	Version  1      23.06.1986      R.Boeffgen
   DATE ilog2         : 890501
H*/


# include <_arith1.h>

single ilog2 ( A )                /* safe */
int A;
{
	if ( isatom(A) )  return(slog2(A));
	{
		single n=0;
		while ( lred(A) != _0 )  A=lred(A), n += BLOG2;
		n += slog2( lfirst(A) );
		return( n );
	}
}
