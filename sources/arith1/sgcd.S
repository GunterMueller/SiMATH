/*M
.SH NAME
sgcd - single-precision greatest common divisor

.SH SYNOPSIS
.nf
#include<_arith1.h>

single sgcd(a,b)
single a,b;

.SH DESCRIPTION
sgcd() returns the  greatest common divisor c of a and b
for a,b >= 0. For a = b = 0 then value of c equals 0.
M*/
/*H
	Version  1      23.06.1986      R. Boeffgen
	Version  2      14.05.1987      Bedingung a >= b faellt weg.
					  P.Serf
   DATE sgcd          : 890501.8910__
H*/


# include <_arith1.h>

single sgcd ( a,b )
single a,b;
{
	single  c;

	if ( a < b ) {
		c = a; a = b; b = c;
	}
	while ( b ) {
		c = a%b;
		a=b, b=c;
	}
	return( a );
}
