/*M
.SH NAME
raval - rational additive m-adic value

.SH SYNOPSIS
.nf
#include<_arith1.h>

single raval(m,R)
single m;
rat R;

.SH DESCRIPTION
raval() returns the additive m-adic value w of R,
i.e.  w = iaval(m, numerator(R)) - iaval(m, denominator(R))
for m >=2 and R!=0.
M*/
/*H
	Version 1       16.01.1990      Christine Hollinger
	Version 2	11.12.1992	auch nicht-prime m zugelassen.  PS
   DATE raval         : 900315.930115
H*/


# include <_arith1.h>

single raval( p,R )
single p;
rat R;
{
	int z,n;
	init( z,n );
	bind( R );

	/*** R = z/n ***/

	z = lfirst( R );
	z = iaval( p,z );
	n = lsecond( R );
	n = iaval( p,n );
	z = idif( z,n );
	return( z );
}
