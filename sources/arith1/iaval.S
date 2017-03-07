/*M
.SH NAME
iaval - integer additive m-adic value

.SH SYNOPSIS
.nf
#include<_arith1.h>

single iaval(m,A)
single m;
int A;

.SH DESCRIPTION
For m>1 and A!=0
iaval() returns the additive m-adic value of A,
i.e. the maximum number w with m^w | A.
M*/

/*H
	Version 1       28.07.1988      Christine Hollinger
	Version 2       08.08.1988      Christine Hollinger
	Version 3	11.12.1992	auch nicht-prime m zugelassen.  PS
   DATE iaval         : 890501.900315.930115
H*/


# include <_arith1.h>

single iaval( p,m )
single p;
int m;
{
	single r, w;
	bind( m );

	w = -1;
	r = 0;
	while( !r )
	{       isqrem( m, p, &m, &r );
		w = w + 1;
	}
	return( w );
}
