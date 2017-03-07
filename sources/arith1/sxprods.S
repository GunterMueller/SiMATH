/*M
.SH NAME
sxprods - single XOR product special

.SH SYNOPSIS
.nf
#include<_arith1.h>

single sxprods(a,b)
single a,b;

.SH DESCRIPTION
sxprods()is identical to sxprod() except for the fact that
a,b < 2^15 are singles and the result a*b < 2^30 fits into
a single 32 bit data word.

.SH SEE ALSO
sxprod
M*/
/*H
	Version  1      06.01.1992      A.Stein
   DATE sxprods       : 920331
H*/

#include <_arith1.h>

single sxprods(a,b)
single a, b;
{
	single c = 0;
	if ( a && b ) {
		if ( b & 1 ) c ^= a;
		b >>= 1;
		while( b ) {
			a <<= 1;
			if ( b & 1 ) c ^= a;
			b >>= 1;
		}
	}
	return(c);
}
